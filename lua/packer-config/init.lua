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
			requires = { {'nvim-lua/plenary.nvim'} }
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
        use 'mfussenegger/nvim-dap'
        use {
            'nvim-treesitter/nvim-treesitter',
            run = function()
                local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
                ts_update()
            end,
        }
        
        -- Remove the `use` here if you're using folke/lazy.nvim.
        use {
          'Exafunction/codeium.vim',
          config = function ()
            -- Change '<C-g>' here to any keycode you like.
            vim.keymap.set('i', '<Tab>', function () return vim.fn['codeium#Accept']() end, { expr = true })
            vim.keymap.set('i', '<leader>m', function() return vim.fn['codeium#CycleCompletions'](1) end, { expr = true })
            vim.keymap.set('i', '<leader>M', function() return vim.fn['codeium#CycleCompletions'](-1) end, { expr = true })
            vim.keymap.set('i', '<leader>b', function() return vim.fn['codeium#Clear']() end, { expr = true })
          end
        }

        -- vim-be-good for practice
        -- Start by opening nvim 
        -- Run `VimBeGood`
        use 'ThePrimeagen/vim-be-good'	
        --ducky type for practice
        use 'kwakzalver/duckytype.nvim'

        -- omnisharp extensions
        use 'Hoffs/omnisharp-extended-lsp.nvim'
    end
)
