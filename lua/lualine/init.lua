local function ModeIcons()
	-- get the  curret vim mode
	local mode = vim.fn.mode()

	-- retur icons based on mode
	if mode == 'n' then
		return ''
	elseif mode == 'i' then
		return ''
	elseif mode == 'R' then
		return ''
	elseif mode == 'v' then
		return ''
	elseif mode == 'V' then
		return ''
	elseif mode == 'c' then
		return ''
	elseif mode == 's' then
		return ''
	elseif mode == 'S' then
		return ''
	else return ''
	end
end

require('lualine').setup {
	options = {
	  icons_enabled = true,
	  theme = 'kanagawa',
	  component_separators = { left = '', right = ''},
	  section_separators = { left = '', right = ''},
	  disabled_filetypes = {
		statusline = {},
		winbar = {},
	  },
	  ignore_focus = {},
	  always_divide_middle = true,
	  globalstatus = false,
	  refresh = {
		statusline = 1000,
		tabline = 1000,
		winbar = 1000,
	  }
	},
	sections = {
	  lualine_a = { ModeIcons},
	  lualine_b = {'branch', 'diff', 'diagnostics'},
	  lualine_c = {'filename'},
	  lualine_x = {'fileformat', 'filetype'},
	  lualine_y = {'progress'},
	  lualine_z = {'location'}
	},
	inactive_sections = {
	  lualine_a = {},
	  lualine_b = {},
	  lualine_c = {'filename'},
	  lualine_x = {'location'},
	  lualine_y = {},
	  lualine_z = {}
	},
	tabline = {},
	winbar = {},
	inactive_winbar = {},
	extensions = {}
  }