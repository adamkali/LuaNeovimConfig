local redpill_pill_string = "<%+%>"
local wk = require("which-key")

local function redpill_insert_pill_before()
    -- Get the current 
    local cursor = vim.api.nvim_win_get_cursor(0)
    
    -- Insert the pill string 
    vim.api.nvim_put({redpill_pill_string}, "c", true, true)
    cursor[2] = cursor[2] + string.len(redpill_pill_string) + 1
    vim.api.nvim_win_set_cursor(0, cursor)

    -- Escape to normal mode
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<esc>", true, true, true), "n", true)
end

local function redpill_insert_pill_after()
    local cursor = vim.api.nvim_win_get_cursor(0)

    vim.api.nvim_put({redpill_pill_string}, "c", true, true)
    -- reset the cursor to the original position
    vim.api.nvim_win_set_cursor(0, cursor)


    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<esc>", true, true, true), "n", true)
end


local function redpill_pop_pill_next()
    local cursor = vim.api.nvim_win_get_cursor(0)
    local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)

    for i = cursor[1], #lines do
        local line = lines[i]

        local match_start, match_end = string.find(line, redpill_pill_string)
        if match_start then
            print("Found pill at line " .. i .. " column " .. match_start)
            local cursor_pos = {i, match_start}
            local new_line = string.sub(line, 1, match_start - 1) .. string.sub(line, match_end + 1)
            vim.api.nvim_buf_set_lines(0, i - 1, i, true, {new_line})
            vim.api.nvim_win_set_cursor(0, cursor_pos)
            return
        end
    end
end


local function redpill_pop_pill_previous()
end

wk.register({
    {
        name = "Redpill",
        ["ri"] = { redpill_insert_pill_before, "Insert Pill Before" },
        ["ra"] = { redpill_insert_pill_after, "Insert Pill After" },
        ["rO"] = { redpill_pop_pill_previous, "Pop Pill Previous" },
        ["ro"] = { redpill_pop_pill_next, "Pop Pill Next" },
    }
},{ prefix = "<leader>", })
