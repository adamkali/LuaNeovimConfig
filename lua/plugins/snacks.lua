return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    keys = {
        { "<leader>n", function() Snacks.notifier.show_history() end, desc = "Notification History" },
        { "<M-c>",     function() Snacks.terminal.open() end,         desc = "Open Terminal" },
        { "<M-C>",     function() Snacks.terminal.toggle() end,         desc = "Toggle Terminal" },
        { "<leader>g", function() Snacks.lazygit.open() end, desc = "Open Lazygit"},
    },
    opts = {
        bigfile = { enabled = true },
        dashboard = {
            enabled = true,
            sections = {
                {
                    pane = 1,
                    section = "terminal",
                    cmd = "ascii-image-converter /mnt/c/Users/adam/.config/cat.png -C --width 60",
                    height = 40,
                },
                { section = "header", pane = 2 },
                { section = "keys", gap = 1, pane = 2, padding = 5 },
                { pane = 2, icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
                { pane = 2, icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
                { section = "startup" },
            }
        },
        notifier = { enabled = true },
        quickfile = { enabled = true },
        statuscolumn = { enabled = true },
        lazygit = { enabled = true },
    },
    init = function()
        vim.api.nvim_create_autocmd("User", {
            pattern = "VeryLazy",
            callback = function()
                -- Setup some globals for debugging (lazy-loaded)
                _G.dd = function(...)
                    Snacks.debug.inspect(...)
                end
                _G.bt = function()
                    Snacks.debug.backtrace()
                end
                vim.print = _G.dd -- Override print to use snacks for `:=` command

                -- Create some toggle mappings
                Snacks.toggle.inlay_hints():map("<leader>uh")
            end,
        })
    end,
}
