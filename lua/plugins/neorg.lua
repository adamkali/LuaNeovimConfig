-- Setup Neorg with some basic settings

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
                ["core.keybinds"] = {},
                ["core.dirman"] = {
                    config = {
                        workspaces = {
                            org_mode = "~/org",
                        },
                        default_workspace = "org_mode",
                    },
                },
                ["core.integrations.otter"] = {},
            },
        }

        vim.wo.foldlevel = 99
        vim.wo.conceallevel = 2
    end,
}