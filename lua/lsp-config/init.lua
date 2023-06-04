local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
    local bufopts = { noremap=true, silent=true, buffer=bufnr }
    vim.keymap.set('n', '<leader>gD', vim.lsp.buf.declaration, bufopts)             
    vim.keymap.set('n', '<leader>gd', vim.lsp.buf.definition, bufopts)              
    vim.keymap.set('n', '<leader>gi', vim.lsp.buf.implementation, bufopts)         
    vim.keymap.set('n', '<leader>gr', vim.lsp.buf.rename, bufopts)          -- Rename symbol 
    vim.keymap.set('n', '<leader>-', vim.lsp.buf.type_definition, bufopts) -- Code action
    vim.keymap.set('n', 
        'lf', 
        function() vim.lsp.buf.format { async = true } end, 
        bufopts) -- Format code
end

local lsp_flags = {
    debounce_text_changes = 150,
}

require("mason").setup({
    ui = {
        icons = {
            package_installed = "󱜙 ",
            package_pending = " ",
            package_uninstalled = "󱠡 "
        }
    }
})

require("mason-lspconfig").setup {
    ensure_installed = { 
        "lua_ls", 
        "rust_analyzer",
        "pyright",
        "tsserver",
        "svelte",
        "texlab",
        "marksman",
        "dockerls",
        "docker_compose_language_service",
        "tailwindcss",
        "gopls",
        "omnisharp",
    },
}

require('lspconfig')['rust_analyzer'].setup{
    on_attach = on_attach,
    flags = lsp_flags,
    -- Server-specific settings...
    settings = {
        ["rust-analyzer"] = {
            checkOnSave = {
                command = "clippy"
            },
            workspace = {
                symbol = {
                    search = {
                        kind = "all_symbols"
                    }
                }
            },
            imports = {
                granularity = {
                    enforce = false
                },
            },
            inlay_hints = {
              auto = true,
              parameter_hints_prefix = "󱘗 ",
              highlight = "Comment",
            }
        },
    }
}

local pid = vim.fn.getpid()
--local omnisharp_bin = "C:/Users/adam/AppData/Local/omnisharp-roslyn/OmniSharp.exe" -- Laptop
local omnisharp_bin = "P:/omnisharp/OmniSharp.exe" -- Desktop

local config = {
  handlers = {
    ["textDocument/definition"] = require('omnisharp_extended').handler,
  },
  cmd = { omnisharp_bin, '--languageserver' , '--hostPID', tostring(pid) },
}

require'lspconfig'.omnisharp.setup(config)
