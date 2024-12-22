
local function debug_nvim_web_dev_icons()

    return config
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
                    name = "CSharpProject"
                },
            }
        end,
    },
    { 'MunifTanjim/nui.nvim' }
}
