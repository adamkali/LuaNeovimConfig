-- Add additional capabilities supported by nvim-cmp
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- luasnip setup
local luasnip = require 'luasnip'

-- nvim-cmp setup
local cmp = require 'cmp'

local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local luasnip = require("luasnip")
local cmp = require("cmp")

local rusttoolsopts = {
    tools = {
        runnables = {
            user_telescope = true,
        },
        inlay_hints = {
            auto = true,
            show_parameter_hints = true,
            parameter_hinte_prefix = "🤔 ",
            other_hints_prefix = "",
        },
        server = {
            on_attach = function(_, bufnr)
                -- Hover actions
                vim.keymap.set("n", "<leader>p", rt.hover_actions.hover_actions, { buffer = bufnr })
                -- Code action groups
                vim.keymap.set("n", "<leader>", rt.code_action_group.code_action_group, { buffer = bufnr })
            end,
        },
    },
}

require"rust-tools".setup(rusttoolsopts)

local sign = function(opts)
    vim.fn.sign_define(opts.name, {
        texthl = opts.name,
        text = opts.text,
        numhl = ''
    })
end

sign({name = 'DiagnosticSignError', text = '👿'})
sign({name = 'DiagnosticSignWarn', text = '🙃'})
sign({name = 'DiagnosticSignHint', text = '🤔'})
sign({name = 'DiagnosticSignInfo', text = '💡'})

vim.diagnostic.config({
    virtual_text = false,
    signs = true,
    update_in_insert = true,
    underline = true,
    severity_sort = false,
})

vim.cmd([[
    set signcolumn=yes
    autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false })
]])

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

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
        { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
    }, {
        { name = 'buffer' },
    })
})

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = 'buffer' }
    }
})

    -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = 'path' }
    }, {
        { name = 'cmdline' }
    })
})

    -- Set up lspconfig.
local capabilities = require('cmp_nvim_lsp').default_capabilities()

require('lspconfig')['pyright'].setup{
    capabilities = capabilities
}

require('lspconfig')['tsserver'].setup{
    capabilities = capabilities
}

require('lspconfig')['rust_analyzer'].setup{
    capabilities = capabilities
}

require('lspconfig')['gopls'].setup{
    capabilities = capabilities
}

require'lspconfig'.svelte.setup{
    capabilities = capabilities
}
require'lspconfig'.tailwindcss.setup{
    capabilities = capabilities
}
require'lspconfig'.texlab.setup{
    capabilities = capabilities
}

require'lspconfig'.omnisharp.setup{
    capabilities = capabilities
}
