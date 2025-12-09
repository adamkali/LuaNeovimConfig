-- As always, We start with opening with a table

return {

	-- [dressing]{https://github.com/stevearc/dressing.nvim?tab=readme-ov-file#installation}

	{ 'stevearc/dressing.nvim' },

	-- [telescope]{https://github.com/nvim-telescope/telescope.nvim}

	{
		"nvim-telescope/telescope.nvim",
		dependencies = { 'nvim-lua/plenary.nvim' },
		opts = {
			defaults = {
				file_ignore_patterns = { "node_modules", "obj", "bin", "htmx.min.js" },
				layout_strategy = "center",
				layout_config = {
					center = {
						height = 0.60,
						width = 0.50,
						prompt_position = "top",
						preview_cutoff = 120,
					},
				},
				border = true,
				winblend = 10,
				width = 0.8,
				previewer = true,
				prompt_title = true,
				prompt_prefix = "🤔 ",
				selection_caret = " ",
				initial_mode = "insert",
				selection_strategy = "reset",
				sorting_strategy = "ascending",
				color_devicons = true,
				dynamic_preview_title = true,
				preview = {
					hide_on_startup = true,
				},
			},
			pickers = {
				find_files = {
					previewer = false,
					prompt_title = "󰈞 Find Files",
					results_title = "Files",
				},
				live_grep = {
					previewer = true,
					prompt_title = "󰊄 Live Grep",
					results_title = "Results",
				},
				grep_string = {
					previewer = false,
					prompt_title = "󰊄 Grep String",
					results_title = "Results",
				},
				buffers = {
					previewer = false,
					prompt_title = " Buffers",
					results_title = "Open Buffers",
				},
				help_tags = {
					previewer = true,
					prompt_title = "󰘥 Help Tags",
					results_title = "Help",
				},
				oldfiles = {
					previewer = false,
					prompt_title = "󰋚 Recent Files",
					results_title = "Recent",
				},
				git_files = {
					previewer = false,
					prompt_title = "󰊢 Git Files",
					results_title = "Git Files",
				},
				diagnostics = {
					previewer = false,
					prompt_title = "󰒡 Diagnostics",
					results_title = "Issues",
				},
				lsp_references = {
					previewer = false,
					prompt_title = "󰌹 LSP References",
					results_title = "References",
				},
				lsp_definitions = {
					previewer = false,
					prompt_title = "󰌹 LSP Definitions",
					results_title = "Definitions",
				},
				lsp_implementations = {
					previewer = false,
					prompt_title = "󰌹 LSP Implementations",
					results_title = "Implementations",
				},
				lsp_type_definitions = {
					previewer = false,
					prompt_title = "󰌹 LSP Type Definitions",
					results_title = "Type Definitions",
				},
				marks = {
					previewer = true,
					prompt_title = "󰌹 Marks",
					results_title = "Marks",
				},
			},
		},
	},

	-- [nerdy.nvim]

	{
		'2kabhishek/nerdy.nvim',
		cmd = 'Nerdy',
	},
}
