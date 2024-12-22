local function oil_keybinds()
    return {
        {
            "<leader>o",
            function() require 'oil'.open_float() end,
            desc = 'Open Oil'
        },
        {
            "=o",
            function() require 'oil'.save() end,
            desc = 'Oil Save'
        },
        {
            "<leader>O",
            function()
                require 'oil'.close()
            end,
            desc = 'Oil Close'
        }
    }
end

return {
    "stevearc/oil.nvim",
    opts = {
        default_file_explorer = true,
        skip_confirm_for_simple_edits = true,
        prompt_save_on_select_new_entry = false,
    },
    keys = oil_keybinds()
}

