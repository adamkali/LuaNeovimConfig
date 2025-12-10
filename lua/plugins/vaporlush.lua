vim.opt.termguicolors = true
return {
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		opts = {
			style = "night",
			transparent = true,
			lualine_bold = true,
		},
	},
	{
		"eldritch-theme/eldritch.nvim",
		lazy = false,
		priority = 1000,
		opts = {
			transparent = true,
			styles = {
				comments = { italic = true },
				keywords = { italic = true },
			}
		},
	},
	{
		--dir = "~/git/vaporlush",
		"adamkali/vaporlush",
		branch = "v2",
		lazy = false,
		priority = 1000,
		opts = {
			transparent = false,
			cache = true,
		}
	},
	{
		"adamkali/axolotl.nvim",
		-- dir = "~/projects/axolotl.nvim",
		lazy = false,
		priority = 1000,
		opts = {
			style = "night",
			transparent = true,
			styles = {
				comments = { italic = true },
				keywords = { italic = true },
			},
			lualine_bold = true,
		},
	},
	{
		'nvim-lualine/lualine.nvim',
	},
	{
		'norcalli/nvim-colorizer.lua',
		config = function()
			require('colorizer').setup()
		end
	}
}
