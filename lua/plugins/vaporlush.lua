local style = "vapor"
--local style = "blossom"
--local style = "1996"
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

-- a function to see if Ollama is thinking and generating code
local function get_ollama_status()
end

vim.opt.termguicolors = true
return {
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        opts = {
            style = "night",
            transparent = true,
            lualine_bold = true,
        },
    },
    {
        "eldritch-theme/eldritch.nvim",
        lazy = false,
        priority = 1000,
        opts = {
            transparent = true,
            styles = {
                comments = { italic = true },
                keywords = { italic = true },
            }
        },
    },
    --{
    --    dir = "~/git/vaporlush",
    --    "adamkali/vaporlush",
    --    branch = "v2",
    --    lazy = false,
    --    priority = 1000,
    --    opts = {
    --        cache = true,
    --        style = style
    --    }
    --},
    {
        'nvim-lualine/lualine.nvim',
        opts = function()
            local config = {
                options = {
                    icons_enabled = true,
                    theme = 'eldritch',
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
                                error = ' 󱚝  ',
                                warn  = ' 󱚟  ',
                                info  = ' 󰚩  ',
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
    },
    {
        'norcalli/nvim-colorizer.lua',
        config = function()
            require('colorizer').setup()
        end
    }
}
