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


			-- All servers to configure
			local servers = {
				"lua_ls", "gopls", "csharp_ls", "docker_compose_language_service",
				"dockerls", "clangd", "html", "svelte", "marksman", "tailwindcss",
				"sqlls", "elixirls", "templ", "pyright", "somesass_ls", "hls",
				"cssls", "texlab", "rust_analyzer", "fish_lsp", "jsonls", "yamlls",
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
					vim.lsp.enable(server_name)

					-- Start with base config
					local config = {
						cmd = base_config.cmd,
						filetypes = base_config.filetypes,
						on_attach = on_attatch,
						capabilities = capabilities,
					}

					-- Merge custom settings if they exist
					if custom_settings[server_name] then
						for key, value in pairs(custom_settings[server_name]) do
							config[key] = value
						end
					end

					vim.lsp.config(server_name, config)
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
