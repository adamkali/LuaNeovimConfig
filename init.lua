-- Map the Leader    

vim.g.mapleader = "-"

-- Install Lazy 

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

-- This is specifically for Neorg 

vim.opt.conceallevel = 2

vim.opt.nu = true

-- Relative Numbers help to move with 

vim.opt.relativenumber = true

-- Tab Niceties

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = false
vim.opt.smartindent = true

-- Allow for Snacks to display when calling just nvim

vim.g.loaded_netrwPlugin = 1
vim.g.loaded_netrw = 1

vim.opt.swapfile = true
vim.opt.backup = false
vim.opt.undofile = true

-- Some Search options to include

vim.opt.hlsearch = true
vim.opt.incsearch = false

-- Some general quality of life optins

vim.opt.termguicolors = true
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.updatetime = 50
vim.opt.showmode = false

-- Wrap text around if the words go past the edge

vim.opt.wrap = true

-- Use this as the general python interpreter

vim.g.python3_host_prog="/usr/bin/python3.12"
vim.cmd[[set guifont=Maple\ Mono\ NF:h20]]

-- Create Keybindngs For me that I like 

local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- Add C-a as a way to write all files

map("n", "<C-a>", ":wa<CR>", opts)

-- Add Remove the buffer for memeory. useful if you were using a buffer for reference

map("n", "<C-q>", ":bd!<CR>", opts)

-- Allow for Y to be an operater to copyning to the clipboard

map("n", "Y", '"+y', opts)
map("v", "Y", '"+y', opts)

-- Replace movement hjkl with htns because of muscle memory

map('n', 't', 'j', { noremap = true, silent = true })
map('n', 'n', 'k', { noremap = true, silent = true })
map('n', 's', 'l', { noremap = true, silent = true })
map('n', 'k', 'n', { noremap = true, silent = true })
map('v', 't', 'j', { noremap = true, silent = true })
map('v', 'n', 'k', { noremap = true, silent = true })
map('v', 's', 'l', { noremap = true, silent = true })
map('v', 'k', 'n', { noremap = true, silent = true })

-- Replace the Shifted hjkl-> to HTNS

map('n', 'T', 'J', { noremap = true, silent = true })
map('n', 'N', 'K', { noremap = true, silent = true })
map('n', 'S', 'L', { noremap = true, silent = true })
map('n', 'K', 'n', { noremap = true, silent = true })
map('v', 'T', 'J', { noremap = true, silent = true })
map('v', 'N', 'K', { noremap = true, silent = true })
map('v', 'S', 'L', { noremap = true, silent = true })
map('v', 'K', 'N', { noremap = true, silent = true })

-- Change the window movements to be htns

map("n", "<C-h>", ":wincmd h <CR>", opts)
map("n", "<C-t>", ":wincmd j <CR>", opts)
map("n", "<C-n>", ":wincmd k <CR>", opts)
map("n", "<C-s>", ":wincmd l <CR>", opts)

-- Adda some page movements 

vim.keymap.set('n', '<C-f>', '<C-f>zz<CR>', {noremap = true, silent = true})
vim.keymap.set('n', '<C-b>', '<C-b>zz<CR>', {noremap = true, silent = true})

-- Add in some Diagnostics

local sign = function(opts)
    vim.fn.sign_define(opts.name, { text = opts.text, texthl = opts.color, linehl = '', numhl = '' })
end
local M = {}

function M.blend(foreground, alpha, background)
    alpha = type(alpha) == "string" and (tonumber(alpha, 16) / 0xff) or alpha
    local bg = rgb(background)
    local fg = rgb(foreground)

    local blendChannel = function(i)
        local ret = (alpha * fg[i] + ((1 - alpha) * bg[i]))
        return math.floor(math.min(math.max(0, ret), 255) + 0.5)
    end

    return string.format("#%02x%02x%02x", blendChannel(1), blendChannel(2), blendChannel(3))
end

function M.blend_bg(hex, amount, bg)
    return M.blend(hex, amount, bg or M.bg)
end

vim.api.nvim_set_hl(0, 'DiagnosticSignError', { fg = '#ea286a'})
vim.api.nvim_set_hl(0, 'DiagnosticSignWarn',  { fg = '#FFAB22'})
vim.api.nvim_set_hl(0, 'DiagnosticSignInfo',  { fg = '#2282E6'})
vim.api.nvim_set_hl(0, 'DiagnosticSignHint',  { fg = '#22f2f2'})

sign({ name = 'DiagnosticSignError', text = '', color = 'LspDiagnosticsError' })
sign({ name = 'DiagnosticSignWarn',  text = '', color = 'LspDiagnosticsWarn' })
sign({ name = 'DiagnosticSignInfo',  text = '', color = 'LspDiagnosticsInfo' })
sign({ name = 'DiagnosticSignHint',  text = '', color = 'LspDiagnosticsHint' })
