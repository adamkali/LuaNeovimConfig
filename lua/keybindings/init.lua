local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

vim.g.mapleader = ","
vim.g.maplocalleader = ","

-->   Nvim Tree <--
map("n", "<leader>n", ":NvimTreeToggle<CR>", opts)
map("n", "<leader>t", ":NvimTreeFocus<CR>", opts)

-->   Better Writing <--
map("n", "<leader>l", ":set list!<CR>", opts)
-- make  :wqa be alt+q
map("n", "<A-q>", ":wqa<CR>", opts)
-- make  :qa be alt+a
map("n", "<A-a>", ":qa<CR>", opts)
-- make  :wq be alt+w
map("n", "<A-w>", ":wq<CR>", opts)
-- make  capsloc also be esc
map("i", "<C-c>", "<Esc>", opts)
-- make  esc to be capslock
map("i", "<Esc>", "<C-c>", opts)
-- make  ; be :
map("n", ";", ":", opts)

 -->   TELESCOPE <--
map("n", "<leader>ff", ":Telescope find_files<cr>", opts)
map("n", "<leader>fg", ":Telescope live_grep<cr>", opts)
map("n", "<leader>fb", ":Telescope buffers<cr>", opts)

-->   CUSTOM FUNCTIONS <--

-- make a function that will close  [, {, (, <, ', ", `
-- first create a map for the function
-- each entry should have:
-- 1. the key to be pressed
-- 2. a closer for the key
local openCloseMap = {
	["["] = "]",
	["{"] = "}",
	["("] = ")",
	["<"] = ">",
	["'"] = "'",
	['"'] = '"',
	["`"] = "`",
}

-- now create the function
-- this function will take in the key that was pressed
-- and then close the key
-- it will also move the cursor to the middle of the key
local function closeOpeners(key)
	-- first get the current line
	local line = vim.fn.getline(".")
	-- then get the current column
	local col = vim.fn.col(".")
	-- then get the character at the current column
	local char = line:sub(col, col)
	-- get the  key from the map
	local closer = openCloseMap[key]
	-- put the  closer into the next column
	vim.fn.append(".", closer)
	-- move the cursor to the middle of the key
	vim.fn.col(col)
end

-- loop throught the  openClosemap and create a map for each entry
for key, _ in pairs(openCloseMap) do
	-- create the map
	map("i", key, "v:lua.closeOpeners('" .. key .. "')", { expr = true })
end

-- make a mapping for different languages and their commentStyle
local commentStyle = {
	['python'] = '#   ',
	['lua'] = '--  ',
	['vim'] = '"   ',
	['docker'] = '#   ',
	['sh'] = '#   ',
	['zsh'] = '#   ',
	['bash'] = '#   ',
	['c'] = '//  ',
	['cpp'] = '//  ',
	['java'] = '//  ',
	['go'] = '//  ',
	['rust'] = '//  ',
	['html'] = '<!--  -->',
	['css'] = '/*  */',
	['javascript'] = '//  ',
	['typescript'] = '//  ',
	['json'] = '//  ',
	['yaml'] = '#   ',
	['toml'] = '#   ',
	['markdown'] = '#   ',
	['tex'] = '%   ',
	['latex'] = '%   ',
	['org'] = '#   ',
	['vimwiki'] = '#   ',
	['default'] = '//  ',
}

-- make a function that will comment the  current line
local function commenter()
	-- get the  current line
	local line = vim.fn.getline(".")
	-- check the language of the current buffer
	local lang = vim.bo.filetype
	-- get the  commentStyle for the current language
	local style = commentStyle[lang] or commentStyle['default']
	-- add the  commentStyle to the beginning of the line
	vim.fn.append(".", style)
end

local function uncommenter()
	-- get the  current line
	local line = vim.fn.getline(".")
	-- check the language of the current buffer
	local lang = vim.bo.filetype
	-- get the  commentStyle for the current language
	local style = commentStyle[lang] or commentStyle['default']
	-- REMOVE THE STYLE FROM THE BEGINNING OF THE LINE
	-- THE LENGHT OF THE STYLE IS 4
	-- SO REMOVE THE FIRST 4 CHARACTERS
	vim.fn.append(".", line:sub(4))
end

-- create a mapping for commenting
map("n", "<leader>/", "v:lua.commenter()", { expr = true })
-- create a mapping for uncommenting
map("n", "<leader>\\", "v:lua.uncommenter()", { expr = true })


 -->   EXPORTS <--
return {
	closeOpeners = closeOpeners,
	commenter = commenter,
	uncommenter = uncommenter,
}
