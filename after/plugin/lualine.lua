---@diagnostic disable: need-check-nil
-- Lualine config with Vaporlush palette integration
-- Falls back to default themes when vaporlush is not available

local lualine = require('lualine')

-- Get vaporlush palette from global variable set by colorscheme
local function get_vaporlush()
	if vim.g.Vaporlush then
		return vim.g.Vaporlush.palette, vim.g.Vaporlush.lualine
	end
	return nil, nil
end

local colors, vaporlush_theme = get_vaporlush()

-- If vaporlush is not available, use default theme
if not colors or not vaporlush_theme then
	lualine.setup {
		options = {
			theme = 'auto',
			component_separators = { left = '', right = '' },
			section_separators = { left = '', right = '' },
		}
	}
	return
end

-- Condition: Hide in width (only show when window width > 80)
local function hide_in_width()
	return vim.fn.winwidth(0) > 80
end

-- Get mode color from vaporlush theme
local function get_mode_color()
	local mode = vim.fn.mode()

	if mode == 'i' then
		return vaporlush_theme.insert.a.bg
	elseif mode == 'v' or mode == 'V' or mode == '' then
		return vaporlush_theme.visual.a.bg
	elseif mode == 'c' then
		return vaporlush_theme.command.a.bg
	elseif mode == 'R' then
		return vaporlush_theme.replace.a.bg
	else
		return vaporlush_theme.normal.a.bg
	end
end

-- Get mode indicator
local function mode()
	local mode_map = {
		n = '',
		i = '',
		v = '󰈈',
		[''] = '󰈈',
		V = '󰈈',
		c = '',
		no = '',
		s = '󱙧',
		S = '󱙧',
		ic = '',
		R = '',
		Rv = '',
		cv = '',
		ce = '',
		r = '',
		rm = '',
		['r?'] = '',
		['!'] = '',
		t = '',
	}
	return mode_map[vim.fn.mode()] or '[UNKNOWN]'
end

-- Configuration
local config = {
	options = {
		component_separators = '',
		section_separators = '',
		theme = 'vaporlush', -- Use vaporlush theme string
		disabled_filetypes = {
			'neo-tree',
			'undotree',
			'sagaoutline',
			'diff',
		},
	},
	sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = {},
		lualine_x = {},
		lualine_y = {},
		lualine_z = {},
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = {
			{
				'location',
				color = function()
					return {
						fg = colors.fg,
						gui = 'bold',
					}
				end,
			},
		},
		lualine_x = {
			{
				'filename',
				color = function()
					return {
						fg = colors.fg,
						gui = 'bold,italic',
					}
				end,
			},
		},
		lualine_y = {},
		lualine_z = {},
	},
}

-- Helper functions
local function ins_left(component)
	table.insert(config.sections.lualine_c, component)
end

local function ins_right(component)
	table.insert(config.sections.lualine_x, component)
end

-- LEFT SIDE COMPONENTS

-- Mode indicator
ins_left {
	mode,
	color = function()
		return {
			fg = colors.bg,
			bg = get_mode_color(),
			gui = 'bold',
		}
	end,
	padding = { left = 1, right = 1 },
}

-- Separator (mode -> cyan)
ins_left {
	function()
		return '▓'
	end,
	color = function()
		return {
			fg = get_mode_color(),
			bg = colors.gitsigns.add, -- cyan from tmux
		}
	end,
	padding = { left = 0 },
}

-- Current directory
ins_left {
	function()
		return vim.fn.fnamemodify(vim.fn.getcwd(), ':t')
	end,
	icon = '󰣞',
	color = function()
		local virtual_env = vim.env.VIRTUAL_ENV
		return {
			fg = colors.bg,
			bg = colors.gitsigns.add,
			gui = virtual_env and 'bold,strikethrough' or 'bold',
		}
	end,
}

-- Separator (cyan -> tertiary)
ins_left {
	function()
		return '▓'
	end,
	color = function()
		return {
			fg = colors.gitsigns.add,
			bg = colors.tertiary2,
		}
	end,
	padding = { left = 0 },
}

-- Filename with unsaved indicator
ins_left {
	function()
		local filename = vim.fn.expand('%:t')
		if filename == '' then
			filename = '[No Name]'
		end

		-- Add cross if file is modified
		if vim.bo.modified then
			return filename .. ' ♰'
		end
		return filename
	end,
	icon = '',
	color = function()
		return {
			fg = colors.bg,
			bg = colors.tertiary2,
			gui = 'bold',
		}
	end,
}

-- Separator (tertiary -> background)
ins_left {
	function()
		return '▓'
	end,
	color = function()
		return {
			fg = colors.tertiary2,
			bg = colors.bg,
		}
	end,
	padding = { left = 0 },
}

-- Git changes
ins_left {
	function()
		return ''
	end,
	color = function()
		return { fg = colors.tertiary2 }
	end,
	cond = hide_in_width,
}

ins_left {
	function()
		local git_status = vim.b.gitsigns_status_dict
		if git_status then
			return string.format('+%d ~%d -%d', git_status.added or 0, git_status.changed or 0, git_status.removed or 0)
		end
		return ''
	end,
	color = {
		fg = colors.quartary3,
		gui = 'bold',
	},
	cond = hide_in_width,
}

-- Search count
ins_left {
	'searchcount',
	color = {
		fg = colors.gitsigns.add,
		gui = 'bold',
	},
}

-- RIGHT SIDE COMPONENTS

