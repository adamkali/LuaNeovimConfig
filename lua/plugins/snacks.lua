
local greeting = function()
    local hour = tonumber(vim.fn.strftime("%H"))
    if hour < 12 then
        return "Good Morning"
    elseif hour < 18 then
        return "Good Afternoon"
    else
        return "Good Evening"
    end
end

-- Map task state icons to match neorg config
local state_icon_map = {
    ["×"] = "󱥸",      -- undone
    ["󰥔"] = "󰐌",      -- pending
    [""] = "󰙦",      -- on_hold
    ["⚠"] = "󱠇",      -- urgent/important
    ["↺"] = "󱍸",      -- recurring
    [""] = "",      -- uncertain/ambiguous
    ["󰄬"] = "󰓏",      -- done
    [""] = "󱃓",      -- cancelled
}

-- Map state icons to highlight groups
local state_hl_map = {
    ["×"] = "@neorg.todo_items.undone",
    ["󰥔"] = "@neorg.todo_items.pending",
    [""] = "@neorg.todo_items.on_hold",
    ["⚠"] = "@neorg.todo_items.urgent",
    ["↺"] = "@neorg.todo_items.recurring",
    [""] = "@neorg.todo_items.uncertain",
    ["󰄬"] = "@neorg.todo_items.done",
    [""] = "@neorg.todo_items.cancelled",
}

-- Custom function to get Neorg tasks due in the next week
local get_neorg_tasks = function()
    -- Check if neorg is loaded
    local neorg_loaded, neorg = pcall(require, "neorg.core")
    if not neorg_loaded then
        return {}
    end

    local many_mans = neorg.modules.get_module("external.many-mans")
    if not many_mans then
        return {}
    end

    -- Get all undone, pending, hold, important tasks
    local ok, task_list = pcall(function()
        return many_mans["task-man"].filter_tasks({
            "undone",
            "pending",
            "hold",
            "important",
        })
    end)

    if not ok or not task_list then
        return {}
    end

    -- Calculate time boundaries (next 7 days)
    local current_time = os.time()
    local week_from_now = current_time + (7 * 24 * 60 * 60)

    -- Filter tasks due within the next week
    local upcoming_tasks = {}
    for _, task in ipairs(task_list) do
        if task.deadline and task.deadline.year and task.deadline.month and task.deadline.day then
            local task_time = os.time({
                year = tonumber(task.deadline.year),
                month = tonumber(task.deadline.month),
                day = tonumber(task.deadline.day),
                hour = tonumber(task.deadline.hour) or 0,
                min = tonumber(task.deadline.minute) or 0,
                sec = 0,
            })

            -- Include tasks due within the next week (including overdue)
            if task_time <= week_from_now then
                table.insert(upcoming_tasks, task)
            end
        end
    end

    -- Sort by deadline (earliest first)
    table.sort(upcoming_tasks, function(a, b)
        local time_a = os.time({
            year = tonumber(a.deadline.year),
            month = tonumber(a.deadline.month),
            day = tonumber(a.deadline.day),
            hour = tonumber(a.deadline.hour) or 0,
            min = tonumber(a.deadline.minute) or 0,
            sec = 0,
        })
        local time_b = os.time({
            year = tonumber(b.deadline.year),
            month = tonumber(b.deadline.month),
            day = tonumber(b.deadline.day),
            hour = tonumber(b.deadline.hour) or 0,
            min = tonumber(b.deadline.minute) or 0,
            sec = 0,
        })
        return time_a < time_b
    end)

    -- Format tasks for dashboard display
    local formatted_tasks = {}
    for _, task in ipairs(upcoming_tasks) do
        -- Extract task text (remove the heading markers and state)
        local task_text = task.task:match("%)%s*(.+)") or task.task

        -- Format deadline
        local deadline_str = string.format(
            "%s-%s-%s",
            task.deadline.year,
            task.deadline.month,
            task.deadline.day
        )

        -- Get file title if available
        local file_title = "Unknown"
        if task.filename then
            local metadata_ok, metadata = pcall(function()
                return many_mans["meta-man"].extract_file_metadata(task.filename)
            end)
            if metadata_ok and metadata and metadata.title then
                file_title = metadata.title
            else
                -- Fallback to filename
                file_title = vim.fn.fnamemodify(task.filename, ":t:r")
            end
        end

        -- Map the state icon to neorg icon
        local icon = state_icon_map[task.state] or task.state
        local hl = state_hl_map[task.state] or "Normal"

        table.insert(formatted_tasks, {
            file = task.filename,
            line = task.lnum,
            text = task_text:sub(1, 40), -- Truncate long tasks
            action = function()
                vim.cmd("edit +" .. task.lnum .. " " .. task.filename)
            end,
            -- Add custom fields for display
            deadline = deadline_str,
            source = file_title,
            state_icon = icon,
            state_hl = hl,
        })
    end

    return formatted_tasks
end

return {
    {
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
                    {
                        pane = 1,
                        icon = " ",
                        title = "This Week's Tasks",
                        section = "neorg_tasks",
                        indent = 2,
                        padding = 1,
                    },
                    { pane = 2, section= "header", },
                    { section = "keys", gap = 1, pane = 2, padding = 5 },
                    { pane = 2, icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
                },
                -- Custom sections configuration
                formats = {
                    neorg_tasks = function(item)
                        -- Format: [state_icon] [YYYY-MM-DD] Task text
                        return {
                            { item.state_icon or "•", hl = item.state_hl or "Normal" },
                            { " [", hl = "special" },
                            { item.deadline or "No date", hl = "DiagnosticWarn" },
                            { "] ", hl = "special" },
                            { item.text or "Untitled", hl = "Normal" },
                        }
                    end,
                },

            },
            notifier = { enabled = true },
            quickfile = { enabled = true },
            statuscolumn = { enabled = true },
            lazygit = { enabled = true },
            animate = { enabled = true },
        },
        config = function(_, opts)
            -- Set up Snacks first
            require("snacks").setup(opts)

            -- Register custom section for Neorg tasks immediately after setup
            local Dashboard = require("snacks.dashboard")
            Dashboard.sections.neorg_tasks = function()
                local tasks = get_neorg_tasks()
                local ret = {}

                if #tasks == 0 then
                    table.insert(ret, { text = "No tasks due this week", hl = "Comment" })
                else
                    for i, task in ipairs(tasks) do
                        if i > 5 then break end -- Limit to 5 tasks
                        -- Format the text with icon and date
                        local formatted_text = string.format("%s [%s] %s",
                            task.state_icon or "•",
                            task.deadline or "No date",
                            task.text)

                        table.insert(ret, {
                            text = formatted_text,
                            file = task.file,
                            line = task.line,
                            action = task.action,
                        })
                    end
                end

                return ret
            end
        end,
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
    },
    {
        "nvzone/typr",
        dependencies = "nvzone/volt",
        opts = {},
        cmd = { "Typr", "TyprStats" },
    }
}
