local M = {}

M.AK_NEW_BUFFER = function()
	local unicorn = [[
        \.
         \\      .
          \\ _,.+;)_
          .\\;~%:88%%.
         (( a   `)9,8;%.
         /`   _) ' `9%%%?
        (' .-' j    '8%%'
         `"+   |    .88%)+._____..,,_   ,+%$%.
               :.   d%9`             `-%*'"'~%$.
            ___(   (%C                 `.   68%%9
          ."        \7                  ;  C8%%)`
          : ."-.__,'.____________..,`   L.  \86' ,
          : L    : :            `  .'\.   '.  %$9%)
          ;  -.  : |             \  \  "-._ `. `~"
           `. !  : |              )  >     ". ?
             `'  : |            .' .'       : |
                 ; !          .' .'         : |
                ,' ;         ' .'           ; (
               .  (         j  (            `  \
               """'          ""'             `""
███▄▄▄▄      ▄████████  ▄██████▄   ▄█    █▄   ▄█    ▄▄▄▄███▄▄▄▄
███▀▀▀██▄   ███    ███ ███    ███ ███    ███ ███  ▄██▀▀▀███▀▀▀██▄
███   ███   ███    █▀  ███    ███ ███    ███ ███▌ ███   ███   ███
███   ███  ▄███▄▄▄     ███    ███ ███    ███ ███▌ ███   ███   ███
███   ███ ▀▀███▀▀▀     ███    ███ ███    ███ ███▌ ███   ███   ███
███   ███   ███    █▄  ███    ███ ███    ███ ███  ███   ███   ███
███   ███   ███    ███ ███    ███ ███    ███ ███  ███   ███   ███
 ▀█   █▀    ██████████  ▀██████▀   ▀██████▀  █▀    ▀█   ███   █▀

	   ]]
	vim.api.nvim_put(vim.split(unicorn, "\n"), "c", false, true)
end



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

M.ak_copy_filname = function()
	local v = vim.fn.expand("%:t")
	-- put into first register for easy pasting
	vim.fn.setreg('"+', v)
end

M.ak_copy_fqn_filename = function()
	local v = vim.fn.expand("%")
	-- put into first register for easy pasting
	vim.fn.setreg('"+', v)
end

M.ak_split_buffer_with_scratch = function()
	-- split current buffer
	vim.cmd("split")
	-- open new scratch buffer
	vim.cmd("enew")
	M.AK_NEW_BUFFER()
end

M.ak_split_buffer_with_scratch_vertical = function()
	-- split current buffer
	vim.cmd("vsplit")
	-- open new scratch buffer
	vim.cmd("enew")
	M.AK_NEW_BUFFER()
end

return M
