local lsp = require('lsp-zero')

lsp.preset('recommended')
lsp.ensure_installed({
    'tsserver',
    'tailwindcss-language-server',
    'rust_analyzer',
    'pyright',
    'sumneko_lua',
    "texlab",
    "marksman",
    "dockerls",
    "docker_compose_language_service"
})

lsp.on_attach(function(client, bufnr)
    lsp.default_keymaps({buffer = bufnr})
end)

lsp.set_preferences({
    sign_icons = {
        Error = '👿',
        Warn = '🥺',
        Hint = '🤔',
        Info = '💡',
    }
})

require 'mason' .setup({
    ui = {
        icons = {
            separator = '➜',
            separator_rounded = '➜',
            group = '+',
            error = '✗',
            warning = '',
            info = '',
            hint = '',
            prompt = '',
        },
    },
})


local cmp = require('cmp')

local cmp_kinds = {
  Text = '📜 ',
  Method = '🍺 ',
  Function = '🍷 ',
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
  TypeParameter = '👔 ',
}

cmp.setup({
    snippet = {
        -- REQUIRED - you must specify a snippet engine
        expand = function(args)
            require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
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
        documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-D'] = cmp.mapping.scroll_docs(4),
        ['<C-p>'] = cmp.mapping.complete(),

        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            elseif has_words_before() then
                cmp.complete()
            else
                fallback()
            end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { "i", "s" }),['<C-P>'] = cmp.mapping.abort(),

        ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'luasnip' }, -- For luasnip users.
    }, {
        { name = 'buffer' },
    })
})

lsp.on_attach(function(client, bufnr)
    local opts = { remap = true, silent = true, buffer = bufnr } 
    -- Mappings.
    vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    vim.keymap.set('n', '<leader>vwa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    vim.keymap.set('n', '<leader>vwr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    vim.keymap.set('n', '<leader>vca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    vim.keymap.set('n', '<leader>vrr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    vim.keymap.set('n', '<leader>vrn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    vim.keymap.set('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts) 
    vim.keymap.set('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
end)

lsp.setup()
