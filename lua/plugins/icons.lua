-- Configure icons

return {
    'nvim-tree/nvim-web-devicons',
    config = function()
        local ndevicons = require 'nvim-web-devicons'
        ndevicons.set_icon {
            [".gitlab-ci.yaml"] = {
                icon = "",
                color = "#ff801f",
                cterm_color = "65",
                name = "GitlabCI"
            },
            ["docker-compose.yml"] = {
                icon = " ",
                color = "#9027ff",
                cterm_color = "65",
                name = "DockerCompose"
            },
            ["compose.yml"] = {
                icon = " ",
                color = "#9027ff",
                cterm_color = "65",
                name = "DockerCompose"
            },
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
}
