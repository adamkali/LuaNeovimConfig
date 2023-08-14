local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }
local wk = require("which-key")

vim.g.mapleader = "-"

-->   Nvim Tree    <--
wk.register({
    {
        name = "NvimTree",
        n = { "<cmd>NvimTreeToggle<CR>", "Toggle" },
        t = { "<cmd>NvimTreeFocus<CR>", "Find File" },
    }
},{ prefix = "<leader>", })

-->   Better Writing <--
map("n", "<leader>l", ":set list!<CR>", opts)
map("n", "<A-a>", ":wa<CR>", opts)
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
map("n", "<A-x>", ":BufferClose<CR>", opts)
map("n", "<leader>bd", ":BufferOrderByDirectory<CR>", opts)
map("n", "<leader>bl", ":BufferOrderByLanguage<CR>", opts)
map("n", "<leader>bp", ":BufferPin<CR>", opts)

 -->   TELESCOPE <--
wk.register({
    h = {
        name = "Telescope",
        h = { "<cmd>Telescope find_files<CR>", "Find File" },
        g = { "<cmd>Telescope live_grep<CR>", "Live Grep" },
        b = { "<cmd>Telescope buffers<CR>", "Buffers" },
    }
},{ prefix = "<leader>" })

-- Normal move
map('n', 't', 'j', { noremap = true, silent = true })
map('n', 'n', 'k', { noremap = true, silent = true })
map('n', 's', 'l', { noremap = true, silent = true })
map('n', 'k', 'n', { noremap = true, silent = true })
map('v', 't', 'j', { noremap = true, silent = true })
map('v', 'n', 'k', { noremap = true, silent = true })
map('v', 's', 'l', { noremap = true, silent = true })
map('v', 'k', 'n', { noremap = true, silent = true })

-- Shift move 
map('n', 'T', 'J', { noremap = true, silent = true })
map('n', 'N', 'K', { noremap = true, silent = true })
map('n', 'S', 'L', { noremap = true, silent = true })
map('n', 'K', 'n', { noremap = true, silent = true })

-- Control move
map("n", "<C-h>", ":wincmd h <CR>", opts)
map("n", "<C-t>", ":wincmd j <CR>", opts)
map("n", "<C-n>", ":wincmd k <CR>", opts)
map("n", "<C-s>", ":wincmd l <CR>", opts)
