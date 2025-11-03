-- Default Keybindings

local on_attatch = function(client, bufnr)
	-- Enable inlay hints if supported
	if client.supports_method("textDocument/inlayHint") then
		vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
	end

	local wk = require 'which-key'
	wk.add {
		{ "<BS>",  expr = false,                                group = "LSP Generic",         nowait = false, remap = true },
		{ "<BS>c", function() vim.lsp.buf.code_action() end,    desc = 'Code action',          expr = false,   nowait = false, remap = true },
		{ "<BS>D", function() vim.lsp.buf.declaration() end,    desc = "Go to declaration",    expr = false,   nowait = false, remap = true },
		{ "<BS>k", function() vim.lsp.buf.hover() end,          desc = "Show Hover Actions",   expr = false,   nowait = false, remap = true },
		{ "<BS>R", function() vim.lsp.buf.references() end,     desc = "Find References",      expr = false,   nowait = false, remap = true },
		{ "<BS>d", function() vim.lsp.buf.definition() end,     desc = "Go to definition",     expr = false,   nowait = false, remap = true },
		{ "<BS>i", function() vim.lsp.buf.implementation() end, desc = "Go to implementation", expr = false,   nowait = false, remap = true },
		{ "<BS>r", function() vim.lsp.buf.rename() end,         desc = "Rename File",          expr = false,   nowait = false, remap = true },
		{
			"<BS>s",
			function()
				vim.diagnostic.goto_prev({ popup_opts = { border = "rounded", focusable = false } })
			end,
			desc = "Go to previous diagnostic",
			expr = false,
			nowait = false,
			remap = true
		},
		{
			"<BS>a",
			function()
				vim.diagnostic.goto_next({ popup_opts = { border = "rounded", focusable = false } })
			end,
			desc = "Go to next diagnostic",
			expr = false,
			nowait = false,
			remap = true
		},
	}
end

-- Configure the servers here

local servers = {
	"lua_ls",
	"gopls",
	"ts_ls",
	"docker_compose_language_service",
	"dockerls",
	"clangd",
	"html",
	"svelte",
	"marksman",
	"tailwindcss",
	"sqlls",
	"elixirls",
	"templ",
	"pyright",
	"somesass_ls",
	"hls",
	"cssls",
	"texlab",
	"rust_analyzer",
}
require("mason-lspconfig").setup {
	ensure_installed = servers,
	automatic_installation = false
}
local capabilities = require('blink.cmp').get_lsp_capabilities()
for _, value in ipairs(servers) do
	vim.lsp.enable(value)
	vim.lsp.config(value, { on_attach = on_attatch, capabilities = capabilities })
end

vim.lsp.enable("gleam")
vim.lsp.config("gleam", { on_attach = on_attatch, capabilities = capabilities })

vim.lsp.enable("html")
vim.lsp.config("html", { on_attach = on_attatch, capabilities = capabilities, filetypes = { "html", "templ" } })

vim.lsp.enable("htmx")
vim.lsp.config("htmx", { on_attach = on_attatch, capabilities = capabilities, filetypes = { "html", "templ" } })

vim.lsp.enable("tailwindcss")
vim.lsp.config("tailwindcss", {
	on_attach = on_attatch,
	capabilities = capabilities,
	filetypes = { "templ", "astro", "javascript", "typescript", "react", "svelte" },
	settings = {
		tailwindCSS = {
			includeLanguages = {
				templ = "html",
			},
		},
	},
})

vim.lsp.enable("csharp_ls")
vim.lsp.config("csharp_ls", {
	on_attach = on_attatch,
	capabilities = capabilities,
	settings = {
		csharp = {
			enableRoslynAnalyzers = true,
			enableImportCompletion = true,
			organizeImportsOnFormat = true,
			enableDecompilationSupport = true,
		}
	},
	filetypes = { 'cs', 'vb', 'csproj', 'sln', 'slnx', 'props', 'csx', 'targets' }
})

-- Configure gopls with inlay hints
vim.lsp.config("gopls", {
	on_attach = on_attatch,
	capabilities = capabilities,
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
})


--	"jsonls",
--	"yamlls",
vim.lsp.config("yamlls", {
	on_attach = on_attatch,
	capabilities = capabilities,
	settings = {
		yaml = {
			schemaStore = {
				enable = false,
				url = "",
			},
			schemas = require("schemastore").yaml.schemas(),

		},
	}
})
vim.lsp.config("jsonls", {
	on_attach = on_attatch,
	capabilities = capabilities,
	settings = {
		json = {
			schemas = require('schemastore').json.schemas(),
			validate = { enable = true },
		},
	},
})

-- Override ts_ls with performance optimizations
vim.lsp.config("ts_ls", {
	on_attach = on_attatch,
	capabilities = capabilities,
	settings = {
		typescript = {
			inlayHints = {
				includeInlayParameterNameHints = "none",
				includeInlayParameterNameHintsWhenArgumentMatchesName = false,
				includeInlayFunctionParameterTypeHints = false,
				includeInlayVariableTypeHints = false,
				includeInlayPropertyDeclarationTypeHints = false,
				includeInlayFunctionLikeReturnTypeHints = false,
				includeInlayEnumMemberValueHints = false,
			},
			preferences = {
				disableSuggestions = false,
				includeCompletionsForModuleExports = false,
			},
			format = {
				enable = false, -- Use prettier instead
			},
			suggest = {
				autoImports = false, -- Disable auto-imports for performance
			},
		},
		javascript = {
			inlayHints = {
				includeInlayParameterNameHints = "none",
				includeInlayParameterNameHintsWhenArgumentMatchesName = false,
				includeInlayFunctionParameterTypeHints = false,
				includeInlayVariableTypeHints = false,
				includeInlayPropertyDeclarationTypeHints = false,
				includeInlayFunctionLikeReturnTypeHints = false,
				includeInlayEnumMemberValueHints = false,
			},
			preferences = {
				disableSuggestions = false,
				includeCompletionsForModuleExports = false,
			},
			format = {
				enable = false,
			},
			suggest = {
				autoImports = false,
			},
		},
	},
	init_options = {
		hostInfo = "neovim",
		maxTsServerMemory = 4096, -- Limit memory to 4GB
		preferences = {
			includeCompletionsForModuleExports = false,
			includeCompletionsWithInsertText = false,
		},
		typescript = {
			preferences = {
				includePackageJsonAutoImports = "off",
			},
		},
	},
})
