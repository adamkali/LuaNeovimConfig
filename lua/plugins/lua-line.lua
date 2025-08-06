-- [nvim-lualine/lualine.nvim]{https://github.com/nvim-lualine/lualine.nvim}

return {
    'nvim-lualine/lualine.nvim',
    opts = function()
        -- We write out this function to replace icons for certain modes,

        local function replaceVimModes()
            local mode_map = {
                n = ' ॐ   ',
                i = ' युज्  ',
                c = ' आदेश ',
                V = ' नेत्र ',
                [''] = ' 󰛐 ',
                v = ' नेत्र ',
                t = '󰞷',
                default = '',
            }
            -- get the current mode
            -- if mode is nil then return default
            -- else return the mode
            local mode = mode_map[vim.fn.mode()] or mode_map.default
            return mode
        end

        -- Format out if the file needs to pe saved

        local function get_file_status()
            local fname = vim.fn.expand('%:t')
            if vim.bo.modified then
                return '  ' .. fname .. ' '
            end
            return ' ' .. fname .. ' '
        end

        -- Now we write out the config

        local config = {
            options = {
                icons_enabled = true,
                theme = 'vaporlush',
                component_separators = '',
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
                        right_padding = 2
                    }
                },
                lualine_b = {
                    {
                        'diff',
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
                            error = '  ',
                            warn  = '󰞏  ',
                            info  = '  ',
                            hint  = '  ',
                        },
                        diagnostics_color = {
                            error = { fg = '#ffffff', bg = '#ea286a' },
                            warn = { fg = '#000000', bg = '#FFAB22' },
                            info = { fg = '#ffffff', bg = '#2282E6' },
                            hint = { fg = '#000000', bg = '#22f2f2' }
                        },
                        sources = { 'nvim_lsp', },
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
        }
        return config
    end
}
