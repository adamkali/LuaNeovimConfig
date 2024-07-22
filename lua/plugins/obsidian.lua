local visual_opts = {
  mode = "n", -- NORMAL mode
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = false, -- use `nowait` when creating keymaps
  expr = true, -- use `expr` when creating keymaps
}

return {
    "epwalsh/obsidian.nvim",
    ft = { 'md' },
    opts = function ()
        return {
            dir = "C:\\src\\projects\\My_Second_Mind", -- Laptop
            --dir = "P:\\
            --dir = "~/me", -- Arch Laptop and Desktop
            templates = {
                subdir = "templates",
                -- subdir = "templates",
                date_format = "%Y-%m-%d-%a",
                time_format = "%H:%M",
            },

            ui = {
                enable = true,  -- set to false to disable all additional syntax features
                update_debounce = 200,  -- update delay after a text change (in milliseconds)
                -- Define how various check-boxes are displayed
                reference_text = { hl_group = "ObsidianRefText" },
                highlight_text = { hl_group = "ObsidianHighlightText" },
                tags = { hl_group = "ObsidianTag" },
            }
        }
    end,
    keys = {
       -- { '=d', '<cmd>:ObsidianFollowLink<CR>', desc = 'Go To' },
        { '=v', '<cmd>:ObsidianFollowLink vsplit<CR>', desc = 'Split vertically' },
        { '=V', '<cmd>:ObsidianFollowLink hsplit<CR>', desc = 'Split horizontally' },
        { '=b', '<cmd>:ObsidianBacklinks<CR>', desc = 'Show Back Links' },
        { '=t', '<cmd>:ObsidianToday<CR>', desc = 'Open Daily' },
        { '=T', '<cmd>:ObsidianTemplate<CR>', desc = 'Use Template' },
        { '=h', '<cmd>:ObsidianSearch<CR>', desc = 'Search' },
    }
}


