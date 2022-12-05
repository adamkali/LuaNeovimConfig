require("nvim-tree").setup({
sort_by = "case_sensitive",
	view = {
		adaptive_size = true,
		mappings = {
			list = {
				{ key = "u", action = "dir_up" },
			},
		},
	},
	renderer = {
		group_empty = true,
		highlight_git = true,
		indent_width = 4,
		indent_markers = {
			enable = false,
			icons = {
				corner = "╰",
				item = "┝",
			},
		},
	},
	filters = {
		dotfiles = true,
	},
})
