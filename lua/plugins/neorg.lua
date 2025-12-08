-- Setup Neorg with some basic settings

return {
	{
		"nvim-neorg/neorg",
		lazy = false,
		version = "*",
		dependencies = {
			"juniorsundar/neorg-extras",
		},
		config = function()
			require("neorg").setup {
				load = {
					["core.defaults"] = {},
					["core.autocommands"] = {},
					["core.esupports.metagen"] = {
					},
					["core.concealer"] = {
						config = {
							icons = {
								heading = {
									enabled = true,
									icons = {
										"",
										"",
										"󰯬",
										"󰯯",
										"󰯲",
										"󰯵",
										"󰯸",
										"󰯻",
										"󰯾",
										"󰰁",
									}
								},
								todo = {
									cancelled = {
										icon = "󰚃",
									},
									done = {
										icon = "󱤅",
									},
									pending = {
										icon = "󰓏",
									},
									on_hold = {
										icon = "󰙦",
									},
									recurring = {
										icon = "󱍸",
									},
									uncertain = {
										icon = "",
									},
									undone = {
										icon = "",
									},
									urgent = {
										icon = "󱠇",
									}
								}
							},
						},
					},
					["core.export"] = {},
					["core.export.markdown"] = {
						config = {
							extensions = "all",
						},
					},
					["core.keybinds"] = {},
					["external.neorg-dew"] = {},
					["external.query"] = {},
					["external.dew-catngo"] = {
						config = {
							exclude_cat_prefix = "#", -- all categories prefixed by "#" will be ignored
						},
					},
					["core.dirman"] = {
						config = {
							workspaces = {
								org_mode = "~/org",
							},
							default_workspace = "org_mode",
						},
					},
					["core.integrations.otter"] = {},
					["core.integrations.treesitter"] = {
						config = {
							configure_parsers = true,
						}
					},
					["external.many-mans"] = {
						config = {
							metadata_fold = true, -- If want @data property ... @end to fold
							code_fold = true, -- If want @code ... @end to fold
						}
					},
					-- OPTIONAL
					["external.agenda"] = {
						config = {
							workspace = nil, -- or set to "tasks_workspace" to limit agenda search to just that workspace
						}
					},
					["external.roam"] = {
						config = {
							fuzzy_finder = "Telescope", -- OR "Fzf" OR "Snacks". Defaults to "Telescope"
							fuzzy_backlinks = false, -- Set to "true" for backlinks in fuzzy finder instead of buffer
							roam_base_directory = "", -- Directory in current workspace to store roam nodes
							node_no_name = false, -- no suffix name in node filename
							node_name_randomiser = false, -- Tokenise node name suffix for more randomisation
							node_name_snake_case = false, -- snake_case the names if node_name_randomiser = false
						}
					},
					["external.interim-ls"] = {
						config = {
							completion_provider = {
								enable = true,
								documentation = true,
								-- Try to complete categories provided by Neorg Query. Requires `benlubas/neorg-query`
								categories = true,
								-- suggest heading completions from the given file for `{@x|}` where `|` is your cursor
								-- and `x` is an alphanumeric character. `{@name}` expands to `[name]{:$/people:# name}`
								people = {
									enable = true,
									-- path to the file you're like to use with the `{@x` syntax, relative to the
									-- workspace root, without the `.norg` at the end.
									-- ie. `folder/people` results in searching `$/folder/people.norg` for headings.
									-- Note that this will change with your workspace, so it fails silently if the file
									-- doesn't exist
									path = "people",
								}
							}
						}
					},
				}
			}
			vim.wo.foldlevel = 99
			vim.wo.conceallevel = 2
		end,
	},
	{
		"setupyourskills/dew-catngo",
		dependencies = {
			"setupyourskills/neorg-dew",
			"benlubas/neorg-query",
			"nvim-telescope/telescope.nvim",
		},
	},
	{
		dir = "~/projects/cogitare.lua",
		name = "cogitare",
		opts = {
			neorg_workspace = "org_mode",
		}
	}
}
