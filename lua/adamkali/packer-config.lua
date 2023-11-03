
vim.cmd [[packadd packer.nvim]]

return require 'packer'.startup(
	function(use)
		use 'wbthomason/packer.nvim'

        -- organization
		use 'nvim-tree/nvim-web-devicons'
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
        use 'nvim-lua/plenary.nvim' -- plenary :)
        use {
            'nvim-treesitter/nvim-treesitter',
            run = function()
                local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
                ts_update()
            end,
        }
        use "tpope/vim-fugitive"


        -- colors
		use {
  			'nvim-lualine/lualine.nvim',
			requires = { 'nvim-tree/nvim-web-devicons', opt = true }
		}
        use 'NvChad/nvim-colorizer.lua'
        use 'rktjmp/lush.nvim'
        use 'adamkali/vaporlush'

        use 'ThePrimeagen/vim-be-good'
        use 'kwakzalver/duckytype.nvim'

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

        -- lsp
        use 'williamboman/mason.nvim'
        use 'williamboman/mason-lspconfig.nvim'
        use 'VonHeikemen/lsp-zero.nvim'

        -- dap 💨
        use 'mfussenegger/nvim-dap'

        -- lsp extensions
        use 'hrsh7th/nvim-cmp'
        use 'hrsh7th/cmp-nvim-lsp'
        use 'L3MON4D3/LuaSnip'
        use 'neovim/nvim-lspconfig'
        use 'hrsh7th/cmp-buffer'
        use 'hrsh7th/cmp-path'
        use 'hrsh7th/cmp-cmdline'
        use 'Ciel-MC/rust-tools.nvim'
        use 'jose-elias-alvarez/typescript.nvim'
        use 'Hoffs/omnisharp-extended-lsp.nvim'
        use 'jose-elias-alvarez/null-ls.nvim'
        use {
          "folke/which-key.nvim",
          config = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
          end
        }

        -- lint 
        use 'MunifTanjim/eslint.nvim'
        use 'MunifTanjim/prettier.nvim'

        use({
            "epwalsh/obsidian.nvim",
            requires = { "nvim-lua/plenary.nvim" },
            config = function()
            end,
        })
    end
)
