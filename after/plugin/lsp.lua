-- Default Keybindings

local on_attatch = function(_, _)
    local wk = require 'which-key'
    wk.add{
        { "<BS>",  expr = false,                                group = "LSP Generic",         nowait = false, remap = true },
        { "<BS>c", function() vim.lsp.buf.code_action() end,    desc = 'Code action',          expr = false,   nowait = false, remap = true },
        { "<BS>D", function() vim.lsp.buf.declaration() end,    desc = "Go to declaration",    expr = false,   nowait = false, remap = true },
        { "<BS>k", function() vim.lsp.buf.hover() end,          desc = "Show Hover Actions",   expr = false,   nowait = false, remap = true },
        { "<BS>R", function() vim.lsp.buf.references() end,     desc = "Find References",      expr = false,   nowait = false, remap = true },
        { "<BS>d", function() vim.lsp.buf.definition() end,     desc = "Go to definition",     expr = false,   nowait = false, remap = true },
        { "<BS>i", function() vim.lsp.buf.implementation() end, desc = "Go to implementation", expr = false,   nowait = false, remap = true },
        { "<BS>r", function() vim.lsp.buf.rename() end,         desc = "Rename File",          expr = false,   nowait = false, remap = true },
        {
            "<BS>s",
            function()
                vim.diagnostic.goto_prev({ popup_opts = { border = "rounded", focusable = false } })
            end,
            desc = "Go to previous diagnostic",
            expr = false,
            nowait = false,
            remap = true
        },
        {
            "<BS>a",
            function()
                vim.diagnostic.goto_next({ popup_opts = { border = "rounded", focusable = false } })
            end,
            desc = "Go to next diagnostic",
            expr = false,
            nowait = false,
            remap = true
        },
    }
end

-- Configure the servers here

local servers = {
    "lua_ls",
    "gopls",
    "ts_ls",
    "docker_compose_language_service",
    "dockerls",
    "clangd",
    "html",
    "svelte",
    "marksman",
    "tailwindcss",
    "sqlls",
    "elixirls",
    "templ",
    "pyright",
    "somesass_ls",
    "hls",
    "svelte",
    "cssls",
    "yamlls",
}
require("mason-lspconfig").setup {
    ensure_installed = servers,
    automatic_enable = false
}
local lspconfig = require "lspconfig"
local capabilities = require('blink.cmp').get_lsp_capabilities()
for _, value in ipairs(servers) do
    lspconfig[value].setup {
        on_attatch = on_attatch(),
        capabilities = capabilities
    }
end
-- for gleam as well
lspconfig.gleam.setup({
    on_attatch = on_attatch(),
    capabilities = capabilities
})
lspconfig.html.setup({
    on_attatch = on_attatch(),
    capabilities = capabilities,
    filetypes = { "html", "templ" },
})
lspconfig.htmx.setup({
    on_attatch = on_attatch(),
    capabilities = capabilities,
    filetypes = { "html", "templ" },
})
lspconfig.tailwindcss.setup({
    on_attatch = on_attatch(),
    capabilities = capabilities,
    filetypes = { "templ", "astro", "javascript", "typescript", "react", "svelte" },
    settings = {
        tailwindCSS = {
            includeLanguages = {
                templ = "html",
            },
        },
    },
})
lspconfig.csharp_ls.setup({
    on_attatch = on_attatch(),
    capabilities = capabilities,
    enable_roslyn_analysers = true,
    enable_import_completion = true,
    organize_imports_on_format = true,
    enable_decompilation_support = true,
    filetypes = { 'cs', 'vb', 'csproj', 'sln', 'slnx', 'props', 'csx', 'targets' }
})
