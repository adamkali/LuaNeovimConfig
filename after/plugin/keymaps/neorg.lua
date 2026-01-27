-- ███╗   ██╗███████╗ ██████╗ ██████╗  ██████╗    ███╗   ██╗██╗   ██╗██╗███╗   ███╗
-- ████╗  ██║██╔════╝██╔═══██╗██╔══██╗██╔════╝    ████╗  ██║██║   ██║██║████╗ ████║
-- ██╔██╗ ██║█████╗  ██║   ██║██████╔╝██║  ███╗   ██╔██╗ ██║██║   ██║██║██╔████╔██║
-- ██║╚██╗██║██╔══╝  ██║   ██║██╔══██╗██║   ██║   ██║╚██╗██║╚██╗ ██╔╝██║██║╚██╔╝██║
-- ██║ ╚████║███████╗╚██████╔╝██║  ██║╚██████╔╝██╗██║ ╚████║ ╚████╔╝ ██║██║ ╚═╝ ██║
-- ╚═╝  ╚═══╝╚══════╝ ╚═════╝ ╚═╝  ╚═╝ ╚═════╝ ╚═╝╚═╝  ╚═══╝  ╚═══╝  ╚═╝╚═╝     ╚═╝

local wk = require('which-key').add

-- leaders
local neorg_leader = "<space>n"
local neorg_roam_leader = neorg_leader .. "r"
local neorg_refile_leader = neorg_leader .. "f"
local neorg_roam_capture_leader = neorg_roam_leader .. "c"
local neorg_leader_todo = neorg_leader .. "t"
local neorg_journal_leader = neorg_leader .. "l"
local neorg_agenda_leader = neorg_leader .. "a"
local neorg_goto_leader = neorg_leader .. "g"
local neorg_telescope_leader = neorg_leader .. "F"
--

local function add_to_posts()
	local post_location = "/home/adamkali/git/blog.kalilarosa.xyz/content/posts/"
	local post_name = vim.fn.expand("%:r")
	return post_location .. post_name .. ".md"
end
local todos = {
	cancelled = "󱃓",
	done = "󰓏",
	pending = "󰐌",
	on_hold = "󰙦",
	recurring = "󱍸",
	uncertain = "",
	undone = "󱥸",
	urgent = "󱠇"
}

local function vim_repeat(func)
	local count = vim.v.count > 0 and vim.v.count or 0
	for i = 1, count do
		func()
	end
end

local function AK_NeorgRefileDown()
	cmd = "<cmd>:Neorg move down<cr>"
	vim_repeat(vim.cmd(cmd))
end

local function AK_NeorgRefileUp()
	cmd = "<cmd>:Neorg move up<cr>"
	vim_repeat(vim.cmd(cmd))
end

local todo_uncertain_gui = { icon = todos.ambiguous, hl = "@neorg.todo_items.uncertain" }
local todo_cancelled_gui = { icon = todos.cancelled, hl = "@neorg.todo_items.cancelled" }
local todo_done_gui = { icon = todos.done, hl = "@neorg.todo_items.done" }
local todo_on_hold_gui = { icon = todos.on_hold, hl = "@neorg.todo_items.on_hold" }
local todo_important_gui = { icon = todos.urgent, hl = "@neorg.todo_items.urgent" }
local todo_pending_gui = { icon = todos.pending, hl = "@neorg.todo_items.pending" }
local todo_recurring_gui = { icon = todos.recurring, hl = "@neorg.todo_items.recurring" }
local todo_undone_gui = { icon = todos.undone, hl = "@neorg.todo_items.undone" }

wk {
	{ neorg_leader, expr = false, group = "[n]eorg", nowait = false, remap = false, icon = { icon = "", "@comment.hint" } },
	{ neorg_telescope_leader, expr = false, group = "[F]inder", nowait = false, remap = false, icon = { icon = " ", "@comment.hint" } },
	{ neorg_leader_todo, expr = false, group = "[t]odo", nowait = false, remap = false, icon = { icon = "", "@comment.hint" } },
	{ neorg_refile_leader, expr = false, group = "re[f]ile", nowait = false, remap = false, icon = { icon = "󰧻", "@comment.todo" } },
	{ neorg_roam_leader, expr = false, group = "[r]oam", nowait = false, remap = false, icon = { icon = "", "@lsp.type.enum" } },
	{ neorg_journal_leader, expr = false, group = "journa[l]", nowait = false, remap = false, icon = { icon = "󰨇", "@lsp.type.enum" } },
	{ neorg_roam_capture_leader, expr = false, group = "[c]apture", nowait = false, remap = false, icon = { icon = "󰯊", "@comment.todo" } },
	{ neorg_agenda_leader, expr = false, group = "[a]genda", nowait = false, remap = false, icon = { icon = "󰕪", "@lsp.type.enum" } },
	{ neorg_goto_leader, expr = false, group = "[g]oto", nowait = false, remap = false, icon = { icon = "󱞬", "@lsp.type.enum" } },
}

