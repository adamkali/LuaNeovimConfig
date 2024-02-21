
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
    },
    { "folke/neodev.nvim", opts = {} },
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
                "omnisharp",
                "emmet_ls",
                "pyright"
            }
            require("mason-lspconfig").setup {
                ensure_installed = servers,
            }
            local lspconfig = require"lspconfig"
            local wk = require'which-key'
            local capabilities = require'cmp_nvim_lsp'.default_capabilities()
            local base_actions = function()
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
                        a = {
                            function ()
                                vim.diagnostic.goto_prev({popup_opts = {border = "rounded", focusable = false}})
                            end,
                            'Go to previous diagnostic'
                        },
                        s = {
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
            for i, value in ipairs(servers) do
                lspconfig[value].setup{
                    on_attatch = base_actions(),
                    capabilities = capabilities
                }
            end
        end
    },
}

