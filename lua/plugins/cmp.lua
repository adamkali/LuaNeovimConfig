-- [saghen/blink.cmp]{https://github.com/saghen/blink.cmp}

local my_kind_icons = {
    Text = '',
    Method = '󰊕',
    Function = '󰘧',
    Constructor = '',

    Field = '󰜢',
    Variable = '',
    Property = '',
    Class = '󱗃',
    Interface = '󱗁',
    Module = '󰌱',
    Struct = '󰩘',

    Unit = '',
    Value = '',
    Enum = '',
    EnumMember = '',

    Keyword = '',
    Constant = '',

    Snippet = '',
    Color = '󰏘',
    File = '󰈔',
    Reference = '󰬲',
    Folder = '󰉋',
    Event = '󱐋',
    Operator = '',
    TypeParameter = '',
}
return {
    'saghen/blink.cmp',
    version = '1.*',

    -- dependencies needed for this setup

    dependencies = {
        {
            'L3MON4D3/LuaSnip',
            dependencies = { "rafamadriz/friendly-snippets" },
            opts = function()
                require("luasnip.loaders.from_vscode").lazy_load()
            end
        },
        {
            'Exafunction/windsurf.vim',
            event = 'BufEnter'
        }
    },

    opts = {
        keymap = { preset = 'default' },
        appearance = {
            nerd_font_variant = 'propo',
        },
        completion = {
            -- By default, you may press `<c-space>` to show the documentation.
            -- Optionally, set `auto_show = true` to show the documentation after a delay.
            documentation = { auto_show = true, auto_show_delay_ms = 500 },
            menu = {
                border = 'rounded',
                draw = {
                    components = {
                        kind_icon = {
                            text = function(ctx)
                                -- we will channge thes icons
                                local icon = ctx.kind_icon
                                if my_kind_icons[ctx.kind] then
                                    icon = my_kind_icons[ctx.kind]
                                else
                                    icon = my_kind_icons[ctx.source_name]
                                end

                                return icon .. ctx.icon_gap
                            end,

                            -- Optionally, use the highlight groups from nvim-web-devicons
                            -- You can also add the same function for `kind.highlight` if you want to
                            -- keep the highlight groups in sync with the icons.
                            highlight = function(ctx)
                                local hl = ctx.kind_hl
                                if vim.tbl_contains({ "Path" }, ctx.source_name) then
                                    local dev_icon, dev_hl = require("nvim-web-devicons").get_icon(ctx.label)
                                    if dev_icon then
                                        hl = dev_hl
                                    end
                                end
                                return hl
                            end,
                        }
                    }
                }
            }
        },

        sources = {
            default = { 'lsp', 'path', 'snippets', 'lazydev' },
            providers = {
                lazydev = { module = 'lazydev.integrations.blink', score_offset = 100 },
            },
        },

        snippets = { preset = 'luasnip' },

        fuzzy = { implementation = 'lua' },

        signature = { enabled = true },
    }
}
