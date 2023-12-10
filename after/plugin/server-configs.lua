local lsp = require('lsp-zero')
local capabilities = require('cmp_nvim_lsp').default_capabilities()
local wk = require('which-key')
local lualine = require('lualine')
local mason_registry = require('mason-registry')
local mason = require('mason')
local lspconfig = require'lspconfig'

local base_actions = function(_, opts)
    wk.register({
        g = {
            name = 'LSP Generic',
            d = { function() vim.lsp.buf.definition() end, 'Go to definition' },
            D = { function() vim.lsp.buf.declaration() end, 'Go to declaration' },
            i = { function() vim.lsp.buf.implementation() end, 'Go to implementation' },
            r = { function() vim.lsp.buf.rename() end, 'Rename File' },
            R = { function() vim.lsp.buf.references() end, 'Find References' },
            K = { function () vim.lsp.buf.hover() end, 'Show Hover Actions'},
            ['['] = { function ()
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
    opts.prefix = '<leader>'
    wk.register({
        ["vv"] = {
            name = 'LSP Workspace',
            a = { function() vim.lsp.buf.add_workspace_folder() end, 'Add workspace folder' },
            r = { function() vim.lsp.buf.remove_workspace_folder() end, 'Remove workspace folder' },
            l = { function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, 'List workspace folders' },
            s = { function() vim.lsp.buf.workspace_symbol() end, 'Search workspace symbols' },
            c = { function() vim.lsp.buf.code_action() end, 'Code action' },
        },
    }, opts)
end

--------------------------------------------------------------------------------------------
-- RUST
--------------------------------------------------------------------------------------------
local rust_tools = require('rust-tools')

local rust_tools_actions = function(_, bufnr)
    local opts = {
      mode = "n", -- NORMAL mode
      prefix = "",
      buffer = bufnr, -- Global mappings. Specify a buffer number for buffer local mappings
      silent = true, -- use `silent` when creating keymaps
      noremap = true, -- use `noremap` when creating keymaps
      nowait = false, -- use `nowait` when creating keymaps
      expr = false, -- use `expr` when creating keymaps
    }
    base_actions(_, opts)
    opts.prefix = "<leader>"
    wk.register({
        ["a"] = {
            name = "Language Specific",
            ["h"] = { rust_tools.hover_actions.hover_actions, 'Hover actions' },
            ["c"] = { rust_tools.code_action_group.code_action_group, 'Code action group' },
            r = { rust_tools.runnables.runnables, 'Runnables' },
            d = { rust_tools.debuggables.debuggables, 'Debuggables' },
        }
    }, opts)
end

-- nvim mason package registry
-- call the terminal and call $env:NVIM_DBG_PKGS
local ext_path = 'C:\\Users\\adam\\AppData\\Local\\nvim-data\\mason\\packages\\codelldb\\extension\\'
local codelldb_path = ext_path .. 'adapter\\codelldb.exe'
local liblldb_path = ext_path .. 'lldb\\lib\\liblldb.dll'

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
    },
    dap = {
       adapter = require('rust-tools.dap').get_codelldb_adapter(
                codelldb_path, liblldb_path)
    }
}

-- print "Rust-tools setup"
rust_tools.setup(rust_tools_opts)


-------------------------------------------------------------------------------------------------- 
-- TypeScript
-------------------------------------------------------------------------------------------------- 
local ts_utils = require("typescript")

local ts_tools_actions = function(_, bufnr)
    base_actions(_, opts)

    local opts = {
      mode = "n", -- NORMAL mode
      prefix = "",
      buffer = bufnr, -- Global mappings. Specify a buffer number for buffer local mappings
      silent = true, -- use `silent` when creating keymaps
      noremap = true, -- use `noremap` when creating keymaps
      nowait = false, -- use `nowait` when creating keymaps
      expr = false, -- use `expr` when creating keymaps
    }
    base_actions(_, opts)
    opts.prefix = "<leader>"
    wk.register({
        ["vl"] = {
            name = "Language Specific",
            r = { "<cmd>:TSLspRenameFile<CR>", "Rename File" },
            i = {
                function ()
                    ts_utils.actions.addMissingImports()
                    ts_utils.actions.organizeImports()
                    ts_utils.actions.removeUnused()
                end
            , "Import All" },
        }
    }, opts)
    lualine.setup{
        sections = {
            lualine_c = {
                '󰇺  TLS '
            }
        }
    }
end

local pid = vim.fn.getpid()
local omnisharp_bin = "C:/Users/adam/AppData/Local/omnisharp-roslyn/OmniSharp.exe"

lspconfig.omnisharp.setup{ }

ts_utils.setup({
    disable_commands = false, -- prevent the plugin from creating Vim commands
    debug = false, -- enable debug logging for commands
    go_to_source_definition = { fallback = true, }, -- fall back to standard LSP definition on failure 
    server = { -- pass options to lspconfig's setup method
        on_attach = ts_tools_actions,
    },
})

local opts = {
  mode = "n", -- NORMAL mode
  prefix = "",
  buffer = bufnr, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = false, -- use `nowait` when creating keymaps
  expr = false, -- use `expr` when creating keymaps
}
lspconfig.gopls.setup{
    on_attach = base_actions(_, opts)
}

lspconfig.htmx.setup {
    on_attach = base_actions(_, opts)
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



