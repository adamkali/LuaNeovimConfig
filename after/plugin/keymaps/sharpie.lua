--
-- ███████╗██╗  ██╗ █████╗ ██████╗ ██████╗ ██╗███████╗   ███╗   ██╗██╗   ██╗██╗███╗   ███╗
-- ██╔════╝██║  ██║██╔══██╗██╔══██╗██╔══██╗██║██╔════╝   ████╗  ██║██║   ██║██║████╗ ████║
-- ███████╗███████║███████║██████╔╝██████╔╝██║█████╗     ██╔██╗ ██║██║   ██║██║██╔████╔██║
-- ╚════██║██╔══██║██╔══██║██╔══██╗██╔═══╝ ██║██╔══╝     ██║╚██╗██║╚██╗ ██╔╝██║██║╚██╔╝██║
-- ███████║██║  ██║██║  ██║██║  ██║██║     ██║███████╗██╗██║ ╚████║ ╚████╔╝ ██║██║ ╚═╝ ██║
-- ╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝╚═╝     ╚═╝╚══════╝╚═╝╚═╝  ╚═══╝  ╚═══╝  ╚═╝╚═╝     ╚═╝
--
local wk = require('which-key').add
local sharpie = require('sharpie')
local sharpie_leader = "<space>s"

wk { { sharpie_leader, expr = false, group = "Sharpie", nowait = false, remap = false, icon = { icon = "󰙒", hl = "@lsp.type.enum" } } }


wk {
	{ sharpie_leader .. "s",     sharpie.show_preview,          desc = 'Show Preview' },
	{ sharpie_leader .. "<c-s>", sharpie.hide_preview,          desc = 'Hide Preview' },
	{ sharpie_leader .. "f",     sharpie.step_to_next_symbol,   desc = 'Step to Next Symbol' },
	{ sharpie_leader .. "b",     sharpie.step_to_prev_symbol,   desc = 'Step to Prev Symbol' },
	{ sharpie_leader .. "t",     sharpie.toggle_namespace_mode, desc = 'Toggle Namespace Mode' },
	{ sharpie_leader .. "<C-f>", sharpie.search_symbols,        desc = 'Search Symbols' },
	{ sharpie_leader .. "<C-h>", sharpie.toggle_highlight,      desc = 'Toggle Highlight' },
}
