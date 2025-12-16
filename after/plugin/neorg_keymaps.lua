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
}
wk {
	{ neorg_agenda_leader, expr = false, group = "[n]eorg [a]genda", nowait = false, remap = false, icon = { icon = "󰕪", "@lsp.type.enum" } },
	{
		neorg_agenda_leader .. 'a',
		'<cmd>Neorg agenda page ambiguous<cr>',
		desc = '[n]eorg [a]genda [a]mbiguous',
		icon = {
			icon = todos.ambiguous,
			hl = "@neorg.todo_items.uncertain"
		}
	},
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
		neorg_agenda_leader .. 'D',
		'<cmd>Neorg agenda day<cr>',
		desc = '[n]eorg [a]genda [D]ay',
	},
	{
		neorg_agenda_leader .. 'U',
		'<cmd>Neorg update_property_metadata<cr>',
		desc = '[n]eorg [a]genda [U]pdate Property Metadata',
	}
}
