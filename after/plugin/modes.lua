-- Modes Available

local wk = require("which-key").add
wk{
    { "<leader>m", "<cmd>:Mason <cr>",      desc = "Mason Mode", icon = { icon = "  " , " @keyword.function" } },
    { "<leader>l", "<cmd>:CodeCompanionChat<cr>",      desc = "LLM Mode", icon = { icon = "  ", " @keyword.function" } },
    { "<leader>L", "<cmd>:Lazy<cr>",      desc = "Lazy Mode", icon = { icon = " 󰒲 ", "@keyword.function" } },
    { "<leader>c", "<cmd>:CsvViewToggle<cr>",      desc = "Csv Mode", icon = { icon = "  ", "@keyword.function" } },
    { "<leader>f", "<cmd>:Telescope<cr>",      desc = "Finder Mode", icon = { icon = "   ", hl = "@keyword.function" } },
    { "<leader>N", function() Snacks.notifier.show_history() end, desc = "Notifications mode", icon = { icon = "  ", hl = "@keyword.function" } },
    { "<leader>g", function() Snacks.lazygit.open() end,          desc = "Git Mode" , icon = { icon = "  ", hl = "@keyword.function" } },
    { '<leader>n', '<cmd>:Neorg workspace org_mode<cr>',          desc = 'Neorg Mode' , icon = { icon = "  ", hl = "@keyword.function" } },
    { "<leader>o", function() require 'oil'.open_float() end, desc = 'Oil Mode' , icon = { icon = "  ", hl = "@keyword.function" } },
}