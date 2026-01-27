-- Set up LSP to have templ recognized and start the return table
--
local go_to_jump_options = {
	popup_opts = {
		border = "rounded",
		focusable = true,
	},


}
local go_to_prev = function()
	vim.diagnostic.goto_prev(go_to_jump_options)
end
local go_to_next = function()
	vim.diagnostic.goto_next(go_to_jump_options)
end

local on_attatch = function(client, bufnr)
	local wk = require 'which-key'
	wk.add {
		{ "<BS>",  expr = false,                   group = "LSP Generic",              nowait = false, remap = true },
		{ "<BS>c", vim.lsp.buf.code_action,        desc = 'Code action',               expr = false,   nowait = false, remap = true },
		{ "<BS>h", vim.lsp.buf.document_highlight, desc = 'Code action',               expr = false,   nowait = false, remap = true },
		{ "<BS>D", vim.lsp.buf.declaration,        desc = "Go to declaration",         expr = false,   nowait = false, remap = true },
		{ "<BS>k", vim.lsp.buf.hover,              desc = "Show Hover Actions",        expr = false,   nowait = false, remap = true },
		{ "<BS>R", vim.lsp.buf.references,         desc = "Find References",           expr = false,   nowait = false, remap = true },
		{ "<BS>d", vim.lsp.buf.definition,         desc = "Go to definition",          expr = false,   nowait = false, remap = true },
		{ "<BS>i", vim.lsp.buf.implementation,     desc = "Go to implementation",      expr = false,   nowait = false, remap = true },
		{ "<BS>r", vim.lsp.buf.rename,             desc = "Rename File",               expr = false,   nowait = false, remap = true },
		{ "<BS>s", go_to_prev,                     desc = "Go to previous diagnostic", expr = false,   nowait = false, remap = true },
		{ "<BS>a", go_to_next,                     desc = "Go to next diagnostic",     expr = false,   nowait = false, remap = true },
	}
end

local capabilities = require('blink.cmp').get_lsp_capabilities()

vim.filetype.add({ extension = { templ = "templ" } })

