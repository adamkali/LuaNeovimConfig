vim.filetype.add({ extension = { templ = "templ" } })

local glob_opts = {
    mode = "n",     -- NORMAL mode
    prefix = "",
    buffer = bufnr, -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true,  -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = false, -- use `nowait` when creating keymaps
    expr = false,   -- use `expr` when creating keymaps
}


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
        config = function()
            local servers = {
                "lua_ls",
                --                "rust_analyzer",
                "gopls",
                "tsserver",
                "docker_compose_language_service",
                "dockerls",
                "htmx",
                "html",
                "svelte",
                "marksman",
                "tailwindcss",
                "sqlls",
                -- "omnisharp",
                "emmet_ls",
                "templ",
                "pyright"
            }

            require("mason-lspconfig").setup {
                ensure_installed = servers,
            }
            local lspconfig = require "lspconfig"
            local wk = require 'which-key'
            local capabilities = require 'cmp_nvim_lsp'.default_capabilities()
            local base_actions = function()
                local opts = {
                    mode = "n",     -- NORMAL mode
                    prefix = "",
                    buffer = bufnr, -- Global mappings. Specify a buffer number for buffer local mappings
                    silent = true,  -- use `silent` when creating keymaps
                    noremap = true, -- use `noremap` when creating keymaps
                    nowait = false, -- use `nowait` when creating keymaps
                    expr = false,   -- use `expr` when creating keymaps
                }
                wk.register({
                    g = {
                        name = 'LSP Generic',
                        d = { function() vim.lsp.buf.definition() end, 'Go to definition' },
                        D = { function() vim.lsp.buf.declaration() end, 'Go to declaration' },
                        i = { function() vim.lsp.buf.implementation() end, 'Go to implementation' },
                        r = { function() vim.lsp.buf.rename() end, 'Rename File' },
                        R = { function() vim.lsp.buf.references() end, 'Find References' },
                        K = { function() vim.lsp.buf.hover() end, 'Show Hover Actions' },
                        a = {
                            function()
                                vim.diagnostic.goto_prev({ popup_opts = { border = "rounded", focusable = false } })
                            end,
                            'Go to previous diagnostic'
                        },
                        s = {
                            function()
                                vim.diagnostic.goto_next({ popup_opts = { border = "rounded", focusable = false } })
                            end,
                            'Go to next diagnostic'
                        }
                    }
                }, opts)

                wk.register({
                    ["f"] = {
                        name = 'LSP Workspace',
                        s = { function() vim.lsp.buf.workspace_symbol() end, 'Search workspace symbols' },
                    },
                }, opts)
                wk.register({
                    ["<F2>"] = { function() vim.lsp.buf.code_action() end, 'Code action' }
                })
            end
            for i, value in ipairs(servers) do
                lspconfig[value].setup {
                    on_attatch = base_actions(),
                    capabilities = capabilities
                }
            end
            -- for gleam as well
            lspconfig.gleam.setup({
                on_attatch = base_actions(),
                capabilities = capabilities
            })
            lspconfig.html.setup({
                on_attach = base_actions,
                capabilities = capabilities,
                filetypes = { "html", "templ" },
            })
            lspconfig.htmx.setup({
                on_attach = base_actions,
                capabilities = capabilities,
                filetypes = { "html", "templ" },
            })
            lspconfig.tailwindcss.setup({
                on_attach = base_actions,
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
                on_attach=base_actions(),
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
