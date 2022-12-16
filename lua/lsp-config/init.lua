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

-- require'lspconfig'.omnisharp.setup {
  --  cmd = { "dotnet", "/path/to/omnisharp/OmniSharp.dll" },

    -- Enables support for reading code style, naming convention and analyzer
    -- settings from .editorconfig.
   -- enable_editorconfig_support = true,

    -- If true, MSBuild project system will only load projects for files that
    -- were opened in the editor. This setting is useful for big C# codebases
    -- and allows for faster initialization of code navigation features only
    -- for projects that are relevant to code that is being edited. With this
    -- setting enabled OmniSharp may load fewer projects and may thus display
    -- incomplete reference lists for symbols.
    --enable_ms_build_load_projects_on_demand = false,

    -- Enables support for roslyn analyzers, code fixes and rulesets.
    --enable_roslyn_analyzers = false,

    -- Specifies whether 'using' directives should be grouped and sorted during
    -- document formatting.
    --organize_imports_on_format = false,

    -- Enables support for showing unimported types and unimported extension
    -- methods in completion lists. When committed, the appropriate using
    -- directive will be added at the top of the current file. This option can
    -- have a negative impact on initial completion responsiveness,
    -- particularly for the first few completion sessions after opening a
    -- solution.
    --enable_import_completion = false,

    -- Specifies whether to include preview versions of the .NET SDK when
    -- determining which version to use for project loading.
    --sdk_include_prereleases = true,

    -- Only run analyzers against open files when 'enableRoslynAnalyzers' is
    -- true
    --analyze_open_documents_only = false,
--}
