vim.cmd [[packadd packer.nvim]]

return require 'packer'.startup(
	function(use)
		use 'wbthomason/packer.nvim'
		use 'nvim-tree/nvim-web-devicons'
		use {
  			'nvim-lualine/lualine.nvim',
			requires = { 'nvim-tree/nvim-web-devicons', opt = true }
		}
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
        use {'romgrk/barbar.nvim', wants = 'nvim-web-devicons'}
        use 'NvChad/nvim-colorizer.lua'
        use 'rktjmp/lush.nvim'
        use 'adamkali/vaporlush'
        use 'nvim-lua/plenary.nvim' -- plenary :)
        use {
            'nvim-treesitter/nvim-treesitter',
            run = function()
                local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
                ts_update()
            end,
        }
        use 'ThePrimeagen/vim-be-good'	
        use 'kwakzalver/duckytype.nvim'
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
        use {
            'VonHeikemen/lsp-zero.nvim',
            branch = 'v2.x',
            dependencies = {
                -- LSP Support
                {'neovim/nvim-lspconfig'},             -- Required
                {'williamboman/mason.nvim'},           -- Optional
                {'williamboman/mason-lspconfig.nvim'}, -- Optional

                -- Autocompletion
                {'hrsh7th/nvim-cmp'},     -- Required
                {'hrsh7th/cmp-nvim-lsp'}, -- Required
                {'L3MON4D3/LuaSnip'},     -- Required
            }
        }


        use 'simrat39/rust-tools.nvim'  -- Rust Functionality

    end
)
