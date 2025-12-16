
local wk = require('which-key').add
local custom = require('custom')
local quickfix_leader = "<space>c"
local debug_leader = "<space>d"
local telescope_leader = "<space>f"
local dotnet_leader = "<space>dn"

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
    { debug_leader .. "g", function() require('dap').goto() end, desc = 'Go Here' },
    { debug_leader .. "r", function() require('dap').restart() end, desc = 'Restart' },
    { debug_leader .."o", function() require('dap').step_over() end, desc = 'Step Over' },
    { debug_leader .."i", function() require('dap').step_into() end, desc = 'Step Into' },
    { debug_leader .."O", function() require('dap').step_out() end, desc = 'Step Out' },
    { "<F5>", function() require('dap').continue() end, desc = 'Continue' },
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


-- From TJ's Wonderful 25 Days Of Neovim series

vim.keymap.set("t", "<esc><esc>", "<c-\\><c-n>")
local state = {
    floating = {
        buf = -1,
        win = -1,
    },
    bottom = {
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

-- Create Terminal Buffer
local function create_terminal_buf()
	opts = opts or {}
	-- create a new buffer and open a terminal in it
	local buf = vim.api.nvim_create_buf(false, true)
	vim.api.nvim_set_option_value("buftype", "terminal", { scope = "local", win = buf })

	-- open the terminal in the new buffer
	vim.api.nvim_command("terminal")

	return buf
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

local open_buffer_terminal = function()
	local buf = create_terminal_buf()
	state.floating = create_floating_window { buf = buf }
end

-- Create a terminal in a regular buffer (like any other buffer)
local create_buffer_terminal = function()
    -- Create a new buffer (listed, not scratch)
    local buf = vim.api.nvim_create_buf(true, false)

    -- Switch to the new buffer in the current window
    vim.api.nvim_set_current_buf(buf)

    -- Start a terminal in the buffer using termopen
    -- This ensures the terminal is created in the current buffer
    local shell = vim.o.shell
    vim.fn.termopen(shell, {
        on_exit = function()
            -- Optional: close the buffer when terminal exits
            vim.schedule(function()
                if vim.api.nvim_buf_is_valid(buf) then
                    vim.api.nvim_buf_delete(buf, { force = true })
                end
            end)
        end
    })

    -- Set buffer options for terminal
    vim.bo[buf].buflisted = true
    vim.bo[buf].buftype = "terminal"

    -- Enter insert mode automatically
    vim.cmd.startinsert()

    return buf
end

-- Toggle bottom terminal (VSCode-like)
local toggle_bottom_terminal = function()
    -- Check if the window is valid and visible
    if vim.api.nvim_win_is_valid(state.bottom.win) then
        -- Hide the terminal window
        vim.api.nvim_win_hide(state.bottom.win)
        state.bottom.win = -1
    else
        -- Calculate height for bottom terminal (30% of screen)
        local height = math.floor(vim.o.lines * 0.3)

        -- Create or reuse buffer
        local buf = state.bottom.buf
        if not vim.api.nvim_buf_is_valid(buf) then
            buf = vim.api.nvim_create_buf(false, true)
            state.bottom.buf = buf
        end

        -- Create a split at the bottom
        vim.cmd('botright split')
        local win = vim.api.nvim_get_current_win()

        -- Set the buffer in the new window
        vim.api.nvim_win_set_buf(win, buf)

        -- Resize the window
        vim.api.nvim_win_set_height(win, height)

        -- If not already a terminal, create one
        if vim.bo[buf].buftype ~= "terminal" then
            vim.fn.termopen(vim.o.shell, {
                on_exit = function()
                    vim.schedule(function()
                        if vim.api.nvim_win_is_valid(win) then
                            vim.api.nvim_win_close(win, true)
                        end
                        state.bottom.buf = -1
                        state.bottom.win = -1
                    end)
                end
            })
        end

        -- Store the window
        state.bottom.win = win

        -- Enter insert mode
        vim.cmd.startinsert()
    end
end

-- And the final keybinds

vim.api.nvim_create_user_command("Floaterminal", toggle_terminal, {})
vim.api.nvim_create_user_command("Terminal", create_buffer_terminal, {})
vim.api.nvim_create_user_command("BottomTerminal", toggle_bottom_terminal, {})

-- Terminal keymaps
vim.keymap.set("t", "<esc><esc>", "<c-\\><c-n>")
vim.keymap.set("n", "<C-M-t>", toggle_terminal, { desc = "Toggle floating terminal" })
vim.keymap.set("n", "<leader>tt", create_buffer_terminal, { desc = "Open terminal in buffer" })

-- VSCode-like bottom terminal toggle (Ctrl+` or Ctrl+\)
vim.keymap.set("n", "<C-`>", toggle_bottom_terminal, { desc = "Toggle bottom terminal" })
vim.keymap.set("n", "<C-\\>", toggle_bottom_terminal, { desc = "Toggle bottom terminal" })
vim.keymap.set("t", "<C-`>", toggle_bottom_terminal, { desc = "Toggle bottom terminal" })
vim.keymap.set("t", "<C-\\>", toggle_bottom_terminal, { desc = "Toggle bottom terminal" })
vim.keymap.set("n", "<leader>tb", toggle_bottom_terminal, { desc = "Toggle bottom terminal" })
