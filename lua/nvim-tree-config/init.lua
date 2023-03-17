local function open_nvim_tree()
    require("nvim-tree.api").tree.open()
end

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
			enable = true,
			icons = {
				corner = "╰",
				item = "┝",
			},
		},
	},
	filters = {
		dotfiles = false,
	},
})

vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })
