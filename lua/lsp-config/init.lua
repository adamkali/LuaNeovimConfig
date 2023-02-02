local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)

    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local bufopts = { noremap=true, silent=true, buffer=bufnr }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)             -- Go to declaration
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)              -- Go to definition
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)          -- Go to implementation
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)              -- Go to references
    vim.keymap.set('n', '<leader>lr', vim.lsp.buf.rename, bufopts)          -- Rename symbol 
    vim.keymap.set('n', '<leader>ld', vim.lsp.buf.type_definition, bufopts) -- Code action
    vim.keymap.set('n', '<leader>lf', 
        function() vim.lsp.buf.format { async = true } end, 
    bufopts) -- Format code

end

local lsp_flags = {
    debounce_text_changes = 150,
}

require('lspconfig')['pyright'].setup{
    on_attach = on_attach,
    flags = lsp_flags,
}
require('lspconfig')['tsserver'].setup{
    on_attach = on_attach,
    flags = lsp_flags,
}

require'lspconfig'.svlangserver.setup{}

require('lspconfig')['rust_analyzer'].setup{
    on_attach = on_attach,
    flags = lsp_flags,
    -- Server-specific settings...
    settings = {
        ["rust-analyzer"] = {
            checkOnSave ={
                command = "clippy",
            },

            workspace = {
                symbol = {
                    search = {
                        kind = "all_symbols"
                    }
                }
            }
        },
    }
}

require('lspconfig')['gopls'].setup{
    on_attach = on_attach,
    flags = lsp_flags,
    -- Server-specific settings...
    settings = {
      ["gopls"] = {}
    }
}

require('lspconfig')['luau_lsp'].setup{
    on_attach = on_attach,
    flags = lsp_flags,
    -- Server-specific settings...
    settings = {
      ["luau_lsp"] = {}
    }
}

require'lspconfig'.tailwindcss.setup{}

require'lspconfig'.texlab.setup{}
require'lspconfig'.csharp_ls.setup{}
