-- Pragma

local norbsidian = {}
local builtins = require("telescope.builtin")
local pickers = require("telescope.pickers")

-- I am now going to define this here class and function 

---@class NorbOptions
---@field name string
---@field dir string must be the absolute path, no trailing slash | default: $HOME
-- make this next on optional
---@field env string nil must be a env_var that points to the directory, no trailing slash | default: $HOME
---

--- @param loc string
--- @return filename string
local function norbsidian_export_template(loc, filename)

 filename = loc .. filename .. ".md"
 return "Neorg export to-file " .. filename .. " markdown"
end

-- Telescope 🥰

norbsidian.telescope = function(selections, callback)
 assert(#selections > 0, "No selections provided") -- Ensure there are selections

 local pickers = require('telescope.pickers')
 local finders = require('telescope.finders')
 local conf = require('telescope.config').values
 local actions = require('telescope.actions')
 local action_state = require('telescope.actions.state')

 local opts = {}
 pickers.new(opts, {
  prompt_title = "Select a Export local",
  finder = finders.new_table {
   results = selections,
   entry_maker = function(entry)
	   return {
		   value = entry,                                  -- <-- -----------------\
		   display = entry.name,                           -- SAME THING            |
		   ordinal = entry.name,                           -- /--------------------/
	   }                                                   -- |
   end                                                     -- |
  },                                                          -- |
  sorter = conf.generic_sorter(opts),                         -- |
  attach_mappings = function(prompt_bufnr, _map)              -- |
   actions.select_default:replace(function()               -- |
	   local selection = action_state.get_selected_entry() -- |
	   actions.close(prompt_bufnr)                         -- |
	   callback(selection.value)
	   --               ^\____________________________________/
   end)
   return true
  end,
 }):find()
end


-- NORBS 👹

---@field Norbs table
---@field Norbs table
norbsidian.Norbs = {
 {
  name = "Blog Posts",
  dir = "~/git/blog.kalilarosa.xyz/content/posts/",
 },
 {
  name = "Blog Configs",
  dir = "~/git/blog.kalilarosa.xyz/content/configs/"
 },
 {
  name = "Dailies Obsidian",
  dir = "/mnt/c/Users/adam/Documents/notes/My_Second_Mind/05-Dailies/",
 },
 {
  name = "Work Obsidian",
  dir = "/mnt/c/Users/adam/Documents/notes/My_Second_Mind/09-Work/",
 },
 {
  name = "Mindspace Docs",
  dir = "/home/adamkali/git/mindspace/docs/"
 },
 {
  name = "Mindspace Obsidian",
  dir = "/mnt/c/Users/adam/Documents/notes/My_Second_Mind/02-Projects/Mindscape/"
 },
 {
  name = "Egg Cli Docs",
  dir = "/home/adamkali/projects/egg_cli/docs/"
 },
 {
  name = "Egg Cli Obsidian",
  dir = "/mnt/c/Users/adam/Documents/notes/My_Second_Mind/02-Projects/EggCli/"
 },
 {
  name = "Neovim Obsidian",
  dir = "/mnt/c/Users/adam/Documents/notes/My_Second_Mind/02-Projects/Neovim/"
 },
 {
  name = "Dotnvim Docs",
  dir = "/home/adamkali/git/dotnvim/docs/"
 },
 {
  name = "eFileMadeEasy.FilingPortal",
  dir = "/mnt/c/Users/adam/Documents/notes/My_Second_Mind/09-Work/eFileMadeEasy.FilingPortal/"
 },
 {
  name = "eFileMadeEasy.DirectFile",
  dir = "/mnt/c/Users/adam/Documents/notes/My_Second_Mind/09-Work/eFileMadeEasy.DirectFile/"
 },
 {
  name = "Home Research",
  dir = "/mnt/c/Users/adam/Documents/notes/My_Second_Mind/08-Research/home-buying/"
 },
 {
  name = "The Greatest of the Al'Quizir",
  dir = "/mnt/c/Users/adam/Documents/notes/My_Second_Mind/10-Writing/alquizir/"
 }
}

-- The Export Function

---@param selection NorbOptions
norbsidian.export = function(selection)
 local filename = vim.api.nvim_buf_get_name(0)
 filename = string.sub(filename, 1, string.len(filename) - 5)
 local filename_path = vim.split(filename, "/")
 filename =  filename_path[#filename_path]
 -- vim.notify("Selected: "..vim.json.encode(filename_path) , vim.log.levels.TRACE, { title = "Norbsidian", timeout = 1000 })
 if selection.dir then
  norbsidian.export_loc = norbsidian_export_template(selection.dir, filename)
 elseif selection.env then
  norbsidian.export_loc = norbsidian_export_template(os.getenv(selection.env), filename)
 else
  vim.notify("No dir or env provided: Defaulting to $HOME", vim.log.levels.WARN, { title = "Norbsidian", timeout = 1000 })
  norbsidian.export_loc = norbsidian_export_template(os.getenv("HOME"), filename)
 end
 if norbsidian.export_loc then
  vim.cmd(norbsidian.export_loc)
 end
end

-- The Thing you call from a keybind

norbsidian.get_selections = function()
 norbsidian.telescope(norbsidian.Norbs, function(selection)
  norbsidian.export(selection)
 end)
end
return norbsidian