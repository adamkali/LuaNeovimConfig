return {
    {
        dir = "~/git/vaporlush",
        --"adamkali/vaporlush",
        --branch = "v2",
        lazy = false,
        priority = 1000,
        config = function()
            require'vaporlush'.setup{
                style = "vapor",
                cache = true,
            }
            vim.cmd([[colorscheme vapor]])
        end
    },
    {
        "catppuccin/nvim", name = "catppuccin", priority = 1000
    },
    {
        'norcalli/nvim-colorizer.lua',
        config = function()
            require('colorizer').setup()
        end
    }
}
