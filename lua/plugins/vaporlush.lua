return {
    {
        --dir = "~/git/vaporlush",
        "adamkali/vaporlush",
        branch = "v2",
        dependencies = {
            'nvim-lualine/lualine.nvim',
            opts = function ()
                require('vaporlush.init')
local config = {    
    options = {
        icons_enabled = true,
        theme = 'vaporlush',
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
                color_added = vim.g.Vaporlush.palette.gitsigns.info,
                color_modified = vim.g.Vaporlush.palette.gitsigns.add,
                color_removed =  vim.g.Vaporlush.palette.gitsigns.change,
                right_padding =  vim.g.Vaporlush.palette.gitsigns.danger
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
local function ins_right(component)
    table.insert(config.sections.lualine_y, component)
end
ins_right { -- Lsp server name .
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
end
                    
        },
        lazy = false,
        priority = 1000,
        opts = {
            cache = true,
            style = "blossom"
        }
    },
    {
        'norcalli/nvim-colorizer.lua',
        config = function()
            require('colorizer').setup()
        end
    }
}
