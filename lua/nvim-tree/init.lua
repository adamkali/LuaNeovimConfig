require("nvim-tree").setup({
	renderer = {
        indent_markers = {
			enable = false,
			inline_arrows = true,
			icons = {
				corner = "╰",
				edge = "│",
				item = "│",
				bottom = "─",
				none = " ",
			},
        },
		icons = {
			default = "",
			symlink = "",
			git = {
				unstaged = "✗",
				staged = "",
				unmerged = "",
				renamed = "➜",
				untracked = "",
				deleted = "",
				ignored = "◌"
			},
			folder = {
				default = "",
				open = "",
				empty = "",
				empty_open = "",
				symlink = "",
				symlink_open = ""
			}
		},
		-- special_files = {
		-- 	"Cargo.toml",
		-- 	"go.mod",
		-- 	"go.sum",
		-- 	"init.lua",
		-- 	"package.json",
		-- 	"yarn.lock",
		-- 	"dockerfile",
		-- 	"docker-compose.yml",
		-- 	".gitignore",
		-- 	".gitmodules",
		-- 	".gitattributes",
		-- 	".dockerignore"
		-- }
	},
})
