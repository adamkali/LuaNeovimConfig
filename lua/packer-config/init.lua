vim.cmd [[packadd packer.nvim]]

return require'packer'.startup(
	function(use)
		use 'wbthomason/packer.nvim'
        use({
            'rose-pine/neovim',
            as = 'rose-pine',
            config = function()
                vim.cmd('colorscheme rose-pine')
            end
        })
		use 'nvim-tree/nvim-web-devicons'
		use {
  			'nvim-lualine/lualine.nvim',
			requires = { 'nvim-tree/nvim-web-devicons', opt = true }
		}
		-- NvimTree
		use {
			'nvim-tree/nvim-tree.lua',
			requires = 'nvim-tree/nvim-web-devicons',
		}

		use 'github/copilot.vim'

		use {
			'nvim-telescope/telescope.nvim', tag = '0.1.0',
-- or                            , branch = '0.1.x',
			requires = { {'nvim-lua/plenary.nvim'} }
		}
        use {
            'romgrk/barbar.nvim', 
            wants = 'nvim-web-devicons'
        }
       
        use 'neovim/nvim-lspconfig' -- Configurations for Nvim LSP
        
        use 'NvChad/nvim-colorizer.lua'
	end
)
