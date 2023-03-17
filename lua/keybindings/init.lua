local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

vim.g.mapleader = ","
vim.g.maplocalleader = ","

-->   Nvim Tree    <--
map("n", "<leader>n", ":NvimTreeToggle <CR>", opts)
map("n", "<leader>t", ":NvimTreeFocus <CR>", opts)

-->   Better Writing <--
map("n", "<leader>l", ":set list!<CR>", opts)
map("n", "<A-q>", ":wqa<CR>", opts)
map("n", "<A-a>", ":qa<CR>", opts)
map("n", "<A-w>", ":wa<CR>", opts)
map("n", "<A-v>", "v<C-v>", opts)
map("n", ";", ":", opts)

--> Barbar Tabline <--
map("n", "<A-[>", ":BufferPrevious<CR>", opts)
map("n", "<A-]>", ":BufferNext<CR>", opts)
map("n", "<A-1>", ":BufferGoto 1<CR>", opts)
map("n", "<A-2>", ":BufferGoto 2<CR>", opts)
map("n", "<A-3>", ":BufferGoto 3<CR>", opts)
map("n", "<A-4>", ":BufferGoto 4<CR>", opts)
map("n", "<A-5>", ":BufferGoto 5<CR>", opts)
map("n", "<A-6>", ":BufferGoto 6<CR>", opts)
map("n", "<A-7>", ":BufferGoto 7<CR>", opts)
map("n", "<A-8>", ":BufferGoto 8<CR>", opts)
map("n", "<A-9>", ":BufferLast<CR>", opts)
-- other bar bar mappings
map("n", "<A-x>", ":BufferClose<CR>", opts)
map("n", "<leader>bd", ":BufferOrderByDirectory<CR>", opts)
map("n", "<leader>bl", ":BufferOrderByLanguage<CR>", opts)
map("n", "<leader>bp", ":BufferPin<CR>", opts)

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


