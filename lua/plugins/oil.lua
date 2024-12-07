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
        skip_confirm_for_simple_edits = true,
        prompt_save_on_select_new_entry = false,
    },
    keys = oil_keybinds()
}

--  {
--      "echasnovski/mini.files",
--      version = "*",
--  
--      config = function()
--          require("mini.files").setup({
--              vim.keymap.set("n", "<leader>e", "<CMD>lua MiniFiles.open()<CR>", { desc = "Open NvimTree" }),
--              windows = {
--                  max_number = 3,
--                  preview = true,
--                  width_focus = 40,
--                  width_nofocus = 20,
--                  width_preview = 80,
--              },
--          })
--      end,
--  },
