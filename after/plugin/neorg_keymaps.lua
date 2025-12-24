local wk = require('which-key').add

-- leaders
local neorg_roam_leader = "<space>nr"
local neorg_roam_capture_leader = neorg_roam_leader .. "c"
local neorg_leader = "<space>n"
local neorg_leader_todo = neorg_leader .. "t"
local neorg_journal_leader = neorg_leader .. "l"
local neorg_agenda_leader = neorg_leader .. "a"

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

wk {
	{ neorg_leader, expr = false, group = "[n]eorg", nowait = false, remap = false, icon = { icon = "", "@constructor.tsx" } },
	{ neorg_leader .. 'c', '<cmd>:Neorg toc right<cr>', desc = '[n]eorg table of [c]ontents' },
	{ neorg_leader .. 'm', '<Plug>(neorg.looking-glass.magnify-code-block)', desc = '[n]eorg code [m]agnify' },
	{ neorg_leader .. '.', '<cmd>:Neorg tangle current-file<cr>', desc = '[n]eorg tangle [.]' },
	{ neorg_leader .. 'i', '<cmd>:Neorg inject-metadata<cr>', desc = '[n]eorg [i]nject metadata' },
	{ neorg_leader .. 'p', '<cmd>:Neorg export to-file ' .. add_to_posts() .. ' markdown<cr>', desc = '[n]eorg [p]ost to blog' },
	{ neorg_leader .. 'e', require('norbsidian').get_selections, desc = "[N]eorg [e]xport selection" },
	{ neorg_leader .. 's', '<cmd>:Neorg dew_catngo full<cr>', desc = '[n]eorg [s]earch categories' },
}

wk {
	{ neorg_leader_todo, expr = false, group = "[n]eorg [t]odo", nowait = false, remap = false, icon = { icon = "", "@constructor.tsx" } },
	{
		neorg_leader_todo .. 'a',
		'<Plug>(neorg.qol.todo-items.todo.task-ambiguous)',
		desc = '[n]eorg [t]odo [a]mbiguous',
		icon = {
			icon = todos.ambiguous,
			hl = "@neorg.todo_items.uncertain"
		}
	},
	{
		neorg_leader_todo .. 'c',
		'<Plug>(neorg.qol.todo-items.todo.task-cancelled)',
		desc = '[n]eorg [t]odo [c]ancelled',
		icon = {
			icon = todos.cancelled,
			hl = "@neorg.todo_items.cancelled"
		}
	},
	{
		neorg_leader_todo .. 'd',
		'<Plug>(neorg.qol.todo-items.todo.task-done)',
		desc = '[n]eorg [t]odo [d]one',
		icon = {
			icon = todos.done,
			hl = "@neorg.todo_items.done"
		}
	},
	{
		neorg_leader_todo .. 'h',
		'<Plug>(neorg.qol.todo-items.todo.task-on-hold)',
		desc = '[n]eorg [t]odo [o]n-hold',
		icon = {
			icon = todos.on_hold,
			hl = "@neorg.todo_items.on_hold"
		}
	},
	{
		neorg_leader_todo .. 'i',
		'<Plug>(neorg.qol.todo-items.todo.task-important)',
		desc = '[n]eorg [t]odo [i]mportant',
		icon = {
			icon = todos.urgent,
			hl = "@neorg.todo_items.urgent"
		}
	},
	{
		neorg_leader_todo .. 'p',
		'<Plug>(neorg.qol.todo-items.todo.task-pending)',
		desc = '[n]eorg [t]odo [p]ending',
		icon = {
			icon = todos.pending,
			hl = "@neorg.todo_items.pending"
		}
	},
	{
		neorg_leader_todo .. 'r',
		'<Plug>(neorg.qol.todo-items.todo.task-recurring)',
		desc = '[n]eorg [t]odo [r]ecurring',
		icon = {
			icon = todos.recurring,
			hl = "@neorg.todo_items.recurring"
		}
	},
	{
		neorg_leader_todo .. 'u',
		'<Plug>(neorg.qol.todo-items.todo.task-undone)',
		desc = '[n]eorg [t]odo [u]ndone',
		icon = {
			icon = todos.undone,
			hl = "@neorg.todo_items.undone"
		}
	},
}

wk {
	{ neorg_roam_leader, expr = false, group = "[n]eorg [r]oam", nowait = false, remap = false, icon = { icon = "", "@lsp.type.enum" } },
	{ neorg_roam_leader .. 's', '<cmd>:Neorg roam select_workspace<cr>', desc = '[n]eorg [r]oam [s]elect_workspace' },
	{ neorg_roam_leader .. 'n', '<cmd>:Neorg roam node<cr>', desc = '[n]eorg [r]oam [n]ode' },
	{ neorg_roam_leader .. 'b', '<cmd>:Neorg roam backlinks<cr>', desc = '[n]eorg [r]oam [b]acklinks' },
}

