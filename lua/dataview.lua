-- Here is where my functionality starts 

local neorg_dataview = {}

-- So first pull in eveything we need from luasnip

local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local c = ls.choice_node
local fmt = require("luasnip.extras.fmt").fmt

-- We will now also import telescope to use a picker to select the directory that the dataview will query.

local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values
local actions = require('telescope.actions')
local action_state = require('telescope.actions.state')
local opts = {}

-- Here is the Telescope picker that will be used to place the directory in place of the {2}

neorg_dataview.telescope = function(selections, callback)
 pickers.new(opts, {
  prompt_title = "Select an Obsidian Directory to Query",
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
  end
 }):find()
end

-- Now lets create a snippet that will generate a dataview code snippet for obsidian

ls.add_snippets("norg", {
 s("dv", fmt([[
```dataview
TABLE {metadata_fields}
FROM "{directory}"
```]], {
	  metadata_fields = i(1),
	  directory = t(function()
		  local directory = ""
		  neorg_dataview.telescope(directory_choices, function(selection)
			  directory = selection
		  end)
		  return directory
	  end)
  })),
 s("dvc", fmt([[
```dataview
TABLE {metadata_fields}
FROM "{directory}"
WHERE {filters}
```]], {
	  metadata_fields = i(1),
	  directory = t(function()
		  local directory = ""
		  neorg_dataview.telescope(directory_choices, function(selection)
			  directory = selection
		  end)
		  return directory
	  end),
	  filters = i(3),
  })),
})
return neorg_dataview