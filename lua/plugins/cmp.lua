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

    opts = {
        keymap = { preset = 'default' },
        appearance = {
            nerd_font_variant = 'propo',
        },
        completion = {
            -- By default, you may press `<c-space>` to show the documentation.
            -- Optionally, set `auto_show = true` to show the documentation after a delay.
            documentation = { auto_show = true, auto_show_delay_ms = 500 },
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