wk {
	{ neorg_leader .. 'c',              '<cmd>:Neorg toc right<cr>',                                        desc = 'Open Table of contents on the right' },
	{ neorg_leader .. 'm',              '<Plug>(neorg.looking-glass.magnify-code-block)',                   desc = 'Code Magnifier' },
	{ neorg_leader .. '.',              '<cmd>:Neorg tangle current-file<cr>',                              desc = 'Tangle the current file' },
	{ neorg_leader .. 'i',              '<cmd>:Neorg inject-metadata<cr>',                                  desc = 'Inject Metadata' },
	{ neorg_leader .. 'p',              '<cmd>:Neorg export to-file ' .. add_to_posts() .. ' markdown<cr>', desc = 'Post Neorg to blog' },
	{ neorg_leader .. 'e',              require('norbsidian').get_selections,                               desc = "Export to Obsidian" },
	{ neorg_leader .. 's',              '<cmd>:Neorg dew_catngo full<cr>',                                  desc = 'Search Categories Avaliable' },
	{ neorg_leader .. '<C-f>',          AK_NeorgRefileDown,                                                 desc = 'Move Node Up' },
	{ neorg_leader .. '<C-b>',          AK_NeorgRefileUp,                                           desc = 'Move Node Up' },
	{ neorg_goto_leader .. 't',         '<cmd>:e ~/org/roam/todo.norg<cr>',                                 desc = 'Go to $/roam/todo.norg' },
	{ neorg_goto_leader .. 'd',         '<cmd>:e ~/org/roam/done.norg<cr>',                                 desc = 'Go to $/roam/done.norg' },
	{ neorg_goto_leader .. 'p',         '<cmd>:e ~/org/roam/progress.norg<cr>',                             desc = 'Go to $/roam/progress.norg' },
	{ neorg_refile_leader .. 'dt',      '<cmd>Neorg refile defined todo<cr>',                               desc = 'Refile to Progress File' },
	{ neorg_refile_leader .. 'dp',      '<cmd>Neorg refile defined progress<cr>',                           desc = 'Refile to Progress File' },
	{ neorg_refile_leader .. 'dd',      '<cmd>Neorg refile defined done<cr>',                               desc = 'Refile to Done File' },
	{ neorg_refile_leader .. 't',       '<cmd>Neorg refile to<cr>',                                         desc = 'Refile to any file' },
	{ neorg_roam_leader .. 's',         '<cmd>Neorg roam select_workspace<cr>',                             desc = 'Select Workspace' },
	{ neorg_roam_leader .. 'n',         '<cmd>Neorg roam node<cr>',                                         desc = 'Open Node' },
	{ neorg_roam_leader .. 'b',         '<cmd>Neorg roam backlinks<cr>',                                    desc = 'Open Backlinks' },
	{ neorg_journal_leader .. 'y',      '<cmd>Neorg journal yesterday<cr>',                                 desc = 'Open Yesterday' },
	{ neorg_journal_leader .. 'o',      '<cmd>Neorg journal today<cr>',                                     desc = 'Open Today' },
	{ neorg_journal_leader .. 't',      '<cmd>Neorg journal tomorrow<cr>',                                  desc = 'Open Tomorrow' },
	{ neorg_roam_capture_leader .. 't', '<cmd>Neorg roam capture todo<cr>',                                 desc = 'Create new Todo' },
	{ neorg_roam_capture_leader .. 'n', '<cmd>Neorg roam capture note<cr>',                                 desc = 'Create new Note' },
	{ neorg_roam_capture_leader .. 'p', '<cmd>Neorg roam capture progress<cr>',                             desc = 'Create new Progress' },
	{ neorg_roam_capture_leader .. 's', '<cmd>Neorg roam capture selection<cr>',                            desc = 'Create new Selection',               mode = 'v' },
	{ neorg_telescope_leader .. 'b',    '<Plug>(neorg.telescope.backlinks.file_backlinks)',                 desc = 'Search File Backlinks' },
	{ neorg_telescope_leader .. 'B',    '<Plug>(neorg.telescope.backlinks.heading_backlinks)',              desc = 'Search Heading Backlinks' },
	{ neorg_telescope_leader .. 'f',    '<Plug>(neorg.telescope.find_linkable)',                            desc = 'Search Linkable' },
	{ neorg_telescope_leader .. 'l',    '<Plug>(neorg.telescope.insert_file_link)',                         desc = 'Insert File Link' },
	{ neorg_telescope_leader .. 'n',    '<Plug>(neorg.telescope.insert_link)',                              desc = 'Insert Link' },
	{ neorg_telescope_leader .. 'h',    '<Plug>(neorg.telescope.search_headings)',                          desc = 'Search Headings' },
	{ neorg_roam_capture_leader .. 'c', '<cmd>:Neorg roam capture<cr>',                                     desc = 'Create new Capture' },
	{ neorg_leader_todo .. 'a',         '<Plug>(neorg.qol.todo-items.todo.task-ambiguous)',                 desc = 'Make Ambiguous',                     icon = todo_uncertain_gui },
	{ neorg_leader_todo .. 'c',         '<Plug>(neorg.qol.todo-items.todo.task-cancelled)',                 desc = 'Make Cancelled',                     icon = todo_cancelled_gui },
	{ neorg_leader_todo .. 'd',         '<Plug>(neorg.qol.todo-items.todo.task-done)',                      desc = 'Make Done',                          icon = todo_done_gui },
	{ neorg_leader_todo .. 'h',         '<Plug>(neorg.qol.todo-items.todo.task-on-hold)',                   desc = 'Make On Hold',                       icon = todo_on_hold_gui },
	{ neorg_leader_todo .. 'i',         '<Plug>(neorg.qol.todo-items.todo.task-important)',                 desc = 'Make Urgent',                        icon = todo_important_gui },
	{ neorg_leader_todo .. 'p',         '<Plug>(neorg.qol.todo-items.todo.task-pending)',                   desc = 'Make Pending',                       icon = todo_pending_gui },
	{ neorg_leader_todo .. 'r',         '<Plug>(neorg.qol.todo-items.todo.task-recurring)',                 desc = 'Make Recurring',                     icon = todo_recurring_gui },
	{ neorg_leader_todo .. 'u',         '<Plug>(neorg.qol.todo-items.todo.task-undone)',                    desc = 'Make Undone',                        icon = todo_undone_gui },
	{ neorg_agenda_leader .. 'c',       '<cmd>Neorg agenda page cancelled<cr>',                             desc = 'Cancelled Agenda',                   icon = todo_cancelled_gui },
	{ neorg_agenda_leader .. 'd',       '<cmd>Neorg agenda page done<cr>',                                  desc = 'Done Agenda',                        icon = todo_done_gui },
	{ neorg_agenda_leader .. 'h',       '<cmd>Neorg agenda page hold<cr>',                                  desc = 'On Hold Agenda',                     icon = todo_on_hold_gui },
	{ neorg_agenda_leader .. 'i',       '<cmd>Neorg agenda page important<cr>',                             desc = 'Important Agenda',                   icon = todo_important_gui },
	{ neorg_agenda_leader .. 'p',       '<cmd>Neorg agenda page pending<cr>',                               desc = 'Pending Agenda',                     icon = todo_pending_gui },
	{ neorg_agenda_leader .. 'r',       '<cmd>Neorg agenda page recurring<cr>',                             desc = 'Recurring Agenda',                   icon = todo_recurring_gui },
	{ neorg_agenda_leader .. 'u',       '<cmd>Neorg agenda page undone<cr>',                                desc = 'Undone Agenda',                      icon = todo_undone_gui },
	{ neorg_agenda_leader .. 'a',       '<cmd>Neorg agenda day<cr>',                                        desc = 'Agenda Today', },
	{ neorg_agenda_leader .. 'U',       '<cmd>Neorg update_property_metadata<cr>',                          desc = 'Update Todo Metadata', }
}

