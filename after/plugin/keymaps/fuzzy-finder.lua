-- ███████╗██╗   ██╗███████╗███████╗██╗   ██╗     ███████╗██╗███╗   ██╗██████╗ ██╗███╗   ██╗ ██████╗
-- ██╔════╝██║   ██║╚══███╔╝╚══███╔╝╚██╗ ██╔╝     ██╔════╝██║████╗  ██║██╔══██╗██║████╗  ██║██╔════╝
-- █████╗  ██║   ██║  ███╔╝   ███╔╝  ╚████╔╝█████╗█████╗  ██║██╔██╗ ██║██║  ██║██║██╔██╗ ██║██║  ███╗
-- ██╔══╝  ██║   ██║ ███╔╝   ███╔╝    ╚██╔╝ ╚════╝██╔══╝  ██║██║╚██╗██║██║  ██║██║██║╚██╗██║██║   ██║
-- ██║     ╚██████╔╝███████╗███████╗   ██║        ██║     ██║██║ ╚████║██████╔╝██║██║ ╚████║╚██████╔╝
-- ╚═╝      ╚═════╝ ╚══════╝╚══════╝   ╚═╝        ╚═╝     ╚═╝╚═╝  ╚═══╝╚═════╝ ╚═╝╚═╝  ╚═══╝ ╚═════╝
local wk = require('which-key').add
local telescope_leader = "<space>f"



wk { { telescope_leader, expr = false, group = "[f]inder", nowait = false, remap = false, icon = { icon = "", hl = "@lsp.type.selfTypeKeyword" } } }

wk {
	{ telescope_leader .. "f",  "<cmd>Telescope find_files<cr>",                    desc = "[f]iles" },
	{ telescope_leader .. "h",  "<cmd>Telescope help_tags<cr>",                     desc = "[t]ags" },
	{ telescope_leader .. "g",  "<cmd>Telescope live_grep<cr>",                     desc = "[g]rep" },
	{ telescope_leader .. "c",  "<cmd>Telescope commands<cr>",                      desc = "[c]ommands" },
	{ telescope_leader .. "b",  "<cmd>Telescope buffers<cr>",                       desc = "[b]uffers" },
	{ telescope_leader .. "m",  "<cmd>Telescope marks<cr>",                         desc = "[m]arks" },
	{ telescope_leader .. "r",  "<cmd>Telescope registers<cr>",                     desc = "[r]egisters" },
	{ telescope_leader .. "n",  "<cmd>Telescope nerdy<cr>",                         desc = "[N]erdfonts " },
	{ telescope_leader .. "k",  "<cmd>Telescope keymaps<cr>",                       desc = "[k]eymaps" },
	{ telescope_leader .. "ls", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", desc = "[l]sp [s]ymbols" },
	{ telescope_leader .. "ld", "<cmd>Telescope diagnostics<cr>",                   desc = "[l]sp [d]iagnostics" },
	{ telescope_leader .. "lr", "<cmd>Telescope lsp_refrences<cr>",                 desc = "[l]sp [r]efrences" },
}
