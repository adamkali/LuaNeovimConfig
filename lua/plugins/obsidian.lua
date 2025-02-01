local visual_opts = {
    mode = "n",     -- NORMAL mode
    silent = true,  -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = false, -- use `nowait` when creating keymaps
    expr = true,    -- use `expr` when creating keymaps
}

return {
    {
        "epwalsh/obsidian.nvim",
        ft = { 'md' },
        opts = function()
            return {
                --dir = "C:\\src\\projects\\My_Second_Mind", -- Laptop
                -- dir = "~/notes/My_Second_Mind",
                dir = "/mnt/c/Users/adam/Documents/notes/My_Second_Mind",
                --dir = "~/me", -- Arch Laptop and Desktop
                templates = {
                    subdir = "templates",
                    date_format = "%Y-%m-%d-%a",
                    time_format = "%H:%M",
                },
                notes_subdir = "notes",
                disable_frontmatter = true,

                -- Optional, set the log level for obsidian.nvim. This is an integer corresponding to one of the log
                -- levels defined by "vim.log.levels.*".
                log_level = vim.log.levels.INFO,

                daily_notes = {
                    folder = "05  Dailies",
                    date_format = "%Y-%m-%d",
                    alias_format = "%B %-d, %Y",
                    default_tags = { "daily-notes" },
                    template = "dailies-template.md"
                },
                ui = {
                    enable = true,         -- set to false to disable all additional syntax features
                    update_debounce = 150, -- update delay after a text change (in milliseconds)
                    reference_text = { hl_group = "ObsidianRefText" },
                    highlight_text = { hl_group = "ObsidianHighlightText" },
                    tags = { hl_group = "ObsidianTag" },
                    checkboxes = {
                        [" "] = { char = "󰄱", hl_group = "ObsidianTodo" },
                        ["x"] = { char = "󰔓", hl_group = "ObsidianDone" },
                        [">"] = { char = "󰭻", hl_group = "ObsidianRightArrow" },
                        ["~"] = { char = "󱜸", hl_group = "ObsidianTilde" },
                        ["!"] = { char = "󰭺", hl_group = "ObsidianImportant" },
                        --- custom ---
                        ["n"] = { char = "", hl_group = "DiagnosticError"},
                    }
                }
            }
        end,
        keys = {
            -- { '=d', '<cmd>:ObsidianFollowLink<CR>', desc = 'Go To' },
            { '=v', '<cmd>:ObsidianFollowLink vsplit<CR>', desc = 'Split vertically' },
            { '=V', '<cmd>:ObsidianFollowLink hsplit<CR>', desc = 'Split horizontally' },
            { '=b', '<cmd>:ObsidianBacklinks<CR>',         desc = 'Show Back Links' },
            { '==', '<cmd>:ObsidianToday<CR>',             desc = 'Open Today' },
            { '=N', '<cmd>:ObsidianYesterday<CR>',         desc = 'Open Yesterday' },
            { '=n', '<cmd>:ObsidianTomorrow<CR>',          desc = 'Open Yesterday' },
            { '=T', '<cmd>:ObsidianTemplate<CR>',          desc = 'Use Template' },
            { '=h', '<cmd>:ObsidianSearch<CR>',            desc = 'Search' },
        }
    },
    {
        'MeanderingProgrammer/render-markdown.nvim',
        dependencies = {
            'nvim-treesitter/nvim-treesitter',
            'nvim-web-devicons'
        },
        config = function()
            require('obsidian').get_client().opts.ui.enable = false
            vim.api.nvim_buf_clear_namespace(0, vim.api.nvim_get_namespaces()['ObsidianUI'], 0, -1)
            vim.api.nvim_set_hl(0, "RenderMarkdownH1", { fg = "#fffff0", bg = "#222aef" })
            vim.api.nvim_set_hl(0, "RenderMarkdownH2", { fg = "#ffffff", bg = "#722aef" })
            vim.api.nvim_set_hl(0, "RenderMarkdownH3", { fg = "#ffffff", bg = "#de32de" })
            vim.api.nvim_set_hl(0, "RenderMarkdownH1Bg", { fg = "#fffff0", bg = "#222aef" })
            vim.api.nvim_set_hl(0, "RenderMarkdownH2Bg", { fg = "#ffffff", bg = "#722aef" })
            vim.api.nvim_set_hl(0, "RenderMarkdownH3Bg", { fg = "#ffffff", bg = "#de32de" })
            require('render-markdown').setup({
                heading = {
                    icons = { '󰎤 ', '󰎧 ', '󰎪 ', '󰎭 ', '󰎱 ', '󰎳 ' },
                    signs = { '󰶻 ' },
                },
            })
        end
    }
}
