return {
    {
        "adamkali/vaporlush",
        dependencies = { "rktjmp/lush.nvim" },
        lazy = false,
        name = "vaporlush",
        priority = 1000,
        config = function()
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
            vim.cmd([[colorscheme fluoromachine]])
        end
    }
}
