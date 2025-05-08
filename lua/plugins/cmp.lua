-- [saghen/blink.cmp]{https://github.com/saghen/blink.cmp}

return {
    'saghen/blink.cmp',
    version = '1.*',

    -- dependencies needed for this setup

    dependencies = {
        'L3MON4D3/LuaSnip',
        dependencies = { "rafamadriz/friendly-snippets" },
        opts = function()
            require("luasnip.loaders.from_vscode").lazy_load()
        end
    },

    -- completion config

    opts = {
        keymap = { preset = 'default' },
        appearance = {
            use_nvim_cmp_as_default = true,
            nerd_font_variant = 'mono',
        },

        -- and the rest of the config

        snippets = { preset = 'luasnip' },
        sources = {
            default = { 'lsp', 'path', 'snippets', 'buffer' },
            per_filetype = {
                codecompanion = { "codecompanion" },
            }
        }
    }
}