-- ============================================================================
-- Custom Neorg Heading Navigation Functions
-- ============================================================================

--- Helper function to get the heading level from a node type
--- @param node_type string The TreeSitter node type (e.g., "heading1", "heading2")
--- @return number|nil The heading level (1-6) or nil if not a heading
local function get_heading_level(node_type)
	local level = node_type:match("^heading(%d)$")
	return level and tonumber(level) or nil
end

--- Helper function to get the current heading node under cursor
--- @return TSNode|nil, number|nil The heading node and its level
local function get_current_heading()
	local ts_utils = require('neorg').modules.get_module('core.integrations.treesitter')
	if not ts_utils then
		vim.notify("Neorg treesitter module not loaded", vim.log.levels.ERROR)
		return nil, nil
	end

	local node = vim.treesitter.get_node()
	if not node then
		return nil, nil
	end

	-- Traverse up to find a heading node
	local current = node
	while current do
		local node_type = current:type()
		local level = get_heading_level(node_type)
		if level then
			return current, level
		end
		current = current:parent()
	end

	return nil, nil
end

--- Helper function to jump to a TreeSitter node
--- @param node TSNode The node to jump to
local function goto_node(node)
	if not node then
		return
	end
	-- Set jump point for jumping back with Ctrl-O
	vim.cmd("normal! m'")

	local row, col = node:range()
	vim.api.nvim_win_set_cursor(0, { row + 1, col })
