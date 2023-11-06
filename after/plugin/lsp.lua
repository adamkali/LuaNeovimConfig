local lsp = require('lsp-zero')
local capabilities = require('cmp_nvim_lsp').default_capabilities()
local wk = require('which-key')
local mason_lsp = require'mason-lspconfig'

lsp.preset('recommended')
lsp.on_attach(function(_, bufnr)
    lsp.default_keymaps({buffer = bufnr})
    lsp.buffer_autoformat()
end)

require'mason'.setup()
mason_lsp.setup{
    ensure_installed = {
        'tsserver',
        'tailwindcss',
        'rust_analyzer',
        'pyright',
        "texlab",
        "marksman",
        "lua_ls",
        "dockerls",
        "docker_compose_language_service",
        "svelte",
        "omnisharp",
    }
}

lsp.on_attach(function(_, bufnr)
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
        ["vw"] = {
            name = 'LSP Workspace',
            a = { function() vim.lsp.buf.add_workspace_folder() end, 'Add workspace folder' },
            r = { function() vim.lsp.buf.remove_workspace_folder() end, 'Remove workspace folder' },
            l = { function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, 'List workspace folders' },
            s = { function() vim.lsp.buf.workspace_symbol() end, 'Search workspace symbols' },
            c = { function() vim.lsp.buf.code_action() end, 'Code action' },
        },
    }, opts)
end)

local sign = function (opts)
    vim.fn.sign_define(opts.name, {text = opts.text, texthl = opts.color, linehl = '', numhl = ''})
end

sign({ name = 'DiagnosticSignError', text = '󱚝 ', color = 'LspDiagnosticsDefaultError' })
sign({ name = 'DiagnosticSignWarn',  text = '󱚟 ', color = 'Function' })
sign({ name = 'DiagnosticSignInfo',  text = '󰚩 ', color = 'Comment' })
sign({ name = 'DiagnosticSignHint',  text = '󱜙 ', color = 'Keyword' })


lsp.set_server_config({
    single_file_support = false,
    capabilities = capabilities,
    flags = {
        debounce_text_changes = 150,
    },
})

lsp.setup()


local cmp = require('cmp')

local cmp_kinds = {
  Text = '📜 ',
  Method = '🍺 ',
  Function = '🍺 ',
  Constructor = '🚧 ',
  Field = '🪶 ',
  Variable = '🍪 ',
  Class = '🦄  ',
  Interface = '🐴 ',
  Module = '🦄 ',
  Property = '🪶 ',
  Unit = '💎 ',
  Value = '💎 ',
  Enum = '🐴 ',
  Keyword = '💎 ',
  Snippet = '🍺 ',
  Color = '🎨 ',
  File = '💼 ',
  Reference = '💼 ',
  Folder = '📂 ',
  EnumMember = '🐎 ',
  Constant = '🔒 ',
  Struct = '🦄 ',
  Event = '🧪 ',
  Operator = '➕ ',
}

cmp.setup({
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end,
    },
    formatting = {
        format = function(_, vim_item)
            vim_item.kind = (cmp_kinds[vim_item.kind] or '') .. vim_item.kind
            return vim_item
        end,
    },
    window = {
        completion = cmp.config.window.bordered(),
        documentaiton = cmp.config.window.bordered(),
    },
    mapping = {
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.close(),
        ['<CR>'] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        }),
        ['<Tab>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 's' }),
    },
    sources = {
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        { name = 'buffer' },
        { name = 'path' },
    }
})
