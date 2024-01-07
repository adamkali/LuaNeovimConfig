return {
    {
        'hrsh7th/nvim-cmp',
        config = function()
            local cmp = require('cmp')

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

            mapping = cmp.mapping.preset.insert({
                ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                ['<C-f>'] = cmp.mapping.scroll_docs(4),
                ['<C-Space>'] = cmp.mapping.complete(),
                ['<C-e>'] = cmp.mapping.abort(),
                ['<CR>'] = cmp.mapping.confirm({ select = true }),
            })
            sources = cmp.config.sources(
                {
                    { name = 'nvim_lsp' },
                    { name = 'luasnip' }, -- For luasnip users.
                },
                {
                    { name = 'buffer' },
                }
            )

            local sign = function (opts)
                vim.fn.sign_define(opts.name, {text = opts.text, texthl = opts.color, linehl = '', numhl = ''})
            end

            sign({ name = 'DiagnosticSignError', text = '󱚝 ', color = 'LspDiagnosticsDefaultError' })
            sign({ name = 'DiagnosticSignWarn',  text = '󱚟 ', color = 'Function' })
            sign({ name = 'DiagnosticSignInfo',  text = '󰚩 ', color = 'Comment' })
            sign({ name = 'DiagnosticSignHint',  text = '󱜙 ', color = 'Keyword' })
            
            cmp.setup({
                snippet = {
                    expand = function(args)
                        require('luasnip').lsp_expand(args.body)
                    end,
                },
                window = {
                    completion = {
                        winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
                        col_offset = -3,
                        side_padding = 0,
                    },
                    bor
                    
                },
                formatting = {
                    fields = { "kind", "abbr", "menu" }, 
                    format = function(entry, vim_item)
                        local kind = require("lspkind").cmp_format({ mode = "symbol_text", maxwidth = 50 })(entry, vim_item)
                        local strings = vim.split(kind.kind, "%s", { trimempty = true })
                        kind.kind = cmp_kinds[strings[2]] or stirngs[1]
                        kind.menu = "    (" .. (strings[2] or "") .. ")"

                        return kind
                    end,
                },
                mapping = {
                    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
                    ['<Tab>'] = cmp.mapping.select_next_item(),
                    ['<C-n>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-t>'] = cmp.mapping.scroll_docs(4),
                    ['<C-e>'] = cmp.mapping.close(),
                    ['<CR>'] = cmp.mapping.confirm({
                        behavior = cmp.ConfirmBehavior.Replace,
                        select = true,
                    }),
                },
                sources = {
                    { name = 'nvim_lsp' },
                    { name = 'luasnip' },
                    { name = 'buffer' },
                    { name = 'path' },
                }
            })
            
            -- Customization for Pmenu
            vim.api.nvim_set_hl(0, "CmpItemAbbrDeprecated", { fg = "#7E8294", bg = "NONE", strikethrough = true })
            vim.api.nvim_set_hl(0, "CmpItemAbbrMatch", { fg = "#82AAFF", bg = "NONE", bold = true })
            vim.api.nvim_set_hl(0, "CmpItemAbbrMatchFuzzy", { fg = "#82AAFF", bg = "NONE", bold = true })
            vim.api.nvim_set_hl(0, "CmpItemMenu", { fg = "#C792EA", bg = "NONE", italic = true })

            vim.api.nvim_set_hl(0, "CmpItemKindField", { fg = "#2a79b5", bg = "NONE" })
            vim.api.nvim_set_hl(0, "CmpItemKindProperty", { fg = "#2a79b5", bg = "NONE" })
            vim.api.nvim_set_hl(0, "CmpItemKindEvent", { fg = "#2ab5b0", bg = "NONE" })

            vim.api.nvim_set_hl(0, "CmpItemKindText", { fg = "#2a79b5", bg = "NONE" })
            vim.api.nvim_set_hl(0, "CmpItemKindEnum", { fg = "#c70aa4", bg = "NONE" })
            vim.api.nvim_set_hl(0, "CmpItemKindKeyword", { fg = "#7e0ac7", bg = "NONE" })

            vim.api.nvim_set_hl(0, "CmpItemKindConstant", { fg = "#2a79b5", bg = "NONE" })
            vim.api.nvim_set_hl(0, "CmpItemKindConstructor", { fg = "#130ac7", bg = "NONE" })
            vim.api.nvim_set_hl(0, "CmpItemKindReference", { fg = "#130ac7", bg = "NONE" })

            vim.api.nvim_set_hl(0, "CmpItemKindFunction", { fg = "#130ac7", bg = "NONE" })
            vim.api.nvim_set_hl(0, "CmpItemKindStruct", { fg = "#f71e95", bg = "NONE" })
            vim.api.nvim_set_hl(0, "CmpItemKindClass", { fg = "#c70a6c", bg = "NONE" })
            vim.api.nvim_set_hl(0, "CmpItemKindModule", { fg = "#870036", bg = "NONE" })
            vim.api.nvim_set_hl(0, "CmpItemKindOperator", { fg = "#0f1e5c", bg = "NONE" })

            vim.api.nvim_set_hl(0, "CmpItemKindVariable", { fg = "#00874f", bg = "NONE" })
            vim.api.nvim_set_hl(0, "CmpItemKindFile", { fg = "#8cfacc", bg = "NONE" })

            vim.api.nvim_set_hl(0, "CmpItemKindUnit", { fg = "#8cf4fa", bg = "NONE" })
            vim.api.nvim_set_hl(0, "CmpItemKindSnippet", { fg = "#57a7f2", bg = "NONE" })
            vim.api.nvim_set_hl(0, "CmpItemKindFolder", { fg =  "#f25788", bg = "NONE" })

            vim.api.nvim_set_hl(0, "CmpItemKindMethod", { fg = "#130ac7", bg = "NONE" })
            vim.api.nvim_set_hl(0, "CmpItemKindValue", { fg = "#DDE5F5", bg = "NONE" })
            vim.api.nvim_set_hl(0, "CmpItemKindEnumMember", { fg = "#c70aa4", bg = "NONE" })

            vim.api.nvim_set_hl(0, "CmpItemKindInterface", { fg = "#c70a6c", bg = "NONE" })
            vim.api.nvim_set_hl(0, "CmpItemKindColor", { fg = "#4903fc", bg = "NONE" })
            vim.api.nvim_set_hl(0, "CmpItemKindTypeParameter", { fg = "#fc03db", bg = "NONE" })

        end
    },
    {
        'hrsh7th/cmp-nvim-lsp',
    },
    {
        'hrsh7th/cmp-buffer',
    },
    {
        'hrsh7th/cmp-cmdline',
    },
    {
        'hrsh7th/cmp-path',
    },
    {
        'L3MON4D3/LuaSnip'
    },
    {
        'L3MON4D3/LuaSnip'
    },
    {
        'saadparwaiz1/cmp_luasnip'
    },
    {
        'onsails/lspkind.nvim'
    }
}

