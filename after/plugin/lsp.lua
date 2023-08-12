local lsp = require('lsp-zero')
local capabilities = require('cmp_nvim_lsp').default_capabilities()

lsp.preset('recommended')
lsp.ensure_installed({
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
})

lsp.on_attach(function(_, bufnr)
    lsp.default_keymaps({buffer = bufnr})
    lsp.buffer_autoformat()
end)

require'mason'.setup({ })

lsp.on_attach(function(_, bufnr)
    local opts = { remap = true, silent = true, buffer = bufnr }

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
end)

local sign = function (opts)
    vim.fn.sign_define(opts.name, {text = opts.text, texthl = opts.color, linehl = '', numhl = ''})
end

sign({ name = 'DiagnosticSignError', text = '󱚝 ', color = 'LspDiagnosticsDefaultError' })
sign({ name = 'DiagnosticSignWarn', text = '󱚟 ', color = 'Function' })
sign({ name = 'DiagnosticSignInfo', text = '󰚩 ', color = 'Comment' })
sign({ name = 'DiagnosticSignHint', text = '󱜙 ', color = 'Keyword' })


lsp.set_server_config({
    single_file_support = false,
    capabilities = capabilities,
    flags = {
        debounce_text_changes = 150,
    },
})


lsp.skip_server_setup({
    "omnisharp",
    "rust_analyzer",
    "tsserver",
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
