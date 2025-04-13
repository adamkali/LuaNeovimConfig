-- [saghen/blink.cmp]{https://github.com/saghen/blink.cmp}

return {
    {
        'saghen/blink.cmp',
        version = '1.*',

        -- dependencies needed for this setup

        dependencies = {
            'L3MON4D3/LuaSnip',
            dependencies = { "rafamadriz/friendly-snippets", "onsails/lspkind.nvim"  },
            opts = function()
                require("luasnip.loaders.from_vscode").lazy_load()
            end
        },

        -- completion config

        opts = {
            completion = {
                menu = {
                    draw = {
                        components = {
                            kind_icon = {
                                text = function(ctx)
                                    local lspkind = require("lspkind")
                                    local icon = ctx.kind_icon
                                    if vim.tbl_contains({ "Path" }, ctx.source_name) then
                                        local dev_icon, _ = require("nvim-web-devicons").get_icon(ctx.label)
                                        if dev_icon then
                                            icon = dev_icon
                                        end
                                    else
                                        icon = require("lspkind").symbolic(ctx.kind, {
                                            mode = "symbol",
                                        })
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

            -- and the rest of the config

            snippets = { preset = 'luasnip' },
            sources = {
                default = { 'lsp', 'path', 'snippets', 'buffer' },
                per_filetype = {
                    codecompanion = { "codecompanion" },
                }
            },
        }
    }
}
