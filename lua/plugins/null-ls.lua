return {
    "nvimtools/none-ls.nvim",
    dependencies = {
        { "nvim-lua/plenary.nvim" },
        { "nvimtools/none-ls-extras.nvim" },
        { "gbprod/none-ls-luacheck.nvim" }

    },
    config = function()
        local null_ls = require "null-ls"
        null_ls.setup({
            sources = {
                null_ls.builtins.formatting.stylua,
                null_ls.builtins.formatting.biome,
                null_ls.builtins.formatting.xmllint,
                null_ls.builtins.formatting.black,
                null_ls.builtins.formatting.csharpier,
                null_ls.builtins.formatting.gofmt,
                require("none-ls.formatting.jq"),

            }
        })
    end,
    keys = {
        { "<space>lf", function() vim.lsp.buf.format() end, desc = "[f]ormat" },
    },
}
