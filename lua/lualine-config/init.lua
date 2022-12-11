local function replaceVimModes()
    local mode_map = {
        n = '',
        i = '',
        c = '',
        V = '',
        [''] = '並',
        v = '',
        R = '﯒',
        t = '',
        default = '',
    }
    -- get the current mode
    -- if mode is nil then return default
    -- else return the mode
    local mode = mode_map[vim.fn.mode()] or mode_map.default
    return mode
end


require('lualine').setup {
	options = {
        icons_enabled = true,
        theme = 'nightfly' ,
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
        },
    },
	sections = {
		lualine_a = { replaceVimModes },
		lualine_b = {'branch', 'diff', 'diagnostics'},
		lualine_c = {'filename', ''},
		lualine_x = {'fileformat', 'filetype'},
		lualine_y = { '' ,'progress'},
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
