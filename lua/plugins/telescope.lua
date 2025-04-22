-- As always, We start with opening with a table 

return {

-- [dressing]{https://github.com/stevearc/dressing.nvim?tab=readme-ov-file#installation}

    {'stevearc/dressing.nvim'}, 

-- [telescope]{https://github.com/nvim-telescope/telescope.nvim}

    {
        "nvim-telescope/telescope.nvim",
     dependencies = { 'nvim-lua/plenary.nvim'  },
        opts = {
            defaults = {
                file_ignore_patterns = { "node_modules", "target", "env" },
            },
        },
    },

-- [nerdy.nvim]{}

    {
        '2kabhishek/nerdy.nvim',
        cmd = 'Nerdy',
    },
}