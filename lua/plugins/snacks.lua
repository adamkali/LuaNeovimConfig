return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
        bigfile = { enabled = true },
        dashboard = {
            enabled = true,
            preset = {
                header = [[
███▄▄▄▄      ▄████████  ▄██████▄     ▄█   ▄█▄    ▄████████  ▄█        ▄█ 
███▀▀▀██▄   ███    ███ ███    ███   ███ ▄███▀   ███    ███ ███       ███ 
███   ███   ███    █▀  ███    ███   ███▐██▀     ███    ███ ███       ███▌
███   ███  ▄███▄▄▄     ███    ███  ▄█████▀      ███    ███ ███       ███▌
███   ███ ▀▀███▀▀▀     ███    ███ ▀▀█████▄    ▀███████████ ███       ███▌
███   ███   ███    █▄  ███    ███   ███▐██▄     ███    ███ ███       ███ 
███   ███   ███    ███ ███    ███   ███ ▀███▄   ███    ███ ███▌    ▄ ███ 
 ▀█   █▀    ██████████  ▀██████▀    ███   ▀█▀   ███    █▀  █████▄▄██ █▀  
]],
                keys = {
                    { icon = " ", key = "n", desc = "Notes", action = '<cmd>:Neorg workspace org_mode<cr>' },
                    { icon = " ", key = "f", desc = "Find File", action = "<cmd>:Telescope find_files<cr>" },
                    { icon = " ", key = "g", desc = "Find Text", action = "<cmd>:Telescope live_grep<cr>" },
                    { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
                    { icon = " ", key = "c", desc = "Config", action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
                    { icon = " ", key = "s", desc = "Restore Session", section = "session" },
                    { icon = "󰒲 ", key = "L", desc = "Lazy", action = ":Lazy", enabled = package.loaded.lazy ~= nil },
                    { icon = " ", key = "q", desc = "Quit", action = ":qa" },
                }
            },
            sections = {
                {
                    section = "terminal",
                    cmd = "pokemon-colorscripts --no-title -n infernape; sleep .1",
                    pane = 1,
                    indent = 4,
                    height = 16
                },
                { section = "startup" },
                { pane = 1, icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
                { pane = 2, section= "header", },
                { section = "keys", gap = 1, pane = 2, padding = 5 },
                { pane = 2, icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
            },

        },
        notifier = { enabled = true },
        quickfile = { enabled = true },
        statuscolumn = { enabled = true },
        lazygit = { enabled = true },
        animate = { enabled = true },
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