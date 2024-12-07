vim.filetype.add({ extension = { templ = "templ" } })

local on_attatch = function(client, buffer)
end

return {
    {
        "williamboman/mason.nvim",
        dependencies = {
            "williamboman/mason-lspconfig.nvim",
            "folke/neoconf.nvim",
            "folke/neodev.nvim",
        },
        keys = {
            { "+mu", "<cmd>:MasonUpdate<cr>", desc = "Mason Update" },
            { "+mo", "<cmd>:Mason <cr>",      desc = "Mason Open Menu" }
        },
        opts = {
            ui = {
                icons = {
                    package_installed = "",
                    package_pending = "󱧘 ",
                    package_uninstalled = "󰏗 "
                }
            }
        },
    },
    {
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {},
        keys = function()
            return {
                { "<leader>tt", "<cmd>TodoTelescope keywords=TODO,FIX<cr>", desc = "Search TODOs" },
                { "<leader>tw", "<cmd>TodoTelescope keywords=WARN<cr>",     desc = "Search WARNs" },
            }
        end
    },
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            {
                "folke/lazydev.nvim",
                ft = "lua", -- only load on lua files
                opts = {
                    library = {
                        -- See the configuration section for more details
                        -- Load luvit types when the `vim.uv` word is found
                        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
                    },
                },
            },
        },
        keys = {
            { "g",  expr = false,                                group = "LSP Generic",         nowait = false, remap = false },
            { "gA", function() vim.lsp.buf.code_action() end,    desc = 'Code action',          expr = false,   nowait = false, remap = false },
            { "gD", function() vim.lsp.buf.declaration() end,    desc = "Go to declaration",    expr = false,   nowait = false, remap = false },
            { "gK", function() vim.lsp.buf.hover() end,          desc = "Show Hover Actions",   expr = false,   nowait = false, remap = false },
            { "gR", function() vim.lsp.buf.references() end,     desc = "Find References",      expr = false,   nowait = false, remap = false },
            { "gd", function() vim.lsp.buf.definition() end,     desc = "Go to definition",     expr = false,   nowait = false, remap = false },
            { "gi", function() vim.lsp.buf.implementation() end, desc = "Go to implementation", expr = false,   nowait = false, remap = false },
            { "gr", function() vim.lsp.buf.rename() end,         desc = "Rename File",          expr = false,   nowait = false, remap = false },
            {
                "ga",
                function()
                    vim.diagnostic.goto_prev({ popup_opts = { border = "rounded", focusable = false } })
                end,
                desc = "Go to previous diagnostic",
                expr = false,
                nowait = false,
                remap = false
            },
            {
                "gs",
                function()
                    vim.diagnostic.goto_next({ popup_opts = { border = "rounded", focusable = false } })
                end,
                desc = "Go to next diagnostic",
                expr = false,
                nowait = false,
                remap = false
            },
        },
        config = function()
            local servers = {
                "lua_ls",
                "gopls",
                "ts_ls",
                "docker_compose_language_service",
                "dockerls",
                "htmx",
                "html",
                "svelte",
                "marksman",
                "tailwindcss",
                "sqlls",
                "emmet_ls",
                "templ",
                "pyright"
            }

            require("mason-lspconfig").setup {
                ensure_installed = servers,
            }
            local lspconfig = require "lspconfig"
            local capabilities = require 'cmp_nvim_lsp'.default_capabilities()
            for i, value in ipairs(servers) do
                lspconfig[value].setup {
                    capabilities = capabilities
                }
            end
            -- for gleam as well
            lspconfig.gleam.setup({
                capabilities = capabilities
            })
            lspconfig.html.setup({
                capabilities = capabilities,
                filetypes = { "html", "templ" },
            })
            lspconfig.htmx.setup({
                capabilities = capabilities,
                filetypes = { "html", "templ" },
            })
            lspconfig.tailwindcss.setup({
                capabilities = capabilities,
                filetypes = { "templ", "astro", "javascript", "typescript", "react", "svelte" },
                settings = {
                    tailwindCSS = {
                        includeLanguages = {
                            templ = "html",
                        },
                    },
                },
            })
            lspconfig.omnisharp.setup({
                capabilities = capabilities,
                enable_roslyn_analysers = true,
                enable_import_completion = true,
                organize_imports_on_format = true,
                enable_decompilation_support = true,
                filetypes = { 'cs', 'vb', 'csproj', 'sln', 'slnx', 'props', 'csx', 'targets' }
            })
        end
    },
}
