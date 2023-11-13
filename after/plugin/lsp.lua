local lsp = require('lsp-zero')
local capabilities = require('cmp_nvim_lsp').default_capabilities()
local wk = require('which-key')
local mason_lsp = require'mason-lspconfig'

require"neodev".setup{
    library = {
        plugins = { "neotest" },
        types = true
    }
}

lsp.preset('recommended')
lsp.on_attach(function(_, bufnr)
    lsp.default_keymaps({buffer = bufnr})
    lsp.buffer_autoformat()
end)

require'mason'.setup()
mason_lsp.setup{
    ensure_installed = {
        'tsserver',
        'tailwindcss',
        'rust_analyzer',
        'pyright',
        "texlab",
        "marksman",
        "lua_ls",
        "dockerls",
        "docker_compose_language_service",
        "svelte",
        "omnisharp",
    }
}

lsp.on_attach(function(_, bufnr)
    local opts = {
      mode = "n", -- NORMAL mode
      prefix = "",
      buffer = bufnr, -- Global mappings. Specify a buffer number for buffer local mappings
      silent = true, -- use `silent` when creating keymaps
      noremap = true, -- use `noremap` when creating keymaps
      nowait = false, -- use `nowait` when creating keymaps
      expr = false, -- use `expr` when creating keymaps
    }
    wk.register({
        g = {
            name = 'LSP Generic',
            d = { function() vim.lsp.buf.definition() end, 'Go to definition' },
            D = { function() vim.lsp.buf.declaration() end, 'Go to declaration' },
            i = { function() vim.lsp.buf.implementation() end, 'Go to implementation' },
            r = { function() vim.lsp.buf.rename() end, 'Rename File' },
            R = { function() vim.lsp.buf.references() end, 'Find References' },
            K = { function () vim.lsp.buf.hover() end, 'Show Hover Actions'},
            ['['] = { function ()
                   vim.diagnostic.goto_prev({popup_opts = {border = "rounded", focusable = false}})
                end,
                'Go to previous diagnostic'
            },
            [']'] = {
                function ()
                    vim.diagnostic.goto_next({popup_opts = {border = "rounded", focusable = false}})
                end,
                'Go to next diagnostic'
            }
        }
    }, opts)
    opts.prefix = '<leader>'
    wk.register({
        ["vw"] = {
            name = 'LSP Workspace',
            a = { function() vim.lsp.buf.add_workspace_folder() end, 'Add workspace folder' },
            r = { function() vim.lsp.buf.remove_workspace_folder() end, 'Remove workspace folder' },
            l = { function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, 'List workspace folders' },
            s = { function() vim.lsp.buf.workspace_symbol() end, 'Search workspace symbols' },
            c = { function() vim.lsp.buf.code_action() end, 'Code action' },
        },
    }, opts)
end)

local sign = function (opts)
    vim.fn.sign_define(opts.name, {text = opts.text, texthl = opts.color, linehl = '', numhl = ''})
end

sign({ name = 'DiagnosticSignError', text = '󱚝 ', color = 'LspDiagnosticsDefaultError' })
sign({ name = 'DiagnosticSignWarn',  text = '󱚟 ', color = 'Function' })
sign({ name = 'DiagnosticSignInfo',  text = '󰚩 ', color = 'Comment' })
sign({ name = 'DiagnosticSignHint',  text = '󱜙 ', color = 'Keyword' })


lsp.set_server_config({
    single_file_support = false,
    capabilities = capabilities,
    flags = {
        debounce_text_changes = 150,
    },
})

lsp.setup()


local cmp = require('cmp')

local cmp_kinds = {
  Text = '󰈍 ',
  Method = ' ',
  Function = '󰘧 ',
  Constructor = '󰣪 ',
  Field = '󰂡 ',
  Variable = '󰀫 ',
  Class = '󱙧 ',
  Interface = '󰀴 ',
  Module = '󰕳 ',
  Property = '󰏉 ',
  Unit = '󰿗 ',
  Value = '󰊦 ',
  Enum = '󱂟 ',
  Keyword = '󰇈 ',
  Snippet = '󱦤 ',
  Color = '󰢵 ',
  File = '󰎞 ',
  Reference = '󱇵 ',
  Folder = '󰹕 ',
  EnumMember = ' ',
  Constant = '󱃮 ',
  Struct = '󱢇 ',
  Event = '󱅗 ',
  Operator = '󰘫 ',
}

