-- Make sure that this setting is always on

vim.opt.termguicolors = true
return {

-- [folke/tokyonight.nvim]{https://github.com/folke/tokyonight.nvim}

    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        opts = {
            style = "night",
            transparent = true,
            lualine_bold = true,
        },
    },

-- [adamkali/vaporlush]{https://github.com/adamkali/vaporlush}

    {
        "adamkali/vaporlush",
        branch = "v2",
        lazy = false,
        priority = 1000,
        opts = {
            cache = true,
            transparent = true
        }
    },

-- [eldritch-theme/eldritch.nvim]{https://github.com/eldritch-theme/eldritch.nvim}

    {
        "eldritch-theme/eldritch.nvim",
        lazy = false,
        priority = 1000,
        opts = {
            transparent = true,
            styles = {
                comments = { italic = true },
                keywords = { italic = true },
            }
        },
    },
}