wk {
	{ neorg_journal_leader, expr = false, group = "[n]eorg journa[l]", nowait = false, remap = false, icon = { icon = "󰨇", "@lsp.type.enum" } },
	{ neorg_journal_leader .. 'y', '<cmd>:Neorg journal yesterday<cr>', desc = '[n]eorg journa[l] [y]esterday' },
	{ neorg_journal_leader .. 'o', '<cmd>:Neorg journal today<cr>', desc = '[n]eorg journa[l] t[o]day' },
	{ neorg_journal_leader .. 't', '<cmd>:Neorg journal tomorrow<cr>', desc = '[n]eorg journa[l] [t]omorrow' },
}
wk {
	{ neorg_roam_capture_leader, expr = false, group = "[n]eorg [r]oam [c]apture", nowait = false, remap = false, icon = { icon = "", "@lsp.type.enum" } },
	{ neorg_roam_capture_leader .. 't', '<cmd>:Neorg roam capture todo<cr>', desc = '[n]eorg [r]oam [c]apture [t]odo' },
	{ neorg_roam_capture_leader .. 'n', '<cmd>:Neorg roam capture note<cr>', desc = '[n]eorg [r]oam [c]apture [n]otes' },
	{ neorg_roam_capture_leader .. 'm', '<cmd>:Neorg roam capture movie-review<cr>', desc = '[n]eorg [r]oam [c]apture [m]ovie' },
	{ neorg_roam_capture_leader .. 's', '<cmd>:Neorg roam capture show-review<cr>', desc = '[n]eorg [r]oam [c]apture [s]how' },
	{ neorg_roam_capture_leader .. 'm', '<cmd>:Neorg roam capture resturant-review<cr>', desc = '[n]eorg [r]oam [c]apture [r]esturant' },
	{ neorg_roam_capture_leader .. 's', '<cmd>:Neorg roam capture selection<cr>', desc = '[n]eorg [r]oam [c]apture [s]election', mode = 'v' },
	{ neorg_roam_capture_leader .. 'c', '<cmd>:Neorg roam capture<cr>', desc = '[n]eorg [r]oam [c]apture [c]' },
}
wk {
	{ neorg_agenda_leader, expr = false, group = "[n]eorg [a]genda", nowait = false, remap = false, icon = { icon = "󰕪", "@lsp.type.enum" } },
	{
		neorg_agenda_leader .. 'c',
		'<cmd>Neorg agenda page cancelled<cr>',
		desc = '[n]eorg [a]genda [c]ancelled',
		icon = {
			icon = todos.cancelled,
			hl = "@neorg.todo_items.cancelled"
		}
	},
	{
		neorg_agenda_leader .. 'd',
		'<cmd>Neorg agenda page done<cr>',
		desc = '[n]eorg [a]genda [d]one',
		icon = {
			icon = todos.done,
			hl = "@neorg.todo_items.done"
		}
	},
	{
		neorg_agenda_leader .. 'h',
		'<cmd>Neorg agenda page hold<cr>',
		desc = '[n]eorg [a]genda [o]n-hold',
		icon = {
			icon = todos.on_hold,
			hl = "@neorg.todo_items.on_hold"
		}
	},
	{
		neorg_agenda_leader .. 'i',
		'<cmd>Neorg agenda page important<cr>',
		desc = '[n]eorg [a]genda [i]mportant',
		icon = {
			icon = todos.urgent,
			hl = "@neorg.todo_items.urgent"
		}
	},
	{
		neorg_agenda_leader .. 'p',
		'<cmd>Neorg agenda page pending<cr>',
		desc = '[n]eorg [a]genda [p]ending',
		icon = {
			icon = todos.pending,
			hl = "@neorg.todo_items.pending"
		}
	},
	{
		neorg_agenda_leader .. 'r',
		'<cmd>Neorg agenda page recurring<cr>',
		desc = '[n]eorg [a]genda [r]ecurring',
		icon = {
			icon = todos.recurring,
			hl = "@neorg.todo_items.recurring"
		}
	},
	{
		neorg_agenda_leader .. 'u',
		'<cmd>Neorg agenda page undone<cr>',
		desc = '[n]eorg [a]genda [u]ndone',
		icon = {
			icon = todos.undone,
			hl = "@neorg.todo_items.undone"
		}
	},
	{
		neorg_agenda_leader .. 'a',
		'<cmd>Neorg agenda day<cr>',
		desc = '[n]eorg [a]genda d[a]y',
	},
	{
		neorg_agenda_leader .. 'U',
		'<cmd>Neorg update_property_metadata<cr>',
		desc = '[n]eorg [a]genda [U]pdate Property Metadata',
	}
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
	{ ']]' , AKNeorgHeadingPeerJumpForward, desc = 'Next peer heading (same level)' },
	{ '[[' , AKNeorgHeadingPeerJumpBackward, desc = 'Previous peer heading (same level)' },
	-- Jump to next/previous heading at ANY level
	{ '}',  AKNeorgHeadingJumpForward, desc = 'Next heading (any level)' },
	{ '{',  AKNeorgHeadingJumpBackward, desc = 'Previous heading (any level)' },
}
