local obs = require("obsidian")
local wk = require("which-key")

        
obs.setup({
    -- dir = "p:\\My Mind", -- Desktop
    dir = "C:\\src\\projects\\My_Second_Mind", -- Laptop
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
        checkboxes = {
          -- NOTE: the 'char' value has to be a single character, and the highlight groups are defined below.
          [" "] = { char = "󰄱", hl_group = "ObsidianTodo" },
          ["x"] = { char = "", hl_group = "ObsidianDone" },
          [">"] = { char = "", hl_group = "ObsidianRightArrow" },
          ["~"] = { char = "󰰱", hl_group = "ObsidianTilde" },
       },
        external_link_icon = { char = "", hl_group = "ObsidianExtLinkIcon" },
        -- Replace the above with this if you don't have a patched font:
        -- external_link_icon = { char = "", hl_group = "ObsidianExtLinkIcon" },
        reference_text = { hl_group = "ObsidianRefText" },
        highlight_text = { hl_group = "ObsidianHighlightText" },
        tags = { hl_group = "ObsidianTag" },
    }
})



wk.register({
   ['md'] = {
        name = 'Obsidian Keybindings',
        f = { "<cmd>:ObsidianFollowLink<CR>", 'Follow Link' },
        F = { "<cmd>:ObsidianBacklinks<CR>", 'Show List Of Backlinks' },
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

wk.register({
   ['md'] = {
        name = 'Obsidian Keybindings',
        l = { "<cmd>:ObsidianNewLink<CR>", 'Create New Link From Selection' },
        L = { "<cmd>:ObsidianLink<CR>", 'Create Existing Link From Selection' },
    }, {
        mode = "v", -- visual mode
        prefix = "",
        buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
        silent = true, -- use `silent` when creating keymaps
        noremap = true, -- use `noremap` when creating keymaps
        nowait = false, -- use `nowait` when creating keymaps
        expr = false, -- use `expr` when creating keymaps
    }
})
