vim.g.mapleader = "-"

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins")

-- opts
vim.opt.guicursor = ""
vim.opt.conceallevel = 2
vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_netrw = 1
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true

vim.opt.hlsearch = true
vim.opt.incsearch = false

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"

vim.opt.updatetime = 50

-- turn off the -- INSERT -- message
vim.opt.showmode = false

vim.opt.wrap = true
vim.g.python3_host_prog="/usr/bin/python3.12"


local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-->   Better Writing <--
map("n", "<C-a>", ":wa<CR>", opts)
map("n", "<C-q>", ":bd!<CR>", opts)
map("n", ";", ":", opts)
map("n", "Y", '"+y', opts)
map("v", "Y", '"+y', opts)
map("n", "<C-A-I>", "<C-^>", opts)

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
map('v', 'T', 'J', { noremap = true, silent = true })
map('v', 'N', 'K', { noremap = true, silent = true })
map('v', 'S', 'L', { noremap = true, silent = true })
map('v', 'K', 'N', { noremap = true, silent = true })

-- Control move
map("n", "<C-h>", ":wincmd h <CR>", opts)
map("n", "<C-t>", ":wincmd j <CR>", opts)
map("n", "<C-n>", ":wincmd k <CR>", opts)
map("n", "<C-s>", ":wincmd l <CR>", opts)




