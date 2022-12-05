local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

vim.g.mapleader = ","
vim.g.maplocalleader = ","

-->   Nvim Tree <--
map("n", "<leader>n", ":NvimTreeToggle <CR>", opts)
map("n", "<leader>t", ":NvimTreeFocus <CR>", opts)

-->   Better Writing <--
map("n", "<leader>l", ":set list!<CR>", opts)
-- make  :wqa be alt+q
map("n", "<A-q>", ":wqa<CR>", opts)
-- make  :qa be alt+a
map("n", "<A-a>", ":qa<CR>", opts)
-- make  :wq be alt+w
map("n", "<A-w>", ":wq<CR>", opts)
-- make Visual block mode be alt+v
map("n", "<A-v>", "v<C-v>", opts)
map("n", ";", ":", opts)
-- make ctrl+e be exit to normal mode
map("i", "<C-e>", "<Esc>", opts)

 -->   TELESCOPE <--
map("n", "<leader>ff", ":Telescope find_files<cr>", opts)
map("n", "<leader>fg", ":Telescope live_grep<cr>", opts)
map("n", "<leader>fb", ":Telescope buffers<cr>", opts)

--> Better Movement <--
-- directional keys
local movement_keys = {
    ["h"] = "h",
    ["j"] = "j",
    ["k"] = "k",
    ["l"] = "l"
}

-- move windows with ctrl + directional keys
-- index over the movement table
for i, v in pairs(movement_keys) do
    map("n", "<C-" .. i .. ">", ":wincmd " .. v .. "<CR>", opts)
end