cmp.setup({
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end,
    },
    window = {
        completion = {
            winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
            col_offset = -3,
            side_padding = 0,
        },
    },
    formatting = {
        fields = { "kind", "abbr", "menu" }, 
        format = function(entry, vim_item)
            local kind = require("lspkind").cmp_format({ mode = "symbol_text", maxwidth = 50 })(entry, vim_item)
            local strings = vim.split(kind.kind, "%s", { trimempty = true })
            kind.kind = cmp_kinds[strings[2]] or stirngs[1]
            kind.menu = "    (" .. (strings[2] or "") .. ")"

            return kind
        end,
    },
    mapping = {
        ['<S-Tab>'] = cmp.mapping.select_prev_item(),
        ['<Tab>'] = cmp.mapping.select_next_item(),
        ['<C-n>'] = cmp.mapping.scroll_docs(-4),
        ['<C-t>'] = cmp.mapping.scroll_docs(4),
        ['<C-e>'] = cmp.mapping.close(),
        ['<CR>'] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        }),
    },
    sources = {
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        { name = 'buffer' },
        { name = 'path' },
    }
})


-- Customization for Pmenu
vim.api.nvim_set_hl(0, "CmpItemAbbrDeprecated", { fg = "#7E8294", bg = "NONE", strikethrough = true })
vim.api.nvim_set_hl(0, "CmpItemAbbrMatch", { fg = "#82AAFF", bg = "NONE", bold = true })
vim.api.nvim_set_hl(0, "CmpItemAbbrMatchFuzzy", { fg = "#82AAFF", bg = "NONE", bold = true })
vim.api.nvim_set_hl(0, "CmpItemMenu", { fg = "#C792EA", bg = "NONE", italic = true })

vim.api.nvim_set_hl(0, "CmpItemKindField", { fg = "#2a79b5", bg = "NONE" })
vim.api.nvim_set_hl(0, "CmpItemKindProperty", { fg = "#2a79b5", bg = "NONE" })
vim.api.nvim_set_hl(0, "CmpItemKindEvent", { fg = "#2ab5b0", bg = "NONE" })

vim.api.nvim_set_hl(0, "CmpItemKindText", { fg = "#2a79b5", bg = "NONE" })
vim.api.nvim_set_hl(0, "CmpItemKindEnum", { fg = "#c70aa4", bg = "NONE" })
vim.api.nvim_set_hl(0, "CmpItemKindKeyword", { fg = "#7e0ac7", bg = "NONE" })

vim.api.nvim_set_hl(0, "CmpItemKindConstant", { fg = "#2a79b5", bg = "NONE" })
vim.api.nvim_set_hl(0, "CmpItemKindConstructor", { fg = "#130ac7", bg = "NONE" })
vim.api.nvim_set_hl(0, "CmpItemKindReference", { fg = "#130ac7", bg = "NONE" })

vim.api.nvim_set_hl(0, "CmpItemKindFunction", { fg = "#130ac7", bg = "NONE" })
vim.api.nvim_set_hl(0, "CmpItemKindStruct", { fg = "#f71e95", bg = "NONE" })
vim.api.nvim_set_hl(0, "CmpItemKindClass", { fg = "#c70a6c", bg = "NONE" })
vim.api.nvim_set_hl(0, "CmpItemKindModule", { fg = "#870036", bg = "NONE" })
vim.api.nvim_set_hl(0, "CmpItemKindOperator", { fg = "#0f1e5c", bg = "NONE" })

vim.api.nvim_set_hl(0, "CmpItemKindVariable", { fg = "#00874f", bg = "NONE" })
vim.api.nvim_set_hl(0, "CmpItemKindFile", { fg = "#8cfacc", bg = "NONE" })

vim.api.nvim_set_hl(0, "CmpItemKindUnit", { fg = "#8cf4fa", bg = "NONE" })
vim.api.nvim_set_hl(0, "CmpItemKindSnippet", { fg = "#57a7f2", bg = "NONE" })
vim.api.nvim_set_hl(0, "CmpItemKindFolder", { fg =  "#f25788", bg = "NONE" })

vim.api.nvim_set_hl(0, "CmpItemKindMethod", { fg = "#130ac7", bg = "NONE" })
vim.api.nvim_set_hl(0, "CmpItemKindValue", { fg = "#DDE5F5", bg = "NONE" })
vim.api.nvim_set_hl(0, "CmpItemKindEnumMember", { fg = "#c70aa4", bg = "NONE" })

vim.api.nvim_set_hl(0, "CmpItemKindInterface", { fg = "#c70a6c", bg = "NONE" })
vim.api.nvim_set_hl(0, "CmpItemKindColor", { fg = "#4903fc", bg = "NONE" })
vim.api.nvim_set_hl(0, "CmpItemKindTypeParameter", { fg = "#fc03db", bg = "NONE" })


