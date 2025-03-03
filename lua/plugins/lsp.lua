vim.filetype.add({ extension = { templ = "templ" } })

local on_attatch = function(_, _)
    local wk = require 'which-key'
    local lsp_leader = "<M-a>"
    wk.add {
        { lsp_leader, expr = false, group = "LSP Generic", nowait = false, remap = false, icon = { icon = "󰧑", hl = "Function" } },
        --
        { lsp_leader .. "A", function() vim.lsp.buf.code_action() end, desc = 'LSP Code action', expr = false, nowait = false, remap = false },
        { lsp_leader .. "D", function() vim.lsp.buf.declaration() end, desc = "LSP Go to declaration", expr = false, nowait = false, remap = false },
        { lsp_leader .. "K", function() vim.lsp.buf.hover() end, desc = "LSP Show Hover Actions", expr = false, nowait = false, remap = false },
        { lsp_leader .. "R", function() vim.lsp.buf.references() end, desc = "LSP Find References", expr = false, nowait = false, remap = false },
        { lsp_leader .. "d", function() vim.lsp.buf.definition() end, desc = "LSP Go to definition", expr = false, nowait = false, remap = false },
        { lsp_leader .. "i", function() vim.lsp.buf.implementation() end, desc = "LSP Go to implementation", expr = false, nowait = false, remap = false },
        { lsp_leader .. "r", function() vim.lsp.buf.rename() end, desc = "LSP Rename File", expr = false, nowait = false, remap = false },
        {
            "<M-x>",
            function()
                vim.diagnostic.goto_prev({ popup_opts = { border = "rounded", focusable = false } })
            end,
            desc = "Go to previous diagnostic",
            expr = false,
            nowait = false,
            remap = false
        },
        {
            "<M-X>",
            function()
                vim.diagnostic.goto_next({ popup_opts = { border = "rounded", focusable = false } })
            end,
            desc = "Go to next diagnostic",
            expr = false,
            nowait = false,
            remap = false
        },
    }
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
                        -- Library paths can be absolute
                        "~/git/vaporlush/lua/vaporlush",
                        -- Or relative, which means they will be resolved from the plugin dir.
                        "lazy.nvim",
                        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
                        { path = "LazyVim",            words = { "LazyVim" } },
                    },
                    -- always enable unless `vim.g.lazydev_enabled = false`
                    -- This is the default
                    enabled = function(_)
                        return vim.g.lazydev_enabled == nil and true or vim.g.lazydev_enabled
                    end,
                },
            },
        },
        config = function()
            local servers = {
                "lua_ls",
                "gopls",
                "ts_ls",
                "docker_compose_language_service",
                "dockerls",
                --"htmx",
                "html",
                "svelte",
                "marksman",
                "tailwindcss",
                "sqlls",
                --"emmet_ls",
                "templ",
                "pyright"
            }

            require("mason-lspconfig").setup {
                ensure_installed = servers,
            }
            local lspconfig = require "lspconfig"
            local capabilities = require 'cmp_nvim_lsp'.default_capabilities()
            for _, value in ipairs(servers) do
                lspconfig[value].setup {
                    on_attatch = on_attatch(),
                    capabilities = capabilities
                }
            end
            -- for gleam as well
            lspconfig.gleam.setup({
                on_attatch = on_attatch,
                capabilities = capabilities
            })
            lspconfig.html.setup({
                on_attatch = on_attatch,
                capabilities = capabilities,
                filetypes = { "html", "templ" },
            })
            --lspconfig.htmx.setup({
            --    on_attatch = on_attatch,
            --    capabilities = capabilities,
            --    filetypes = { "html", "templ" },
            --})
            lspconfig.tailwindcss.setup({
                on_attatch = on_attatch,
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
                on_attatch = on_attatch,
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
