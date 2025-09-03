
local wk = require('which-key').add
local custom = require('custom')
local quickfix_leader = "<space>c"
local debug_leader = "<space>d"
local telescope_leader = "<space>f"
local dotnet_leader = "<space>dn"
local neorg_leader_todo = "<space>nt"
local neorg_leader = "<space>n"

-- Add some Quickfix Functionality
local quickfix_enhanced = require('quickfix_enhanced')

wk {
    { quickfix_leader, expr = false, group = "Quickfix", nowait = false, remap = false, icon = { icon = "󰓅", hl = "Function" } },
    { quickfix_leader .. "a", quickfix_enhanced.qf_prev, desc = 'Quickfix Prev', expr = false, nowait = false, remap = false },
    { quickfix_leader .. "c", function() vim.cmd [[cclose]] end, desc = 'Quickfix Close', expr = false, nowait = false, remap = false },
    { quickfix_leader .. "o", quickfix_enhanced.toggle_quickfix, desc = 'Quickfix Toggle', expr = false, nowait = false, remap = false },
    { quickfix_leader .. "s", quickfix_enhanced.qf_next, desc = 'Quickfix Next', expr = false, nowait = false, remap = false },
    { quickfix_leader .. "i", quickfix_enhanced.quickfix_info, desc = 'Quickfix Info', expr = false, nowait = false, remap = false },
    { quickfix_leader .. "x", quickfix_enhanced.clear_quickfix, desc = 'Quickfix Clear', expr = false, nowait = false, remap = false },
    { quickfix_leader .. "f", quickfix_enhanced.format_quickfix, desc = 'Quickfix Format', expr = false, nowait = false, remap = false },
}

-- Add some debug Functionality

wk {
    { debug_leader, expr = false, group = "Debug", nowait = false, remap = false, icon = { icon = "", hl = "@constructor.tsx" } },
    { debug_leader .. "b", "<cmd>DapToggleBreakpoint<CR>", desc = 'Toggle Breakpoint' },
    { debug_leader .. "e", function() require 'dapui'.eval() end, desc = 'Evaluate Under Cursor' },
    { debug_leader .. "u", function() require('dapui').toggle() end, desc = 'Toggle Ui' },
    { debug_leader .. "g", function() require('dap').goto_() end, desc = 'Go Here' },
    { debug_leader .. "r", function() require('dap').restart() end, desc = 'Restart' },
    { "<F5>", function() require('dap').continue() end, desc = 'Continue' },
    { "<F10>", function() require('dap').step_over() end, desc = 'Step Over' },
    { "<F11>", function() require('dap').step_into() end, desc = 'Step Into' },
    { "<F12>", function() require('dap').step_out() end, desc = 'Step Out' },
}

-- Telescope functions

