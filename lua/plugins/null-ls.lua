return {
    "nvimtools/none-ls.nvim",
    config = function ()
        local null_ls = require"null-ls"
        null_ls.setup({
            sources = {
                null_ls.builtins.formatting.prettierd,
                null_ls.builtins.diagnostics.eslint_d,
                null_ls.builtins.formatting.jq,
            }
        })
    end,
	keys = {
		{ "gc", function () vim.lsp.buf.format() end, desc = "Format" },
    },
}
