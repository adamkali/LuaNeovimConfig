local colors = {
   Background = "#0a0425",
   Primary = {
        shade0 = "#110066",
        shade1 = "#1a0099",
        shade2 = "#2b00ff",
        shade3 = "#aa99ff",
   },
   Secondary = {
        shade0 = "#660066",
        shade1 = "#cc00cc",
        shade2 = "#ff33ff",
        shade3 = "#ff99ff",
   },
   Tertiary = {
        shade0 = "#ccaa00",
        shade1 = "#ffd500",
        shade2 = "#ffe666",
        shade3 = "#fff6cc",
   },
   Quaternary = {
        shade0 = "#3b0561",
        shade1 = "#750ac2",
        shade2 = "#a83df5",
        shade3 = "#d49efa",
   },
   Quintary = {
        shade0 = "#008080",
        shade1 = "#00cccc",
        shade2 = "#33ffff",
        shade3 = "#99ffff",
   },
}

local vaporlush_theme = {
  normal = {
    a = { fg = colors.Secondary.shade1 , bg = colors.Primary.shade0 },
    b = { fg = colors.Quaternary.shade2, bg = colors.Primary.shade2 },
    c = { fg = colors.Quaternary.shade2, bg = colors.Background },
  },
  insert = {
    a = { fg = colors.Primary.shade3 , bg = colors.Secondary.shade0 },
    b = { fg = colors.Quintary.shade1, bg = colors.Secondary.shade1 },
    c = { fg = colors.Background, bg = colors.Background },
  }, 
  visual = {
    a = { fg = colors.Quintary.shade2 , bg = colors.Tertiary.shade0 },
    b = { fg = colors.Primary.shade2, bg = colors.Tertiary.shade1 },
    c = { fg = colors.Primary.shade2, bg = colors.Background },
  },
  replace = {
    a = { fg = colors.Tertiary.shade2 , bg = colors.Quaternary.shade0 },
    b = { fg = colors.Tertiary.shade1, bg = colors.Quaternary.shade1 },
    c = { fg = colors.Tertiary.shade1, bg = colors.Background },
  },
  command = {
    a = { fg = colors.Quaternary.shade3 , bg = colors.Quintary.shade0 },
    b = { fg = colors.Quaternary.shade2, bg = colors.Quintary.shade1 },
    c = { fg = colors.Quaternary.shade2, bg = colors.Background },
  },
}


local function replaceVimModes()
    local mode_map = {
        n = '',
        i = '',
        c = ':',
        V = '',
        [''] = '',
        v = '',
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
        theme = vaporlush_theme ,
        component_separators = '',
        --section_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
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
        lualine_a = { { replaceVimModes, separator = { right = '', left = '' }, right_padding = 2 } },
        lualine_b = {'branch', 'diff', 'diagnostics'},
        lualine_c = {'filename', ''},
        lualine_x = { 'filetype'},
        lualine_y = { '' ,'progress'},
        lualine_z = { {'location', separator = { right = '', left = '' }, left_padding = 2} }
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

require('bufferline').setup { }
