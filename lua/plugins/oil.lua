local function oil_keybinds()
    return {
        {
            "<leader>o",
            function() require 'oil'.open_float() end,
            desc = 'Oil Mode'
        },
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

