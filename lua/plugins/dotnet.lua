local dotnet_opts = {
    mode = "n",     -- NORMAL mode
    silent = true,  -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = false, -- use `nowait` when creating keymaps
    expr = true,    -- use `expr` when creating keymaps
}

local function dotnet_bootstrap()
    local dotnet = require 'dotnvim'
    dotnet.bootstrap()
end

local function dotnet_build()
    local dotnet = require 'dotnvim'
    dotnet.build(false)
end

local function dotnet_build_last()
    local dotnet = require 'dotnvim'
    dotnet.build(true)
end

local function dotnet_watch()
    local dotnet = require('dotnvim')
    dotnet.watch(false)
end

local function dotnet_watch_last()
    local dotnet = require('dotnvim')
    dotnet.watch(true)
end

return {
    { 'Hoffs/omnisharp-extended-lsp.nvim' },
    {
        dir = '/home/adamkali/git/dotnvim',
        ft = { 'cs', 'vb', 'csproj', 'sln', 'slnx', 'props', 'csx', 'targets' },
        keys = {
            { '<leader>ds', dotnet_bootstrap, desc = 'Bootstrap Class' },
            { '<leader>db', dotnet_build, desc = 'Build Project' },
            { '<leader>dB', dotnet_build_last, desc = 'Build Last Project' },
            { '<leader>dw', dotnet_watch, desc = 'Watch Project' },
            { '<leader>dW', dotnet_watch_last, desc = 'Watch Last Project' },
        },
    },
}
