return {
    {
        "nvim-telescope/telescope.nvim",
        dependencies = { { 'nvim-lua/plenary.nvim' } },
        opts = {
            defaults = {
                file_ignore_patterns = { "node_modules", "target", "env" },
            },
        },
    },
    {
        '2kabhishek/nerdy.nvim',
        dependencies = {
            'stevearc/dressing.nvim',
            'nvim-telescope/telescope.nvim',
        },
        cmd = 'Nerdy',
    },
}