return {

	-- Set up mason

	{
		"williamboman/mason.nvim",
		dependencies = {
			"folke/neoconf.nvim",
		},
		opts = {
			ui = {
				icons = {
					package_installed = " ",
					package_pending = "󰏖 ",
					package_uninstalled = "󰏗 "
				}
			}
		},
	},
	{
		"Decodetalkers/csharpls-extended-lsp.nvim"
	},
	{
		"neovim/nvim-lspconfig",
		enabled = false, -- Disable lspconfig entirely, use pure native API
	},
	{
		"dummy-lsp-config",
		dir = vim.fn.stdpath("config"),
		config = function()
			-- Create LspInfo command replacement
			vim.api.nvim_create_user_command('LspInfo', function()
				local clients = vim.lsp.get_clients({ bufnr = 0 })
				if #clients == 0 then
					print("No LSP clients attached to current buffer")
					return
				end
				print("LSP clients for current buffer:")
				for _, client in ipairs(clients) do
					print(string.format("  - %s (id: %d)", client.name, client.id))
				end
			end, {})


			-- Svelte
			-- hack for svelte-language-server watcher doesn't work in neovim lspconfig #2008
			-- https://github.com/sveltejs/language-tools/issues/2008
			-- nvim_lsp.svelte.setup {
				--   filetypes = { "svelte" },
				--   on_attach = function(client, bufnr)
					--     if client.name == 'svelte' then
					--       vim.api.nvim_create_autocmd("BufWritePost", {
						--         pattern = { "*.js", "*.ts", "*.svelte" },
						--         callback = function(ctx)
							--           client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.file })
							--         end,
							--       })
							--     end
							--     if vim.bo[bufnr].filetype == "svelte" then
							--       vim.api.nvim_create_autocmd("BufWritePost", {
								--         pattern = { "*.js", "*.ts", "*.svelte" },
								--         callback = function(ctx)
									--           client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.file })
									--         end,
									--       })
									--     end
									--   end
									-- }


									-- All servers to configure
									local servers = {
										"lua_ls", "gopls", "csharp_ls", "docker_compose_language_service",
										"dockerls", "clangd", "html", "svelte", "marksman",
										"tailwindcss", "sqlls", "elixirls", "templ", "pyright",
										"somesass_ls", "hls", "cssls", "texlab", "rust_analyzer", "fish_lsp", "jsonls", "yamlls",
										"kulala_ls", "gleam"
									}

									-- Base server configurations (cmd + filetypes)
									local server_configs = {
										lua_ls = { cmd = { "lua-language-server" }, filetypes = { "lua" } },
										gopls = { cmd = { "gopls" }, filetypes = { "go", "gomod", "gowork", "gotmpl" } },
										csharp_ls = { cmd = { "csharp-ls" }, filetypes = { "cs" } },
										clangd = { cmd = { "clangd" }, filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" } },
										pyright = { cmd = { "pyright-langserver", "--stdio" }, filetypes = { "python" } },
										rust_analyzer = { cmd = { "rust-analyzer" }, filetypes = { "rust" } },
										jsonls = { cmd = { "vscode-json-language-server", "--stdio" }, filetypes = { "json", "jsonc" } },
										yamlls = { cmd = { "yaml-language-server", "--stdio" }, filetypes = { "yaml", "yaml.docker-compose" } },
										html = { cmd = { "vscode-html-language-server", "--stdio" }, filetypes = { "html" } },
										cssls = { cmd = { "vscode-css-language-server", "--stdio" }, filetypes = { "css", "scss", "less" } },
										tailwindcss = { cmd = { "tailwindcss-language-server", "--stdio" }, filetypes = { "html", "css", "javascript", "typescript" } },
										svelte = {
											cmd = { "svelteserver", "--stdio" },
											cmd_env = { CHOKIDAR_USEPOLLING = "1" },
											filetypes = { "svelte" },
											root_dir = function(bufnr, on_dir)
												local fname = vim.api.nvim_buf_get_name(bufnr)
												if vim.uv.fs_stat(fname) ~= nil then
													local root_markers = { 'package-lock.json', 'yarn.lock', 'pnpm-lock.yaml', 'bun.lockb', 'bun.lock', 'deno.lock' }
													root_markers = vim.fn.has('nvim-0.11.3') == 1 and { root_markers, { '.git' } }
													or vim.list_extend(root_markers, { '.git' })
													-- We fallback to the current working directory if no project root is found
													local project_root = vim.fs.root(bufnr, root_markers) or vim.fn.getcwd()
													on_dir(project_root)
												end
											end,
										},
									}

									-- Custom settings for specific servers (merged with base config)
									local custom_settings = {
										csharp_ls = {
											handlers = {
												["textDocument/definition"] = require('csharpls_extended').handler,
												["textDocument/typeDefinition"] = require('csharpls_extended').handler,
											},
											settings = {
												csharp = {
													enableRoslynAnalyzers = true,
													enableImportCompletion = true,
													organizeImportsOnFormat = true,
													enableDecompilationSupport = true,
												}
											},
										},
										gopls = {
											settings = {
												gopls = {
													hints = {
														assignVariableTypes = true,
														compositeLiteralFields = true,
														compositeLiteralTypes = true,
														constantValues = true,
														functionTypeParameters = true,
														parameterNames = true,
														rangeVariableTypes = true,
													},
												},
											},
										},
										ts_ls = {
											settings = {
												typescript = {
													inlayHints = { includeInlayParameterNameHints = "none" },
													preferences = { disableSuggestions = false },
													format = { enable = false },
													suggest = { autoImports = false },
												},
											},
										},
										svelte = {
											settings = {
												svelte = {
													format = {
														script = "",
														style = "prettier",
													},
												},
											},
										},
										tailwindcss = {
											filetypes = { "templ", "astro", "javascript", "typescript", "react", "svelte", "html" },
											settings = {
												tailwindCSS = {
													includeLanguages = { templ = "html" },
												},
											},
										},
										yamlls = {
											settings = {
												yaml = {
													schemaStore = { enable = false, url = "" },
													schemas = require("schemastore").yaml.schemas(),
												},
											}
										},
										jsonls = {
											settings = {
												json = {
													schemas = require('schemastore').json.schemas(),
													validate = { enable = true },
												},
											},
										},
									}

									-- Configure all servers in one loop
									for _, server_name in ipairs(servers) do
										local base_config = server_configs[server_name]
										if base_config then
											-- Start with base config (copy all fields)
											local config = {
												on_attach = on_attatch,
												capabilities = capabilities,
											}
											for key, value in pairs(base_config) do
												config[key] = value
											end

											-- Merge custom settings if they exist
											if custom_settings[server_name] then
												for key, value in pairs(custom_settings[server_name]) do
													config[key] = value
												end
											end

											-- Config must be set before enable
											vim.lsp.config(server_name, config)
											vim.lsp.enable(server_name)
										end
									end
								end,
							},
							{
								"folke/lazydev.nvim",
								ft = "lua", -- only load on lua files
								opts = {
									library = {
										-- Library paths can be absolute
										"~/git/vaporlush/lua/vaporlush",
										-- Or relative, which means they will be resolved from the plugin dir.
										"lazy.nvim",
										{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
										{ path = "LazyVim",            words = { "LazyVim" } },
									},
									-- always enable unless `vim.g.lazydev_enabled = false`
									-- This is the default
									enabled = function(_)
										return vim.g.lazydev_enabled == nil and true or vim.g.lazydev_enabled
									end,
								},
							},
							{
								"jmbuhr/otter.nvim"
							},
							{
								"b0o/schemastore.nvim"
							},
							{
								"pmizio/typescript-tools.nvim",
								dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
								opts = {
									settings = {
										tsserver_file_preferences = {
											includeInlayParameterNameHints = "all",
											includeCompletionsForModuleExports = true,
											quotePreference = "auto",
										}

									},
									on_attach = on_attatch,
									capabilities = capabilities

								},
							},
							{
								"benlubas/neorg-interim-ls",
								ft = "norg",
								config = function()
									local wk = require 'which-key'
									wk.add {
										{ "<BS>",  expr = false,               group = "LSP Generic",              nowait = false, remap = true },
										{ "<BS>c", vim.lsp.buf.code_action,    desc = 'Code action',               expr = false,   nowait = false, remap = true },
										{ "<BS>D", vim.lsp.buf.declaration,    desc = "Go to declaration",         expr = false,   nowait = false, remap = true },
										{ "<BS>k", vim.lsp.buf.hover,          desc = "Show Hover Actions",        expr = false,   nowait = false, remap = true },
										{ "<BS>R", vim.lsp.buf.references,     desc = "Find References",           expr = false,   nowait = false, remap = true },
										{ "<BS>d", vim.lsp.buf.definition,     desc = "Go to definition",          expr = false,   nowait = false, remap = true },
										{ "<BS>i", vim.lsp.buf.implementation, desc = "Go to implementation",      expr = false,   nowait = false, remap = true },
										{ "<BS>r", vim.lsp.buf.rename,         desc = "Rename File",               expr = false,   nowait = false, remap = true },
										{ "<BS>s", vim.diagnostic.get_next,    desc = "Go to previous diagnostic", expr = false,   nowait = false, remap = true },
										{ "<BS>a", vim.diagnostic.get_prev,    desc = "Go to next diagnostic",     expr = false,   nowait = false, remap = true },
									}
								end
							}

						}
