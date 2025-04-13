return {
    "nvim-neorg/neorg",
    lazy = false,
    version = "*",
    config = function()
        require("neorg").setup {
            load = {
                ["core.defaults"] = {},
                ["core.autocommands"] = {},
                ["core.concealer"] = {},
                ["core.export"] = {},
                ["core.export.markdown"] = { config = { extensions="all" }},
                ["core.keybinds"] = {},
                ["core.dirman"] = {
                    config = {
                        workspaces = {
                            org_mode = "~/org",
                        },
                        default_workspace = "org_mode",
                    },
                },
            },
        }
        vim.wo.foldlevel = 99
        vim.wo.conceallevel = 2
    end,
}
