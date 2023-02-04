local status_ok, npairs = pcall(require, "nvim-autopairs")
if not status_ok then 
    return 
end

npairs.setup {
    check_ts = true,
    ts_config = {
        lua = { "string", "template_string" },
        javascript = { "string", "template_string" },
        typescript = { "string", "template_string" },
    },
    disable_filetype = { "TelescopePrompt" },
}

-- If you want insert `(` after select function or method item
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
local cmp = require('cmp')
cmp.event:on(
  'confirm_done',
  cmp_autopairs.on_confirm_done()
)