end

--- Jump to next heading at the same level (peer)
function AKNeorgHeadingPeerJumpForward()
	local current_heading, current_level = get_current_heading()
	if not current_heading or not current_level then
		vim.notify("Not inside a heading", vim.log.levels.WARN)
		return
	end

	-- Find next sibling heading at the same level
	local next_node = current_heading:next_named_sibling()
	while next_node do
		local node_type = next_node:type()
		local level = get_heading_level(node_type)

		if level then
			if level < current_level then
				-- Reached a higher-level heading (parent peer), stop searching
				vim.notify("No more peer headings forward", vim.log.levels.INFO)
				return
			elseif level == current_level then
				-- Found a peer heading at same level
				goto_node(next_node)
				return
			end
			-- level > current_level means it's a child, keep searching
		end

		next_node = next_node:next_named_sibling()
	end

	vim.notify("No more peer headings forward", vim.log.levels.INFO)
end

--- Jump to previous heading at the same level (peer)
function AKNeorgHeadingPeerJumpBackward()
	local current_heading, current_level = get_current_heading()
	if not current_heading or not current_level then
		vim.notify("Not inside a heading", vim.log.levels.WARN)
		return
	end

	-- Find previous sibling heading at the same level
	local prev_node = current_heading:prev_named_sibling()
	while prev_node do
		local node_type = prev_node:type()
		local level = get_heading_level(node_type)

		if level then
			if level < current_level then
				-- Reached a higher-level heading (parent peer), stop searching
				vim.notify("No more peer headings backward", vim.log.levels.INFO)
				return
			elseif level == current_level then
				-- Found a peer heading at same level
				goto_node(prev_node)
				return
			end
			-- level > current_level shouldn't happen when going backward, but skip it
		end

		prev_node = prev_node:prev_named_sibling()
	end

	vim.notify("No more peer headings backward", vim.log.levels.INFO)
end

--- Get all heading nodes in the document
--- @return TSNode[] List of heading nodes in document order
local function get_all_headings()
	local bufnr = vim.api.nvim_get_current_buf()
	local parser = vim.treesitter.get_parser(bufnr, 'norg')
	local tree = parser:parse()[1]
	local root = tree:root()

	local headings = {}

	-- Query for all headings
	local query = vim.treesitter.query.parse('norg', [[
	[
	(heading1) @heading
	(heading2) @heading
	(heading3) @heading
	(heading4) @heading
	(heading5) @heading
	(heading6) @heading
	]
	]])

	for _, node in query:iter_captures(root, bufnr, 0, -1) do
		table.insert(headings, node)
	end

	return headings
end

--- Jump to next heading (any level)
function AKNeorgHeadingJumpForward()
	local current_heading, current_level = get_current_heading()
	if not current_heading or not current_level then
		vim.notify("Not inside a heading", vim.log.levels.WARN)
		return
	end

	local current_row = current_heading:range()
	local headings = get_all_headings()

	-- Find next heading after current position
	for _, heading in ipairs(headings) do
		local row = heading:range()
		if row > current_row then
			goto_node(heading)
			return
		end
	end

	vim.notify("No more headings forward", vim.log.levels.INFO)
end

--- Jump to previous heading (any level)
function AKNeorgHeadingJumpBackward()
	local current_heading, current_level = get_current_heading()
	if not current_heading or not current_level then
		vim.notify("Not inside a heading", vim.log.levels.WARN)
		return
	end

	local current_row = current_heading:range()
	local headings = get_all_headings()

	-- Find previous heading before current position (iterate in reverse)
	for i = #headings, 1, -1 do
		local heading = headings[i]
		local row = heading:range()
		if row < current_row then
			goto_node(heading)
			return
		end
	end

	vim.notify("No more headings backward", vim.log.levels.INFO)
end

wk {
	-- Jump to next/previous heading at SAME level (peer)
	{ ']]', AKNeorgHeadingPeerJumpForward,  desc = 'Next peer heading (same level)' },
	{ '[[', AKNeorgHeadingPeerJumpBackward, desc = 'Previous peer heading (same level)' },

	-- Jump to next/previous heading at ANY level
	{ '}',  AKNeorgHeadingJumpForward,      desc = 'Next heading (any level)' },
	{ '{',  AKNeorgHeadingJumpBackward,     desc = 'Previous heading (any level)' },
}
