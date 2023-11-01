local obs = require("obsidian")
local wk = require("which-key")

obs.setup({
    -- dir = "p:\\My Mind", -- Desktop
    dir = "C:\\src\\projects\\My_Second_Mind", -- Laptop
    templates = {
        subdir = "./templates",
        -- subdir = "templates",
        date_format = "%Y-%m-%d-%a",
        time_format = "%H:%M",
    },
})

wk.register({
   ['md'] = {
        name = 'Obsidian Keybindings',
        f = { "<cmd>:ObsidianFollowLink<CR>", 'Follow Link' },
        F = { "<cmd>:ObsidianBacklinks<CR>", 'Show List Of Backlinks' },
        l = { "<cmd>:ObsidianNewLink<CR>", 'Create New Link From Selection' },
        L = { "<cmd>:ObsidianLink<CR>", 'Create Existing Link From Selection' },
        t = { "<cmd>:ObsidianTemplate<CR>", 'Create Note From Template' },
        k = { "<cmd>:ObsidianOpen<CR>", 'Open in Obsidian' },
        K = { function () vim.lsp.buf.hover() end, 'Show Hover Actions'},
        ['['] = { function ()
               vim.diagnostic.goto_prev({popup_opts = {border = "rounded", focusable = false}})
            end,
            'Go to previous diagnostic'
        },
        [']'] = {
            function ()
                vim.diagnostic.goto_next({popup_opts = {border = "rounded", focusable = false}})
            end,
            'Go to next diagnostic'
        }
    }
}, {
    mode = "n", -- NORMAL mode
    prefix = "",
    buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true, -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = false, -- use `nowait` when creating keymaps
    expr = false, -- use `expr` when creating keymaps
})
