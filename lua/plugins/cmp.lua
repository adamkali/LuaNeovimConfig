return {
    {
        'hrsh7th/nvim-cmp',
        dependencies = {
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-cmdline',
            'hrsh7th/cmp-path',
            'saadparwaiz1/cmp_luasnip',
            'onsails/lspkind.nvim',
        },
        config = function()
            local cmp = require('cmp')
            local luasnip = require 'luasnip'

            local cmp_tab = function(fallback)
                if cmp.visible() then
                    cmp.select_next_item()
                elseif luasnip.expandable() then
                    luasnip.expand()
                elseif luasnip.expand_or_jumpable() then
                    luasnip.expand_or_jump()
                else
                    fallback()
                end
            end

            local cmp_tab_shift = function(fallback)
                if cmp.visible() then
                    cmp.select_prev_item()
                elseif luasnip.jumpable(-1) then
                    luasnip.jump(-1)
                else
                    fallback()
                end
            end
            local sign = function(opts)
                vim.fn.sign_define(opts.name, { text = opts.text, texthl = opts.color, linehl = '', numhl = '' })
            end

            sign({ name = 'DiagnosticSignError', text = '󱚝 ', color = 'LspDiagnosticsDefaultError' })
            sign({ name = 'DiagnosticSignWarn', text = '󱚟 ', color = 'Function' })
            sign({ name = 'DiagnosticSignInfo', text = '󰚩 ', color = 'Comment' })
            sign({ name = 'DiagnosticSignHint', text = '󱜙 ', color = 'Keyword' })

            cmp.setup({
                mapping = {
                    ['<S-Tab>'] = cmp.mapping(cmp_tab_shift, { "i", "s", "c" }),
                    ['<Tab>'] = cmp.mapping(cmp_tab, { "i", "s", "c" }),
                    ['<C-n>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-t>'] = cmp.mapping.scroll_docs(4),
                    ['<C-e>'] = cmp.mapping.close(),
                    ['<CR>'] = cmp.mapping.confirm({
                        behavior = cmp.ConfirmBehavior.Replace,
                        select = true,
                    }),
                },
                formatting = {
                    expandable_indicator = true,
                    fields = { "kind", "abbr", "menu" },
                    format = function(entry, vim_item)
                        local cmp_kinds = {
                            Text = '󰈍 ',
                            Method = ' ',
                            Function = '󰘧 ',
                            Constructor = '󰣪 ',
                            Field = '󰂡 ',
                            Variable = '󰀫 ',
                            Class = '󱙧 ',
                            Interface = '󰀴 ',
                            Module = '󰕳 ',
                            Property = '󰏉 ',
                            Unit = '󰿗 ',
                            Value = '󰊦 ',
                            Enum = '󱂟 ',
                            Keyword = '󰇈 ',
                            Snippet = '󱦤 ',
                            Color = '󰢵 ',
                            File = '󰎞 ',
                            Reference = '󱇵 ',
                            Folder = '󰹕 ',
                            EnumMember = ' ',
                            Constant = '󱃮 ',
                            Struct = '󱢇 ',
                            Event = '󱅗 ',
                            Operator = '󰘫 ',
                        }
                        local kind = require("lspkind").cmp_format({ mode = "symbol_text", maxwidth = 50 })(entry,
                            vim_item)
                        local strings = vim.split(kind.kind, "%s", { trimempty = true })
                        if strings ~= nil then
                            kind.kind = cmp_kinds[strings[2]] or strings[1]
                            kind.menu = "    (" .. (strings[2] or "") .. ")"
                        else
                            kind.kind = ""
                            kind.menu = ""
                        end
                        return kind
                    end,
                },
                sources = {
                    { name = 'nvim_lsp' },
                    { name = 'luasnip' },
                    { name = 'buffer' },
                    { name = 'path' },
                },
            })
            -- `:` cmdline setup.
            cmp.setup.cmdline(':', {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources({
                    { name = 'path' }
                }, {
                    {
                        name = 'cmdline',
                        option = {
                            ignore_cmds = { 'Man', '!' }
                        }
                    }
                })
            })
        end
    },
    {
        'L3MON4D3/LuaSnip'
    },
    {
        'L3MON4D3/LuaSnip',
        dependencies = { "rafamadriz/friendly-snippets" },
        opts = function()
            require("luasnip.loaders.from_vscode").lazy_load()
        end
    },
}
