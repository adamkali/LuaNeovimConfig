local lsp = require('lsp-zero')
local capabilities = require('cmp_nvim_lsp').default_capabilities()

local base_actions = function(_, opts)
    vim.keymap.set('n', 'gD', function() vim.lsp.buf.declaration() end, opts)
    vim.keymap.set('n', 'gd', function() vim.lsp.buf.definition() end, opts)
    vim.keymap.set('n', 'gi', function() vim.lsp.buf.implementation() end, opts)
    vim.keymap.set('n', 'gr', function() vim.lsp.buf.rename() end, opts)
    vim.keymap.set('n', 'gR', function() vim.lsp.buf.references() end, opts)
    vim.keymap.set('n', '<leader>vwa', function() vim.lsp.buf.add_workspace_folder() end, opts)
    vim.keymap.set('n', '<leader>vwr', function() vim.lsp.buf.remove_workspace_folder() end, opts)
    vim.keymap.set('n', '<leader>vws', function() vim.lsp.buf.workspace_symbol() end, opts)
    vim.keymap.set('n', '<leader>vca', function() vim.lsp.buf.code_action() end, opts)
    vim.keymap.set('n', 'K', function() vim.lsp.buf.hover() end, opts)
    vim.keymap.set('n', '[d', function() vim.diagnostic.goto_prev() end, opts)
    vim.keymap.set('n', ']d', function() vim.diagnostic.goto_next() end, opts)
end

--------------------------------------------------------------------------------------------
-- RUST
--------------------------------------------------------------------------------------------
local rust_tools = require('rust-tools')

local rust_tools_actions = function(_, bufnr)
    local opts = { remap = true, silent = true, buffer = bufnr }
    base_actions(_, opts)
    vim.keymap.set('n', '<leader>vlh', rust_tools.hover_actions.hover_actions, opts)
    vim.keymap.set('n', '<leader>vlr', rust_tools.code_action_group.code_action_group, opts)
end

local rust_tools_opts = {
    tools = {
        runnables = {
            use_telescope = true
        },
        inlay_hints = {
            show_parameter_hints = true,
            max_len_align = false,
            max_len_align_padding = 1,
            right_align = false,
            right_align_padding = 7,
        },
    },
    server = {
        on_attach = rust_tools_actions,
        capabilities = capabilities,
        standalone = true,
        settings = {
            ["rust-analyzer"] = {
                checkOnSave = {
                    command = "clippy"
                },
                cargo = {
                    features = "all"

                },
                workspace = {
                    symbol = {
                        maxColumnLength = 50,
                        maxLength = 50,
                        search = {
                            kind = "all_kinds",
                        }
                    },
                    useRustfmt = true,
                    procMacro = {
                        enable = true
                    },
                    experimental = {
                        procAttrMacros = true
                    }
                },
            }
        }
    }
}

-- print "Rust-tools setup"
rust_tools.setup(rust_tools_opts)

-------------------------------------------------------------------------------------------------- 
-- OmniSharp
-------------------------------------------------------------------------------------------------- 
local pid = vim.fn.getpid()
local omnisharp_bin = "C:/Users/adam/AppData/Local/omnisharp-roslyn/OmniSharp.exe"

require'lspconfig'.omnisharp.setup{
    handlers = {
        ["textDocument/publishDiagnostics"] = vim.lsp.with(
            vim.lsp.diagnostic.on_publish_diagnostics, {
                virtual_text = false,
                signs = true,
                underline = true,
                update_in_insert = true,
            }
        ),
        ["textDocument/definition"] = require'omnisharp_extended'.handler,
    },
    cmd = { omnisharp_bin, "--languageserver" , "--hostPID", tostring(pid) },
    on_attach = lsp.on_attach,
    capabilities = capabilities,
    flags = lsp.flags,
}


-------------------------------------------------------------------------------------------------- 
-- TypeScript
-------------------------------------------------------------------------------------------------- 
local ts_utils = require("typescript")

local ts_tools_actions = function(_, bufnr)
    local opts = { remap = true, silent = true, buffer = bufnr }
    base_actions(_, opts)

    -- this uses the direct vim command to use the current buffir and prompt for a rename target
    -- the lua function requires a target to be passed in and I do not want to do that
    vim.keymap.set('n', '<leader>vlr', "<cmd>:TypescriptRenameFile<CR>", opts)

    -- this is just used as a wrapper to each os the actions to be ran at once
    vim.keymap.set('n', '<leader>vli', function ()
        ts_utils.actions.addMissingImports()
        ts_utils.actions.organizeImports()
        ts_utils.actions.removeUnused()
    end, opts)

end

ts_utils.setup({
    disable_commands = false, -- prevent the plugin from creating Vim commands
    debug = false, -- enable debug logging for commands
    go_to_source_definition = { fallback = true, }, -- fall back to standard LSP definition on failure 
    server = { -- pass options to lspconfig's setup method
        on_attach = ts_tools_actions,
    },
})
