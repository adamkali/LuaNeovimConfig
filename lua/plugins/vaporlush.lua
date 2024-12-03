return {
    {
        dir = '/home/adamkali/git/vaporlush',
        dependencies = { "rktjmp/lush.nvim" },
        lazy = false,
        name = "vaporlush",
        priority = 1000,
        config = function()
            require 'vaporlush'.setup {
                cache = true,
                style = "vapor",
            }
            vim.cmd([[colorscheme vapor]])
        end
    },
    {
        "catppuccin/nvim", name = "catppuccin", priority = 1000
    },
    {
        'maxmx03/fluoromachine.nvim',
        lazy = false,
        priority = 1000,
        config = function()
            local fm = require 'fluoromachine'

            fm.setup {
                glow = true,
                theme = 'fluoromachine',
                transparent = false,
                plugins = {
                    neotree = false,
                }
            }
        end
    },
    {
        "scottmckendry/cyberdream.nvim",
        lazy = false,
        priority = 1000,
    },
    {
        'norcalli/nvim-colorizer.lua',
        config = function()
            require('colorizer').setup()
        end
    }
}
