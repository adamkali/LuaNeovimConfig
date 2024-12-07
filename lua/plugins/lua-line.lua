-- TODO: move to vapor lush
local colors = {
    Background = "#0E082B",
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
        a = { fg = colors.Secondary.shade1, bg = colors.Primary.shade0 },
        b = { fg = colors.Quaternary.shade2, bg = colors.Primary.shade2 },
        c = { fg = colors.Quaternary.shade2, bg = colors.Background },
    },
    insert = {
        a = { fg = colors.Primary.shade3, bg = colors.Secondary.shade0 },
        b = { fg = colors.Quintary.shade1, bg = colors.Secondary.shade1 },
        c = { fg = colors.Background, bg = colors.Background },
    },
    visual = {
        a = { fg = colors.Quintary.shade2, bg = colors.Tertiary.shade0 },
        b = { fg = colors.Primary.shade2, bg = colors.Tertiary.shade1 },
        c = { fg = colors.Primary.shade2, bg = colors.Background },
    },
    replace = {
        a = { fg = colors.Tertiary.shade2, bg = colors.Quaternary.shade0 },
        b = { fg = colors.Tertiary.shade1, bg = colors.Quaternary.shade1 },
        c = { fg = colors.Tertiary.shade1, bg = colors.Background },
    },
    command = {
        a = { fg = colors.Quaternary.shade3, bg = colors.Quintary.shade0 },
        b = { fg = colors.Quaternary.shade2, bg = colors.Quintary.shade1 },
        c = { fg = colors.Quaternary.shade2, bg = colors.Background },
    },
}

local function replaceVimModes()
    local mode_map = {
        n = '  ',
        i = '  ',
        c = '  ',
        V = '  ',
        [''] = ' 󰛐 ',
        v = ' 󰛐 ',
        t = '󰞷',
        default = '',
    }
    -- get the current mode
    -- if mode is nil then return default
    -- else return the mode
    local mode = mode_map[vim.fn.mode()] or mode_map.default
    return mode
end

-- a function to get the current file name without its extension
-- and with if it is modified or not
local function get_file_status()
    local fname = vim.fn.expand('%:t')
    if vim.bo.modified then
        return '  ' .. fname .. ' '
    end
    return ' ' .. fname .. ' '
end

-- 
-- 
local config = {
    theme = vaporlush_theme,
    options = {
        icons_enabled = true,
        component_separators = '',
        section_separators = { right = '', left = '' },
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
        lualine_a = {
            {
                replaceVimModes,
                separator = { right = '', left = '' },

                right_padding = 2
            }
        },
        lualine_b = {
            { 'FugitiveHead', icon = "", right_padding = 2 },
            {
                'diff',
                symbols = { added = ' ', modified = ' ', removed = '' },
                color_added = colors.Tertiary.shade1,
                color_modified = colors.Tertiary.shade2,
                color_removed = colors.Tertiary.shade3,
                right_padding = 2
            }
        },
        lualine_c = { get_file_status, },
        lualine_x = {
            'filetype' },
        lualine_y = { ' ', 'progress' },
        lualine_z = {
            {
                'diagnostics',
                symbols = {
                    error = ' 󱚝  ',
                    warn  = ' 󱚟  ',
                    info  = ' 󰚩  ',
                },
                sources = { 'nvim_lsp', },
                separator = { right = '', left = '' },
                left_padding = 2,
                always_visible = true
            }
        }
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { 'filename' },
        lualine_x = { 'location' },
        lualine_y = {},
        lualine_z = {}
    },
    tabline = {},
    winbar = {},
    inactive_winbar = {},
    extensions = {}
}

local function ins_right(component)
    table.insert(config.sections.lualine_y, component)
end

ins_right {
    -- Lsp server name .
    function()
        local msg = ''
        local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
        local clients = vim.lsp.get_active_clients()
        if next(clients) == nil then
            return msg
        end
        for _, client in ipairs(clients) do
            local filetypes = client.config.filetypes
            if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
                return client.name
            end
        end
        return msg
    end,
    icon = ' ',
    separator = { right = '', left = '' },
    color = { fg = '#00cc99', gui = 'bold' },
}

local function debug_nvim_web_dev_icons()

end

return {
    {
        'nvim-tree/nvim-web-devicons',
        config = function()
            local ndevicons = require 'nvim-web-devicons'
            ndevicons.set_icon {
                gleam = {
                    icon = "󰊠",
                    color = "#ef57e5",
                    cterm_color = "65",
                    name = "Gleam"
                },
                cs = {
                    icon = "",
                    color = "#33ffff",
                    cterm_color = "65",
                    name = "Csharp"
                },
                lua = {
                    icon = "󰣙",
                    color = "#51a0cf",
                    cterm_color = "65",
                    name = "Lua"
                },
                csproj = {
                    icon = "",
                    color = "#3333ff",
                    name="CSharpProject"
                },
            }
        end,
        keys = {
            { "--vd", debug_nvim_web_dev_icons, desc = "Find Files" }
        }
    },
    {
        'nvim-lualine/lualine.nvim',
        opts = config
    },
    { 'MunifTanjim/nui.nvim' }
}
