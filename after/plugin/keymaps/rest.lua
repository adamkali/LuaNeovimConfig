-- ██╗  ██╗██╗   ██╗██╗      █████╗ ██╗      █████╗    ███╗   ██╗██╗   ██╗██╗███╗   ███╗
-- ██║ ██╔╝██║   ██║██║     ██╔══██╗██║     ██╔══██╗   ████╗  ██║██║   ██║██║████╗ ████║
-- █████╔╝ ██║   ██║██║     ███████║██║     ███████║   ██╔██╗ ██║██║   ██║██║██╔████╔██║
-- ██╔═██╗ ██║   ██║██║     ██╔══██║██║     ██╔══██║   ██║╚██╗██║╚██╗ ██╔╝██║██║╚██╔╝██║
-- ██║  ██╗╚██████╔╝███████╗██║  ██║███████╗██║  ██║██╗██║ ╚████║ ╚████╔╝ ██║██║ ╚═╝ ██║
-- ╚═╝  ╚═╝ ╚═════╝ ╚══════╝╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝╚═╝╚═╝  ╚═══╝  ╚═══╝  ╚═╝╚═╝     ╚═╝
--
--
local wk = require('which-key').add

local kulala_leader = "<space>w"
local kulala = require('kulala')

function run_all()
	vim.ui.input({ prompt = "You are about to send all requests, are you sure? (y/n) " },
		function(input)
			if not input then return end
			if input == "y" then kulala.run_all() end
		end)
end

wk {
	{ kulala_leader, expr = false, group = "Web", nowait = false, remap = false, icon = { icon = "󰖟", hl = "@comment.hint" } },
	{ kulala_leader .. "w", kulala.open, desc = 'Open ui in Default view' },
	{ kulala_leader .. "r", kulala.run, desc = 'Run Request' },
	{ kulala_leader .. "a", run_all, desc = 'Run All' },
	{ kulala_leader .. "y", kulala.replay, desc = 'Run the last request' },
	{ kulala_leader .. "p", kulala.preview, desc = 'Preview Request' },
	{ kulala_leader .. "s", kulala.inspect, desc = 'Save Request' },
	{ kulala_leader .. "[", kulala.jump_prev, desc = 'Jump to Previous Request' },
	{ kulala_leader .. "]", kulala.jump_next, desc = 'Jump to Next Request' },
}
