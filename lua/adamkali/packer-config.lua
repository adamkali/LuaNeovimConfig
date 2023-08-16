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
        use 'williamboman/mason.nvim'
        use 'williamboman/mason-lspconfig.nvim'
        use 'hrsh7th/nvim-cmp'
        use 'hrsh7th/cmp-nvim-lsp'
        use 'L3MON4D3/LuaSnip'
        use 'neovim/nvim-lspconfig'
        use 'hrsh7th/cmp-buffer'
        use 'hrsh7th/cmp-path'
        use 'hrsh7th/cmp-cmdline'
        use "tpope/vim-fugitive"
        use 'VonHeikemen/lsp-zero.nvim'
        use 'Ciel-MC/rust-tools.nvim'
        use 'mfussenegger/nvim-dap'
        use "jay-babu/mason-nvim-dap.nvim"
        use 'jose-elias-alvarez/typescript.nvim'
        use {
          "folke/which-key.nvim",
          config = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
          end
        }
        use({
            "epwalsh/obsidian.nvim",
            requires = { "nvim-lua/plenary.nvim" },
            config = function()
                require("obsidian").setup({
                    -- dir = "p:\\My Mind",
                    dir = "C:\\src\\projects\\My_Second_Mind",
                    templates = {
                        subdir = "templates",
                        date_format = "%Y-%m-%d-%a",
                        time_format = "%H:%M",
                    }
                })
            end,
        })
    end
)
