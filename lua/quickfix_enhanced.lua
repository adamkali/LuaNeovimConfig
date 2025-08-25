-- Enhanced Quickfix Configuration
-- This file provides visual improvements and additional functionality for the quickfix menu

-- Set up better quickfix window appearance
vim.api.nvim_create_autocmd("FileType", {
    pattern = "qf",
    callback = function()
        -- Better quickfix window options
        vim.wo.wrap = false
        vim.wo.number = true
        vim.wo.relativenumber = false
        vim.wo.cursorline = true
        vim.wo.signcolumn = "no"
        
        -- Set custom highlights for quickfix
        vim.api.nvim_set_hl(0, "QfFileName", { fg = "#7dcfff", bold = true })
        vim.api.nvim_set_hl(0, "QfLineNr", { fg = "#ff9e64" })
        vim.api.nvim_set_hl(0, "QfText", { fg = "#c0caf5" })
        vim.api.nvim_set_hl(0, "QfError", { fg = "#f7768e", bold = true })
        vim.api.nvim_set_hl(0, "QfWarning", { fg = "#e0af68", bold = true })
        vim.api.nvim_set_hl(0, "QfInfo", { fg = "#7aa2f7" })
        vim.api.nvim_set_hl(0, "QfHint", { fg = "#1abc9c" })
    end,
})

-- Auto-resize quickfix window based on content
vim.api.nvim_create_autocmd("FileType", {
    pattern = "qf",
    callback = function()
        local qf_winid = vim.fn.win_getid()
        local qf_height = math.min(vim.fn.line('$'), 15) -- Max 15 lines
        vim.api.nvim_win_set_height(qf_winid, qf_height)
    end,
})

-- Enhanced quickfix functions
local M = {}

-- Toggle quickfix with better sizing
M.toggle_quickfix = function()
    local qf_winid = vim.fn.getqflist({ winid = 0 }).winid
    if qf_winid ~= 0 then
        vim.cmd('cclose')
    else
        vim.cmd('copen')
        -- Auto-size the window
        local qf_height = math.min(vim.fn.line('$'), 15)
        vim.api.nvim_win_set_height(0, qf_height)
    end
end

-- Clear quickfix with confirmation
M.clear_quickfix = function()
    local choice = vim.fn.confirm("Clear quickfix list?", "&Yes\n&No", 2)
    if choice == 1 then
        vim.fn.setqflist({})
        print("Quickfix cleared!")
    end
end

-- Show quickfix info
M.quickfix_info = function()
    local qf_list = vim.fn.getqflist()
    local current = vim.fn.getqflist({ idx = 0 }).idx
    local total = #qf_list
    
    if total == 0 then
        print("Quickfix is empty")
        return
    end
    
    print(string.format("Quickfix: %d/%d", current, total))
end

-- Enhanced quickfix navigation with wrap-around
M.qf_next = function()
    local qf_list = vim.fn.getqflist()
    if #qf_list == 0 then
        print("Quickfix is empty")
        return
    end
    
    local current = vim.fn.getqflist({ idx = 0 }).idx
    if current >= #qf_list then
        vim.fn.setqflist({}, 'a', { idx = 1 }) -- Wrap to first
        print("Wrapped to first quickfix item")
    else
        vim.cmd('cnext')
    end
end

M.qf_prev = function()
    local qf_list = vim.fn.getqflist()
    if #qf_list == 0 then
        print("Quickfix is empty")
        return
    end
    
    local current = vim.fn.getqflist({ idx = 0 }).idx
    if current <= 1 then
        vim.fn.setqflist({}, 'a', { idx = #qf_list }) -- Wrap to last
        print("Wrapped to last quickfix item")
    else
        vim.cmd('cprev')
    end
end

-- Add visual indicators and better formatting
M.format_quickfix = function()
    local qf_list = vim.fn.getqflist()
    local formatted = {}
    
    for i, item in ipairs(qf_list) do
        local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(item.bufnr), ':~:.')
        local line = item.lnum
        local col = item.col
        local text = item.text or ""
        
        -- Add icons based on type
        local icon = "●"
        if item.type == "E" then
            icon = " "
        elseif item.type == "W" then
            icon = " "
        elseif item.type == "I" then
            icon = " "
        elseif item.type == "H" then
            icon = "󰌶 "
        end
        
        local formatted_text = string.format("%s %s:%d:%d: %s", icon, filename, line, col, text)
        table.insert(formatted, {
            filename = filename,
            lnum = line,
            col = col,
            text = formatted_text,
            type = item.type,
            bufnr = item.bufnr,
        })
    end
    
    vim.fn.setqflist(formatted, 'r')
end

-- Create commands for easy access
vim.api.nvim_create_user_command('QfToggle', M.toggle_quickfix, {})
vim.api.nvim_create_user_command('QfClear', M.clear_quickfix, {})
vim.api.nvim_create_user_command('QfInfo', M.quickfix_info, {})
vim.api.nvim_create_user_command('QfFormat', M.format_quickfix, {})

-- Better quickfix local keymaps
vim.api.nvim_create_autocmd("FileType", {
    pattern = "qf",
    callback = function(event)
        local opts = { buffer = event.buf, silent = true }
        
        -- Enhanced navigation
        vim.keymap.set('n', 'j', function()
            vim.cmd('normal! j')
            M.quickfix_info()
        end, opts)
        
        vim.keymap.set('n', 'k', function()
            vim.cmd('normal! k')
            M.quickfix_info()
        end, opts)
        
        -- Quick actions
        vim.keymap.set('n', '<CR>', '<CR><C-w>p', opts) -- Enter and return to previous window
        vim.keymap.set('n', 'o', '<CR><C-w>p', opts) -- Same as enter
        vim.keymap.set('n', 't', '<C-w><CR><C-w>T', opts) -- Open in new tab
        vim.keymap.set('n', 'T', '<C-w><CR><C-w>TgT<C-w>p', opts) -- Open in new tab (silent)
        vim.keymap.set('n', 'v', '<C-w><CR><C-w>L<C-w>p<C-w>J<C-w>p', opts) -- Open in vertical split
        vim.keymap.set('n', 's', '<C-w><CR><C-w>K<C-w>p<C-w>J<C-w>p', opts) -- Open in horizontal split
        vim.keymap.set('n', 'q', '<C-w>c', opts) -- Close quickfix
        vim.keymap.set('n', 'd', function()
            -- Remove current item from quickfix
            local line = vim.fn.line('.')
            local qf_list = vim.fn.getqflist()
            table.remove(qf_list, line)
            vim.fn.setqflist(qf_list, 'r')
            print(string.format("Removed item %d", line))
        end, opts)
    end,
})

-- Export functions for use in keymaps
return M
