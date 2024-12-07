return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    keys = {
        { "<leader>n",  function() Snacks.notifier.show_history() end, desc = "Notification History" },
    },
    opts = {
        bigfile = { enabled = true },
        dashboard = {
            enabled = true,
            sections = {
                {
                    pane = 1,
                    section = "terminal",
                    cmd = "ascii-image-converter /mnt/c/Users/Us/.config/cat.png -C --width 60",
                    height = 40,
                },
                { section = "keys", gap = 1, padding = 10, pane = 2 },
                { pane = 2, icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
                { pane = 2, icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
                { section = "startup" },
            }
        },
        notifier = { enabled = true },
        quickfile = { enabled = true },
        statuscolumn = { enabled = true },
        words = { enabled = true },
    },
}
