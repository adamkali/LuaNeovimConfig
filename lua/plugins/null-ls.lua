return {
    "nvimtools/none-ls.nvim",
	dependencies = {
		{ "nvim-lua/plenary.nvim" },
        { "gbprod/none-ls-luacheck.nvim" }
	},
    config = function ()
        local null_ls = require"null-ls"
        null_ls.setup({
            sources = {
                null_ls.builtins.formatting.biome,
                null_ls.builtins.formatting.jq,
                null_ls.builtins.formatting.xmllint,
            }
        })
    end,
	keys = {
		{ "<M-m>f", function () vim.lsp.buf.format() end, desc = "[f]ormat" },
    },
}
