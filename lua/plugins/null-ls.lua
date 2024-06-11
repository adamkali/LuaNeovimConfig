return {
    "nvimtools/none-ls.nvim",
	dependencies = {
		{ 'none-ls-extras.nvim', "nvim-lua/plenary.nvim" }
	},
    config = function ()
        local null_ls = require"null-ls"
        null_ls.setup({
            sources = {
                null_ls.builtins.formatting.prettierd,
                null_ls.builtins.diagnostics.eslint_d,
                null_ls.builtins.formatting.jq,
                null_ls.builtins.formatting.xmllint
            }
        })
    end,
	keys = {
		{ "gc", function () vim.lsp.buf.format() end, desc = "Format" },
    },
}
