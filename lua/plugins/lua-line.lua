

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
    { 'MunifTanjim/nui.nvim' }
}
