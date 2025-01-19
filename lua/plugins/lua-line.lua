local function replaceVimModes()
    local mode_map = {
        n = '  ',
        i = '  ',
        c = '  ',
        V = ' 󰛐 ',
        [''] = ' 󰛐 ',
        v = ' 󰛐 ',
        t = '󰞷 ',
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

local lualine_options = function()
    local config = {
        options = {
            theme = 'vaporlush',
            icons_enabled = true,
            component_separators = '',
            disabled_filetypes = {
                statusline = {},
                winbar = {},
            },
            ignore_focus = {},
            always_divide_middle = true,
            globalstatus = false,
            refresh = {
                statusline = 300,
                tabline = 300,
                winbar = 300,
            },
        },
        sections = {
            lualine_a = {
                { replaceVimModes, right_padding = 2 }
            },
            lualine_b = {
                {
                    'diff',
                    right_padding = 2
                }
            },
            lualine_c = { get_file_status, },
            lualine_x = { 'filetype' },
            lualine_y = {
                'progress',
                {
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
                }
            },
            lualine_z = {
                {
                    'diagnostics',
                    symbols = {
                        error = ' 󱚝  ',
                        warn  = ' 󱚟  ',
                        info  = ' 󰚩  ',
                        hint  = ' 󱜙  ',
                    },
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

    return config
end

return {
    {
        'nvim-tree/nvim-web-devicons',
        config = function()
            local ndevicons = require 'nvim-web-devicons'
            ndevicons.set_icon {
                ["docker-swarm.yml"] = {
                    icon = " ",
                    color = "#f6306f",
                    cterm_color = "65",
                    name = "DockerSwarm"
                },
                ["docker-swarm.yaml"] = {
                    icon = " ",
                    color = "#f6306f",
                    cterm_color = "65",
                    name = "DockerStack"
                },
                rs = {
                    icon = " ",
                    color = "#fe401f",
                    cterm_color = "65",
                    name ="DevIconRs"
                },
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
                    name = "CSharpProject"
                },

            }
        end,
        opts = {
        }
    },
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'adamkali/vaporlush' },
        opts = lualine_options(),
    },
    { 'MunifTanjim/nui.nvim' }
}
