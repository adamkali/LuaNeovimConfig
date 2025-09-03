-- Setup Neorg with some basic settings

return {
    {

        "nvim-neorg/neorg",
        lazy = false,
        version = "*",
        config = function()
            require("neorg").setup {
                load = {
                    ["core.defaults"] = {},
                    ["core.autocommands"] = {},
					["core.esupports.metagen"] = {
						config = {
							author = "Adam Kalinowski",
						}
					},
                    ["core.concealer"] = {
                        config = {
                            icons = {
                                heading = {
                                    enabled = true,
                                    icons = {
                                        "𞴁",
                                        "𞴂",
                                        "𞴃",
                                        "𞴄",
                                        "𞴅",
                                        "𞴆",
                                        "𞴇",
                                        "𞴈",
                                        "𞴉",
                                        "𞴊",
                                    }
                                },
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
                },
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
    }
}