-- Recording indicator
ins_right {
	function()
		local reg = vim.fn.reg_recording()
		return reg ~= '' and '[' .. reg .. ']' or ''
	end,
	color = {
		fg = colors.gitsigns.danger,
		gui = 'bold',
	},
	cond = function()
		return vim.fn.reg_recording() ~= ''
	end,
}

-- Selection count
ins_right {
	'selectioncount',
	color = {
		fg = colors.gitsigns.add,
		gui = 'bold',
	},
}

-- Separator (background -> green/cyan for LSP)
ins_right {
	function()
		return '▓'
	end,
	color = function()
		return {
			fg = colors.quartary2,
			bg = colors.bg,
		}
	end,
	padding = { left = 0 },
}

-- LSP status with language icons
ins_right {
	function()
		local msg = ' No LSP'
		local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
		local clients = vim.lsp.get_clients()
		if next(clients) == nil then
			return msg
		end

		-- LSP names with nerd font icons
		local lsp_icons = {
			pyright = '  ',
			tsserver = '  ',
			rust_analyzer = '  ',
			lua_ls = '',
			clangd = '  ',
			bashls = '  ',
			jsonls = '  ',
			html = '  ',
			cssls = '  ',
			tailwindcss = ' 󱏿 ',
			dockerls = '  ',
			sqlls = '  ',
			yamlls = ' 󰏭 ',
			gopls = '  ',
			jdtls = '  ',
			omnisharp = '  ',
			csharp_ls = '  ',
			phpactor = '  ',
			solargraph = '  ',
			elixirls = '  ',
			zls = ' 󰈸 ',
		}

		for _, client in ipairs(clients) do
			local filetypes = client.config.filetypes
			if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
				return lsp_icons[client.name] or ' ' .. client.name
			end
		end
		return msg
	end,
	color = {
		fg = colors.bg,
		bg = colors.quartary1,
		gui = 'bold',
	},
}

-- LSP Diagnostics (same section as LSP)
ins_right {
	function()
		local diagnostics = vim.diagnostic.get(0)
		local count = { errors = 0, warnings = 0, info = 0, hints = 0 }

		for _, diagnostic in ipairs(diagnostics) do
			if diagnostic.severity == vim.diagnostic.severity.ERROR then
				count.errors = count.errors + 1
			elseif diagnostic.severity == vim.diagnostic.severity.WARN then
				count.warnings = count.warnings + 1
			elseif diagnostic.severity == vim.diagnostic.severity.INFO then
				count.info = count.info + 1
			elseif diagnostic.severity == vim.diagnostic.severity.HINT then
				count.hints = count.hints + 1
			end
		end

		local parts = {}
		if count.errors > 0 then
			table.insert(parts, string.format('󱙧 %d', count.errors))
		end
		if count.warnings > 0 then
			table.insert(parts, string.format(' %d', count.warnings))
		end
		if count.info > 0 then
			table.insert(parts, string.format(' %d', count.info))
		end
		if count.hints > 0 then
			table.insert(parts, string.format('󰦶 %d', count.hints))
		end

		if #parts == 0 then
			return ' ✓'
		end

		return table.concat(parts, ' ')
	end,
	color = {
		fg = colors.bg,
		bg = colors.quartary1,
		gui = 'bold',
	},
}

-- Separator (pink -> blue)
ins_right {
	function()
		return '▓'
	end,
	color = function()
		return {
			fg = colors.primary2, -- blue
			bg = colors.quartary1, -- pink
		}
	end,
	padding = { left = 0 },
}

-- Git branch with custom formatting
ins_right {
	'branch',
	icon = '',
	fmt = function(branch)
		if branch == '' or branch == nil then
			return 'No Repo'
		end

		-- Truncate segment to specified length
		local function truncate_segment(segment, max_length)
			if #segment > max_length then
				return segment:sub(1, max_length)
			end
			return segment
		end

		-- Split branch name by '/'
		local segments = {}
		for segment in branch:gmatch('[^/]+') do
			table.insert(segments, segment)
		end

		-- Truncate all segments except the last one
		for i = 1, #segments - 1 do
			segments[i] = truncate_segment(segments[i], 1)
		end

		-- If single segment, return as-is
		if #segments == 1 then
			return segments[1]
		end

		-- Capitalize first, lowercase middle segments
		segments[1] = segments[1]:upper()
		for i = 2, #segments - 1 do
			segments[i] = segments[i]:lower()
		end

		-- Combine with separator
		local truncated_branch = table.concat(segments, '', 1, #segments - 1) .. '›' .. segments[#segments]

		-- Ensure max length
		local max_total_length = 15
		if #truncated_branch > max_total_length then
			truncated_branch = truncated_branch:sub(1, max_total_length) .. '…'
		end

		return truncated_branch
	end,
	color = function()
		return {
			fg = colors.bg,
			bg = colors.primary2, -- blue
			gui = 'bold',
		}
	end,
}

-- Separator (blue -> purple)
ins_right {
	function()
		return '▓'
	end,
	color = function()
		return {
			fg = colors.tertiary3, -- purple
			bg = colors.primary2, -- blue
		}
	end,
	padding = { left = 0 },
}

-- Progress
ins_right {
	'progress',
	icon = '󰥔',
	color = function()
		return {
			fg = colors.bg,
			bg = colors.tertiary3, -- purple
			gui = 'bold',
		}
	end,
}

-- Apply configuration
lualine.setup(config)
