vim.cmd [[packadd packer.nvim]]

return require'packer'.startup(
	function(use)
		use 'wbthomason/packer.nvim'
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
		use {
            "nvim-telescope/telescope.nvim",
            requires = { 
                {'nvim-lua/plenary.nvim'} 
            }
		}
        use 'neovim/nvim-lspconfig' -- Configurations for Nvim LSP
        use 'hrsh7th/cmp-nvim-lsp'
        use 'hrsh7th/cmp-buffer'
        use 'hrsh7th/cmp-path'
        use 'hrsh7th/cmp-cmdline'
        use 'hrsh7th/nvim-cmp'
        use 'windwp/nvim-autopairs'
        use 'L3MON4D3/LuaSnip'
        use 'saadparwaiz1/cmp_luasnip'

        use {'romgrk/barbar.nvim', wants = 'nvim-web-devicons'}
        use 'NvChad/nvim-colorizer.lua'

        use 'rktjmp/lush.nvim'
        use 'adamkali/vaporlush'

        use 'simrat39/rust-tools.nvim'  -- Rust Functionality
        use 'nvim-lua/plenary.nvim' -- plenary :)
        use {
            'nvim-treesitter/nvim-treesitter',
            run = function()
                local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
                ts_update()
            end,
        }


        use {
            "williamboman/mason.nvim",
        }
        use "williamboman/mason-lspconfig.nvim"


        -- vim-be-good for practice
        -- Start by opening nvim 
        -- Run `VimBeGood`
        use 'ThePrimeagen/vim-be-good'	
        --ducky type for practice
        use 'kwakzalver/duckytype.nvim'

        -- omnisharp extensions
        use 'Hoffs/omnisharp-extended-lsp.nvim'

        use {
            "zbirenbaum/copilot.lua",
            cmd = "Copilot",
            event = "InsertEnter",
            config = function()
              require("copilot").setup({
                    suggestion = {
                        enabled = true,
                        auto_trigger = true,
                        debounce = 75,
                        keymap = {
                          accept = "<M-s>",
                          accept_word = false,
                          accept_line = false,
                          next = "<M-r>",
                          prev = "<M-R>",
                          dismiss = "<C-]>",
                        },
                    },
                })
            end,
        }

        use "tpope/vim-fugitive"
    end
)
