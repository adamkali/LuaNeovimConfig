return {
	{
		dir = '/home/adamkali/git/dotnvim',
		ft = { 'cs', 'vb', 'csproj', 'sln', 'slnx', 'props', 'csx', 'targets' },
		opts = {
			debug = {
				enabled = true
			},
			nuget = {
				sources = {
					"efilemadeeasy"
				},
				authenticators = {
					{
						cmd = "aws",
						args = { "codeartifact", "login", "--tool", "dotnet", "--domain", "efilemadeeasy",
							"--domain-owner", "378047982135", "--repository",
							"eFileMadeEasy-Common" }
					},
				},
			},
			-- Task system configuration (now available!)
			tasks = {
				enabled = true,
				execution_mode = "dependency_aware",
				dap_integration = {
					enabled = true,
					pre_debug_tasks = nil, -- Auto-discover pre-debug tasks
					block_on_failure = true,
					timeout_seconds = 300,
				}
			}
		}
	},
	{
		"adamkali/vs-solution-treesitter",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		config = function()
			require("sln-nvim").setup({
				conceal = {
					guids = true,
					version_info = true,
					file_paths = true,
					project_lines = true,
					global_sections = true,
				},

				ui_select_backend = "telescope",
				dependencies = { "nvim-telescope/telescope.nvim" }

			})
		end,
	},
	{
		dir = '/home/adamkali/projects/sharpier.nvim',
		-- 'adamkali/sharpie.nvim',
		name = 'sharpie.nvim',   -- IMPORTANT: Explicitly set name since dir is sharpier.nvim but module is sharpie
		ft = { 'cs', 'csharp', 'go' }, -- Lazy load on C# files
		dependencies = { 'nvim-telescope/telescope.nvim' },
		opts = {
			-- Display settings for the preview window
			display = {
				width = 60,
				height = 12,
				y_offset = 0,
				x_offset = 0,
				filter_prompt = "󰏪 ",
			},
			-- Style settings
			style = {
				icon_set = {
					namespace = "󰋜",
					class = "",
					method = "",
					property = "",
					field = "󰽏",
					constructor = "󰡢",
					enum = "",
					interface = "",
					struct = "",
					event = "",
					operator = "",
					type_parameter = "",
					search = "",
					integer = "",
					string = "󰀬",
					boolean = "",
					array = "󰅪",
					number = "",
					null = "󰟢",
					void = "󰟢",
					object = "",
					dictionary = "",
					key = "",
					task = "",
				}
			},

			-- Symbol display options
			symbol_options = {
				namespace = true, -- show all classes in namespace
				path = 2, -- 0-3, controls symbol path depth
			},

			-- Keybinding settings
			keybindings = {
				sharpie_local_leader = '-s',
				disable_default_keybindings = false,
				overrides = {
					show_preview = "<localleader>s",
					hide_preview = "<localleader>h",
					step_to_next_symbol = "<localleader>f",
					toggle_namespace_mode = "<localleader>t",
					step_to_prev_symbol = "<localleader>b",
					search_symbols = "<localleader>xs",
					toggle_highlight = "<localleader>H",
				},
				preview = {
					jump_to_symbol = "<CR>", -- Jump to symbol under cursor
					next_symbol = "<C-n>", -- Navigate to next symbol
					prev_symbol = "<C-p>", -- Navigate to previous symbol
					close = "q", -- Close preview window
					filter = ".", -- Start filtering/searching
					clear_filter = "<Esc>", -- Clear filter and show all symbols
				}
			}
		}
	}
}
