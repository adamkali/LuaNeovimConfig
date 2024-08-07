return {
    "nvimtools/none-ls.nvim",
	dependencies = {
		{ "nvim-lua/plenary.nvim" }
	},
    config = function ()
        local null_ls = require"null-ls"
        null_ls.setup({
            sources = {
                null_ls.builtins.formatting.prettierd,
                null_ls.builtins.diagnostics.eslint_d,
                null_ls.builtins.formatting.jq,
                null_ls.builtins.formatting.xmllint,
                null_ls.builtins.diagnostics.luacheckrc
            }
        })
    end,
	keys = {
		{ "gc", function () vim.lsp.buf.format() end, desc = "Format" },
    },
}
