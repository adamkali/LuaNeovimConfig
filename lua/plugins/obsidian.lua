return {
    "epwalsh/obsidian.nvim",
    opts = {
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
    }
}
