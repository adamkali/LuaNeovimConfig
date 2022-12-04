vim.cmd [[packadd packer.nvim]]

return require'packer'.startup(
	function(use)
		use 'wbthomason/packer.nvim'

		--Use Katagawa's colorscheme
		use "rebelot/kanagawa.nvim"
		use 'nvim-tree/nvim-web-devicons'
		use {
  			'nvim-lualine/lualine.nvim',
			requires = { 'kyazdani42/nvim-web-devicons', opt = true }
		}
		-- NvimTree
		use {
			'nvim-tree/nvim-tree.lua',
			requires = 'kyazdani42/nvim-web-devicons',
			tag = 'nightly' -- optional, updated every week. (see issue #1193)
		}

		use 'github/copilot.vim'

		use {
			'nvim-telescope/telescope.nvim', tag = '0.1.0',
-- or                            , branch = '0.1.x',
			requires = { {'nvim-lua/plenary.nvim'} }
		}
	end
)
