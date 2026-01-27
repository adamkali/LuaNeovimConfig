local arbitraries = require('arbitraries')
local wk = require('which-key').add
local arbitraries_leader = "<space>a"

wk {
	{ arbitraries_leader, expr = false, group = "[a]rbitraries", nowait = false, remap = false, icon = { icon = "󱍊", hl = "@lsp.type.interface" } }
}

wk {
	{ arbitraries_leader .. "f", arbitraries.ak_get_filename,                       desc = "Insert Filename" },
	{ arbitraries_leader .. "F", arbitraries.ak_get_fqn_filname,                    desc = "Insert FQN Filename" },
	{ arbitraries_leader .. "y", arbitraries.ak_yank_filename,                      desc = "Yank Filename" },
	{ arbitraries_leader .. "Y", arbitraries.ak_yank_fqn_filename,                  desc = "Yank FQN Filename" },
	{ arbitraries_leader .. "d", arbitraries.ak_bar_datetime,                       desc = "Insert Date and Time" },
	{ arbitraries_leader .. "c", arbitraries.ak_copy_filname,                       desc = "Copy Filename" },
	{ arbitraries_leader .. "C", arbitraries.ak_copy_fqn_filename,                  desc = "Copy FQN Filename" },
	{ arbitraries_leader .. "|", arbitraries.ak_split_buffer_with_scratch_vertical, desc = "(vertical) Split Buffer With Scratch" },
	{ arbitraries_leader .. "-", arbitraries.ak_split_buffer_with_scratch,          desc = "Split Buffer With Scratch" },

	{ arbitraries_leader .. "D", function()
		local count = vim.v.count > 0 and vim.v.count or 0
		arbitraries.ak_bar_datetime_end_of_day(count)
	end, desc = "Insert Date EOD +[count] days" },
}
