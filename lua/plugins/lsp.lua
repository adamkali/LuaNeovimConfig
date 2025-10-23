-- Set up LSP to have templ recognized and start the return table

vim.filetype.add({ extension = { templ = "templ" } })

return {

	-- Set up mason

	{
		"williamboman/mason.nvim",
		dependencies = {
			"williamboman/mason-lspconfig.nvim",
			"folke/neoconf.nvim",
		},
		opts = {
			ui = {
				icons = {
					package_installed = "",
					package_pending = "󱧘 ",
					package_uninstalled = "󰏗 "
				}
			}
		},
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = {
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
		},
	},
	{
		"jmbuhr/otter.nvim"
	},
}

