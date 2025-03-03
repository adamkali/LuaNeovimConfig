local wk = require('which-key').add
wk {
    { "<space>c", expr = false, group = "Quickfix", nowait = false, remap = false, icon = { icon = "󰓅", hl = "Function" } },
    { "<space>ca", function() vim.cmd [[cprev]] end, desc = 'Quickfix Prev', expr = false, nowait = false, remap = false },
    { "<space>cc", function() vim.cmd [[cclose]] end, desc = 'Quickfix Close', expr = false, nowait = false, remap = false },
    { "<space>co", function() vim.cmd [[copen]] end, desc = 'Quickfix Open List', expr = false, nowait = false, remap = false },
    { "<space>cs", function() vim.cmd [[cnext]] end, desc = 'Quickfix Next', expr = false, nowait = false, remap = false },
}

local telescope_leader = "<leader>h"
wk {
    { telescope_leader,        group = "Telescope",                                nowait = false,            remap = false },
    { telescope_leader .. "h", "<cmd>Telescope find_files<cr>",                    desc = "Find Files",       expr = false, nowait = false, remap = false },
    { telescope_leader .. "H", "<cmd>Telescope help_tags<cr>",                     desc = "Find Help Tags",   expr = false, nowait = false, remap = false },
    { telescope_leader .. "g", "<cmd>Telescope live_grep<cr>",                     desc = "Find Grep",        expr = false, nowait = false, remap = false },
    { telescope_leader .. "c", "<cmd>Telescope commands<cr>",                      desc = "Find Commands",    expr = false, nowait = false, remap = false },
    { telescope_leader .. "b", "<cmd>Telescope buffers<cr>",                       desc = "Find Buffers",     expr = false, nowait = false, remap = false },
    { telescope_leader .. "m", "<cmd>Telescope marks<cr>",                         desc = "Find Marks",       expr = false, nowait = false, remap = false },
    { telescope_leader .. "y", "<cmd>Telescope registers<cr>",                     desc = "Find Registers",   expr = false, nowait = false, remap = false },
    { telescope_leader .. "d", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", desc = "Find Symbols",     expr = false, nowait = false, remap = false },
    { telescope_leader .. "D", "<cmd>Telescope diagnostics<cr>",                   desc = "Find Diagnostics", expr = false, nowait = false, remap = false },
    { telescope_leader .. "r", "<cmd>Telescope lsp_refrences<cr>",                 desc = "Find Refrences",   expr = false, nowait = false, remap = false },
    { telescope_leader .. "n", "<cmd>Telescope nerdy<cr>",                         desc = "Find Icons",       expr = false, nowait = false, remap = false },
    { telescope_leader .. "t", "<cmd>Telescope <cr>",                              desc = "Telescope",        expr = false, nowait = false, remap = false },
}
local debug_leader = "<space>d"
local debug_move = "s"
local debug_ui = "u"

wk {
    { debug_leader, expr = false, group = "Debug", nowait = false, remap = false, icon = { icon = "", hl = "@constructor.tsx" } },
    { debug_leader .. debug_ui .."b", "<cmd>DapToggleBreakpoint<CR>", desc = 'Toggle Breakpoint' },
    { debug_leader .. debug_ui .."e", function() require 'dapui'.eval() end, desc = 'Evaluate Under Cursor' },
    { debug_leader .. debug_ui .."u", function() require('dapui').toggle() end, desc = 'Toggle Ui' },
    { debug_leader .. debug_move, expr = false, group = "Debug Movements", nowait = false, remap = false, icon = { icon = "", hl = "@function.method" } },
    { debug_leader .. debug_move .. "g", function() require('dap').goto_() end, desc = 'Go Here' },
    { debug_leader .. debug_move .. "c", function() require('dap').continue() end, desc = 'Continue' },
    { debug_leader .. debug_move .. "r", function() require('dap').restart() end, desc = 'Restart' },
    { debug_leader .. debug_move .. "s", function() require('dap').step_over() end, desc = 'Step Over' },
    { debug_leader .. debug_move .. "t", function() require('dap').step_into() end, desc = 'Step Into' },
    { debug_leader .. debug_move .. "n", function() require('dap').step_out() end, desc = 'Step Out' },
}

local dotnet_leader= "<leader>d"
wk {
    { dotnet_leader, expr = false, group = "Debug", nowait = false, remap = false, icon = { icon = "", hl = "Function" } },
    { '<leader>ds', function() require('dotnvim').bootstrap() end,  desc = 'Bootstrap Class' },
    { '<leader>db', function() require('dotnvim').build(false) end, desc = 'Build Last Project' },
    { '<leader>dw', function() require('dotnvim').watch(true) end,  desc = 'Watch Last Project' },
}

vim.keymap.set("t", "<esc><esc>", "<c-\\><c-n>")

local state = {
    floating = {
        buf = -1,
        win = -1,
    }
}

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

-- Example usage:
-- Create a floating window with default dimensions
vim.api.nvim_create_user_command("Floaterminal", toggle_terminal, {})
vim.keymap.set("t", "<esc><esc>", "<c-\\><c-n>")
vim.keymap.set("n", "<M-t>", toggle_terminal)
