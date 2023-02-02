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
			'nvim-telescope/telescope.nvim', tag = '0.1.0',
-- or                            , branch = '0.1.x',
			requires = { {'nvim-lua/plenary.nvim'} }
		}
       
        use 'neovim/nvim-lspconfig' -- Configurations for Nvim LSP
        use 'hrsh7th/cmp-nvim-lsp'
        use 'hrsh7th/cmp-buffer'
        use 'hrsh7th/cmp-path'
        use 'hrsh7th/cmp-cmdline'
        use 'hrsh7th/nvim-cmp'

        use 'L3MON4D3/LuaSnip'
        use 'saadparwaiz1/cmp_luasnip'

        use {'romgrk/barbar.nvim', wants = 'nvim-web-devicons'}
        use 'NvChad/nvim-colorizer.lua'

        use 'rktjmp/lush.nvim'
        use 'adamkali/vaporlush'

        use("simrat39/rust-tools.nvim")  -- Rust Functionality
        use {
            'nvim-treesitter/nvim-treesitter',
            run = function()
                local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
                ts_update()
            end,
        }
        
        -- vim-be-good for practice
        -- Start by opening nvim 
        -- Run `VimBeGood`
        use 'ThePrimeagen/vim-be-good'	
        --ducky type for practice
        use 'kwakzalver/duckytype.nvim'
        use({
            "lmburns/lf.nvim",
            config = function()
                -- This feature will not work if the plugin is lazy-loaded
                vim.g.lf_netrw = 1

                require("lf").setup(
                {
                    escape_quit = false,
                    border = "rounded",
                    highlights = {FloatBorder = {guifg = require("kimbox.palette").colors.magenta}}
                }
                )

                vim.keymap.set("n", "<C-o>", ":Lf<CR>")
            end,
            requires = {"plenary.nvim", "toggleterm.nvim"}
        })
    end
)
