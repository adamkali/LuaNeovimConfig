-- As always, We start with opening with a table
--
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
				border = true,
				winblend = 10,
				width = 0.8,
				previewer = true,
				prompt_title = true,
				prompt_prefix = " ",
				selection_caret = " ",
				initial_mode = "insert",
				selection_strategy = "reset",
				sorting_strategy = "ascending",
				color_devicons = true,
				dynamic_preview_title = true,
			},
			pickers = {
				find_files = {
					prompt_title = "󰈞 Find Files",
					results_title = "Files",
				},
				live_grep = {
					prompt_title = "󰊄 Live Grep",
					results_title = "Results",
				},
				grep_string = {
					prompt_title = "󰊄 Grep String",
					results_title = "Results",
				},
				buffers = {
					prompt_title = " Buffers",
					results_title = "Open Buffers",
				},
				help_tags = {
					prompt_title = "󰘥 Help Tags",
					results_title = "Help",
				},
				oldfiles = {
					prompt_title = "󰋚 Recent Files",
					results_title = "Recent",
				},
				git_files = {
					prompt_title = "󰊢 Git Files",
					results_title = "Git Files",
				},
				diagnostics = {
					prompt_title = "󰒡 Diagnostics",
					results_title = "Issues",
				},
				lsp_references = {
					prompt_title = "󰌹 LSP References",
					results_title = "References",
				},
				lsp_definitions = {
					prompt_title = "󰌹 LSP Definitions",
					results_title = "Definitions",
				},
				lsp_implementations = {
					prompt_title = "󰌹 LSP Implementations",
					results_title = "Implementations",
				},
				lsp_type_definitions = {
					prompt_title = "󰌹 LSP Type Definitions",
					results_title = "Type Definitions",
				},
				marks = {
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
