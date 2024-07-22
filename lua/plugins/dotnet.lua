
local dotnet_opts = {
  mode = "n", -- NORMAL mode
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = false, -- use `nowait` when creating keymaps
  expr = true, -- use `expr` when creating keymaps
}

local function dotnet_ext_go_to_def()
    local omnisharp_ext = require 'omnisharp-extended'
    omnisharp_ext.telescope_lsp_definition({ jump_type = "vsplit" })
end

local function dotnet_ext_refs()
    local omnisharp_ext = require 'omnisharp-extended'
    omnisharp_ext.telescope_lsp_references()
end

local function dotnet_ext_type_def()
    local omnisharp_ext = require 'omnisharp-extended'
    omnisharp_ext.telescope_lsp_type_definition()
end

local function dotnet_bootstrap()
    local dotnet = require'dotnet'
    dotnet.bootstrap_new_csharp_file()
end



return {
    { 'Hoffs/omnisharp-extended-lsp.nvim' },
    { dir = '~/.config/nvim/local/dotnvim'},
    {
        'MoaidHathot/dotnet.nvim',
        ft = { 'cs', 'vb', 'csproj', 'sln', 'slnx', 'props', 'csx', 'targets' },
        config = function()
            local lspconfig = require "lspconfig"
            local capabilities = require 'cmp_nvim_lsp'.default_capabilities()
            local dotnvim = require'dotnvim'

            lspconfig.omnisharp.setup({
                capabilities = capabilities,
                enable_roslyn_analysers = true,
                enable_import_completion = true,
                organize_imports_on_format = true,
                enable_decompilation_support = true,
                filetypes = { 'cs', 'vb', 'csproj', 'sln', 'slnx', 'props', 'csx', 'targets' }
            })
            local wk = require'which-key'
            wk.register({
                ["="] = {
                    name = "  ",
                    ["db"] = { dotnvim.bootstrap, ' Bootstrap Class' },
                },
            }, dotnet_opts)
        end,
    },
}
