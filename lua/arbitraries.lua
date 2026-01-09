local M = {}

M.ak_bar_datetime_end_of_day = function(days_offset)
	days_offset = days_offset or 0

	-- Calculate the target date by adding days_offset
	local current_time = os.time()
	local target_time = current_time + (days_offset * 24 * 60 * 60)
	local date = os.date("%Y-%m-%d", target_time)
	local time = "17:00:00"

	-- Concatenate
	local datetime = date .. "|" .. time
	-- write at cursor
	vim.api.nvim_put({ datetime }, "c", false, true)
end

M.ak_bar_datetime = function()
	-- Get current date and time
	local date = os.date("%Y-%m-%d")
	local time = os.date("%H:%M:%S")

	-- Concatenate
	local datetime = date .. "|" .. time
	-- write at cursor
	vim.api.nvim_put({ datetime }, "c", false, true)
end

M.ak_get_filename = function()
	local v = vim.fn.expand("%:t")
	vim.api.nvim_put({ v }, "c", false, true)
end

M.ak_get_fqn_filname = function()
	local v = vim.fn.expand("%")
	vim.api.nvim_put({ v }, "c", false, true)
end

M.ak_yank_filename = function()
	local v = vim.fn.expand("%:t")
	-- put into first register for easy pasting
	vim.fn.setreg('"', v)
end

M.ak_yank_fqn_filename = function()
	local v = vim.fn.expand("%")
	-- put into first register for easy pasting
	vim.fn.setreg('"', v)
end

return M
