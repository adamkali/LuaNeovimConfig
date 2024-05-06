return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		{'nvim-lua/plenary.nvim'}
	},
	keys = {
		{ "-hh", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
		{ "-hg", "<cmd>Telescope live_grep<cr>", desc = "Live Grep" },
		{ "-hc", "<cmd>Telescope commands<cr>", desc = "List Commands" },
		{ "-hb", "<cmd>Telescope buffers<cr>", desc = "List Buffers" },
		{ "-hd", "<cmd>Telescope diagnostics<cr>", desc = "Lsp Diagnostics" },
		{ "-hr", "<cmd>Telescope lsp_refrences<cr>", desc = "Lsp Refrences" },
	},
	opts = {
		defaults = {
			file_ignore_patterns = { "node_modules", "target" },
		},
	}
}