wk {
    { telescope_leader, expr = false, group = "[f]inder", nowait = false, remap = false, icon = { icon = " ", hl = "@constructor.tsx" } },
    { telescope_leader .. "f", "<cmd>Telescope find_files<cr>", desc = "[f]iles" },
    { telescope_leader .. "h", "<cmd>Telescope help_tags<cr>", desc = "[t]ags" },
    { telescope_leader .. "g", "<cmd>Telescope live_grep<cr>", desc = "[g]rep" },
    { telescope_leader .. "c", "<cmd>Telescope commands<cr>", desc = "[c]ommands" },
    { telescope_leader .. "b", "<cmd>Telescope buffers<cr>", desc = "[b]uffers" },
    { telescope_leader .. "m", "<cmd>Telescope marks<cr>", desc = "[m]arks" },
    { telescope_leader .. "y", "<cmd>Telescope registers<cr>", desc = "[r]egisters" },
    { telescope_leader .. "s", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", desc = "[l]sp [s]ymbols" },
    { telescope_leader .. "d", "<cmd>Telescope diagnostics<cr>", desc = "[l]sp [d]iagnostics" },
    { telescope_leader .. "r", "<cmd>Telescope lsp_refrences<cr>", desc = "[l]sp [r]efrences" },
    { telescope_leader .. "n", "<cmd>Telescope nerdy<cr>", desc = "[N]erdfonts " },
    { telescope_leader .. "k", "<cmd>Telescope keymaps<cr>", desc = "[k]eymaps" },
}

-- Dotnet Plugin

wk {
    { dotnet_leader, expr = false, group = "[d]otnet ", nowait = false, remap = false, icon = { icon = "", hl = "@constructor.tsx" } },
    { dotnet_leader .. 's', function() require('dotnvim').bootstrap() end, desc = 'Boot[s]trap Class' },
    { dotnet_leader .. 'b', function() require('dotnvim').build(false) end, desc = '[b]uild Last Project' },
	{ dotnet_leader .. 't', '<cmd>DotnvimTaskRun<cr>', desc = '[t]ask [r]un' },
}

-- Neorg Keybindings

local function add_to_posts()
    local post_location = "/home/adamkali/git/blog.kalilarosa.xyz/content/posts/"
    local post_name = vim.fn.expand("%:r")
    return post_location .. post_name .. ".md"
end

wk {
    { neorg_leader, expr = false, group = "[N]eorg", nowait = false, remap = false, icon = { icon = "", "@constructor.tsx" } },
    { neorg_leader .. 'c', '<cmd>:Neorg toc right<cr>', desc = '[n]eorg table of [c]ontents' },
    { neorg_leader .. 'm', '<Plug>(neorg.looking-glass.magnify-code-block)', desc = '[n]eorg code [m]agnify' },
    { neorg_leader .. '.', '<cmd>:Neorg tangle current-file<cr>', desc = '[n]eorg tangle [.]' },
    { neorg_leader .. 'i', '<cmd>:Neorg inject-metadata<cr>', desc = '[n]eorg [i]nject metadata' },
    { neorg_leader .. 'p', '<cmd>:Neorg export to-file ' .. add_to_posts() .. ' markdown<cr>', desc = '[n]eorg [p]ost to blog' },
    { neorg_leader .. 'e', require('norbsidian').get_selections, desc = "neorg configured export" },
    { neorg_leader .. 's', '<cmd>:Neorg dew_catngo full<cr>', desc = '[n]eorg [s]earch categories' },
}

wk {
    { neorg_leader_todo, expr = false, group = "[n]eorg [t]odo", nowait = false, remap = false, icon = { icon = "", "@constructor.tsx" } },
    { neorg_leader_todo .. 'a', '<Plug>(neorg.qol.todo-items.todo.task-ambiguous)', desc = '[n]eorg [t]odo ambiguous' },
    { neorg_leader_todo .. 'c', '<Plug>(neorg.qol.todo-items.todo.task-cancelled)', desc = '[n]eorg [t]odo cancelled' },
    { neorg_leader_todo .. 'd', '<Plug>(neorg.qol.todo-items.todo.task-done)', desc = '[n]eorg [t]odo done' },
    { neorg_leader_todo .. 'h', '<Plug>(neorg.qol.todo-items.todo.task-on-hold)', desc = '[n]eorg [t]odo on-hold' },
    { neorg_leader_todo .. 'i', '<Plug>(neorg.qol.todo-items.todo.task-important)', desc = '[n]eorg [t]odo important' },
    { neorg_leader_todo .. 'p', '<Plug>(neorg.qol.todo-items.todo.task-pending)', desc = '[n]eorg [t]odo pending' },
    { neorg_leader_todo .. 'r', '<Plug>(neorg.qol.todo-items.todo.task-recurring)', desc = '[n]eorg [t]odo recurring' },
    { neorg_leader_todo .. 'u', '<Plug>(neorg.qol.todo-items.todo.task-undone)', desc = '[n]eorg [t]odo undone' },
}

-- Gonlang Plugins


-- From TJ's Wonderful 25 Days Of Neovim series

vim.keymap.set("t", "<esc><esc>", "<c-\\><c-n>")
local state = {
    floating = {
        buf = -1,
        win = -1,
    }
}

-- The following code makes the Terminal window

local function create_floating_window(opts)
    opts = opts or {}
    local width = opts.width or math.floor(vim.o.columns * 0.8)
    local height = opts.height or math.floor(vim.o.lines * 0.8)
    -- Calculate the position to center the window
    local col = math.floor((vim.o.columns - width) / 2)
    local row = math.floor((vim.o.lines - height) / 2)

    -- Create a buffer
    local buf = nil
    if vim.api.nvim_buf_is_valid(opts.buf) then
        buf = opts.buf
    else
        buf = vim.api.nvim_create_buf(false, true) -- No file, scratch buffer
    end

    -- Define window configuration
    local win_config = {
        relative = "editor",
        width = width,
        height = height,
        col = col,
        row = row,
        style = "minimal", -- No borders or extra UI elements
        border = "rounded",
    }

    -- Create the floating window
    local win = vim.api.nvim_open_win(buf, true, win_config)

    return { buf = buf, win = win }
end

-- Create a function callback to be used to create a key bind

local toggle_terminal = function()
    if not vim.api.nvim_win_is_valid(state.floating.win) then
        state.floating = create_floating_window { buf = state.floating.buf }
        if vim.bo[state.floating.buf].buftype ~= "terminal" then
            vim.cmd.terminal()
        end
    else
        vim.api.nvim_win_hide(state.floating.win)
    end
end

-- And the final keybinds

vim.api.nvim_create_user_command("Floaterminal", toggle_terminal, {})
vim.keymap.set("t", "<esc><esc>", "<c-\\><c-n>")
vim.keymap.set("n", "<C-M-t>", toggle_terminal)
