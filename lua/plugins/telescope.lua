return {
    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            { 'nvim-lua/plenary.nvim' }
        },
        keys = {
            { "-hh", "<cmd>Telescope find_files<cr>",                    desc = "Find Files" },
            { "-hH", "<cmd>Telescope help_tags<cr>",                     desc = "Help Tags" },
            { "-hg", "<cmd>Telescope live_grep<cr>",                     desc = "Live Grep" },
            { "-hc", "<cmd>Telescope commands<cr>",                      desc = "List Commands" },
            { "-hb", "<cmd>Telescope buffers<cr>",                       desc = "List Buffers" },
            { "-hm", "<cmd>Telescope marks<cr>",                         desc = "List Marks" },
            { "-hy", "<cmd>Telescope registers<cr>",                     desc = "List Registers" },
            { "-hd", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", desc = "Lsp Symbols" },
            { "-hD", "<cmd>Telescope diagnostics<cr>",                   desc = "Lsp Diagnostics" },
            { "-hr", "<cmd>Telescope lsp_refrences<cr>",                 desc = "Lsp Refrences" },
            { "-hn", "<cmd>Telescope nerdy<cr>",                         desc = "Nerdfonts " },
            { "-H",  "<cmd>Telescope <cr>",                              desc = "Open Telescope" },

        },
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
