return {
    {
        "adamkali/vaporlush",
        dependencies = { "rktjmp/lush.nvim" },
        lazy = false,
        name = "vaporlush",
        priority = 1000,
        config = function()
            vim.cmd([[colorscheme vaporlush]])
        end
    },
    {
        "catppuccin/nvim", name = "catppuccin", priority = 1000
    }
}
