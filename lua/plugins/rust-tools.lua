
return {
    "simrat39/rust-tools.nvim",
    lazy = true,
    opts = function()
        local ok, mason_registry = pcall(require, "mason-registry")
        local adapter ---@type any
        if ok then
            -- rust tools configuration for debugging support
            local codelldb = mason_registry.get_package("codelldb")
            local extension_path = codelldb:get_install_path() .. "/extension/"
            local codelldb_path = extension_path .. "adapter/codelldb"
            local liblldb_path = ""
            if vim.loop.os_uname().sysname:find("Windows") then
                liblldb_path = extension_path .. "lldb\\bin\\liblldb.dll"
            elseif vim.fn.has("mac") == 1 then
                liblldb_path = extension_path .. "lldb/lib/liblldb.dylib"
            else
                liblldb_path = extension_path .. "lldb/lib/liblldb.so"
            end
            adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path)
        end
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
        return {
            server = {
                on_attach = base_actions(),
                capabilities = capabilities,
            },
            dap = {
                adapter = adapter,
            },
            tools = {
                on_initialized = function()
                    vim.cmd([[
                    augroup RustLSP
                    autocmd CursorHold                      *.rs silent! lua vim.lsp.buf.document_highlight()
                    autocmd CursorMoved,InsertEnter         *.rs silent! lua vim.lsp.buf.clear_references()
                    autocmd BufEnter,CursorHold,InsertLeave *.rs silent! lua vim.lsp.codelens.refresh()
                    augroup END
                    ]])
                end,
            },
        }
    end,
}
