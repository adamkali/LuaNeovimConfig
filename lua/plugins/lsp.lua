local capabilities = require('cmp_nvim_lsp').default_capabilities()

return {
    {
        "williamboman/mason.nvim",
        dependencies = {
            "williamboman/mason-lspconfig.nvim",
        },
        keys = {
            { "+mu", "<cmd>:MasonUpdate<cr>", desc = "Mason Update" },
            { "+mo", "<cmd>:Mason <cr>", desc = "Mason Open Menu" }
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
        config = function()
            local wk = require'which-key'
            require("mason").setup()
        end
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            require("mason-lspconfig").setup {
                ensure_installed = {
                    "lua_ls",
                    "rust_analyzer",
                    "gopls",
                    "tsserver",
                    "docker_compose_language_service",
                    "dockerls",
                    "htmx",
                    "html",
                    "svelte",
                    "marksman",
                    "tailwindcss",
                    "omnisharp",
                },
            }
            local lspconfig = require("lspconfig")
            local wk = require'which-key'
            local base_actions = function(_, opts)
                local opts = {
                    mode = "n", -- NORMAL mode
                    prefix = "",
                    buffer = bufnr, -- Global mappings. Specify a buffer number for buffer local mappings
                    silent = true, -- use `silent` when creating keymaps
                    noremap = true, -- use `noremap` when creating keymaps
                    nowait = false, -- use `nowait` when creating keymaps
                    expr = false, -- use `expr` when creating keymaps
                }
                wk.register({
                    g = {
                        name = 'LSP Generic',
                        d = { function() vim.lsp.buf.definition() end, 'Go to definition' },
                        D = { function() vim.lsp.buf.declaration() end, 'Go to declaration' },
                        i = { function() vim.lsp.buf.implementation() end, 'Go to implementation' },
                        r = { function() vim.lsp.buf.rename() end, 'Rename File' },
                        R = { function() vim.lsp.buf.references() end, 'Find References' },
                        K = { function () vim.lsp.buf.hover() end, 'Show Hover Actions'},
                        ['['] = {
                            function ()
                                vim.diagnostic.goto_prev({popup_opts = {border = "rounded", focusable = false}})
                            end,
                            'Go to previous diagnostic'
                        },
                        [']'] = {
                            function ()
                                vim.diagnostic.goto_next({popup_opts = {border = "rounded", focusable = false}})
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
            end
            local opts = {
                mode = "n", -- NORMAL mode
                prefix = "",
                buffer = bufnr, -- Global mappings. Specify a buffer number for buffer local mappings
                silent = true, -- use `silent` when creating keymaps
                noremap = true, -- use `noremap` when creating keymaps
                nowait = false, -- use `nowait` when creating keymaps
                expr = false, -- use `expr` when creating keymaps
            }
            lspconfig.lua_ls.setup{
                on_attach = base_actions(_, opts)
            }
            lspconfig.gopls.setup{
                on_attach = base_actions(_, opts)
            }
            lspconfig.htmx.setup {
                on_attach = base_actions(_, opts)
            }
            lspconfig.html.setup{
                on_attach = base_actions(_,opts)
            }
            lspconfig.docker_compose_language_service.setup{
                on_attach = base_actions(_, opts)
            }
            lspconfig.dockerls.setup{
                on_attach = base_actions(_, opts)
            }
            lspconfig.tailwindcss.setup{
                on_attach = base_actions(_, opts),
                userLanguages = {
                    svg = "html"
                }
            }
            lspconfig.tsserver.setup{
                on_attach = base_actions(_, opts)
            }
            lspconfig.marksman.setup{ on_attach = base_actions(_, opts) }
            lspconfig.omnisharp.setup{
                on_attach = base_actions(_,opts)
            }
            lspconfig.svelte.setup{
                on_attach = base_actions(_, opts)
            }
        end
    },
    { "folke/neodev.nvim", opts = {} }
}

