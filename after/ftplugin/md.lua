local wk = require('which-key').add
local obsidian_leader =  "<M-l>"
wk {
    { obsidian_leader, expr = false, group = "Quickfix", nowait = false, remap = false, icon = { icon = "󰓅", hl = "Function" } },
    { obsidian_leader .. 'd', '<cmd>:ObsidianFollowLink<CR>',        desc = 'Go To' },
    { obsidian_leader .. 'v', '<cmd>:ObsidianFollowLink vsplit<CR>', desc = 'Split vertically' },
    { obsidian_leader .. 'V', '<cmd>:ObsidianFollowLink hsplit<CR>', desc = 'Split horizontally' },
    { obsidian_leader .. 'b', '<cmd>:ObsidianBacklinks<CR>',         desc = 'Show Back Links' },
    { obsidian_leader .. 't', '<cmd>:ObsidianToday<CR>',             desc = 'Open Today' },
    { obsidian_leader .. 'N', '<cmd>:ObsidianYesterday<CR>',         desc = 'Open Yesterday' },
    { obsidian_leader .. 'n', '<cmd>:ObsidianTomorrow<CR>',          desc = 'Open Yesterday' },
    { obsidian_leader .. 'T', '<cmd>:ObsidianTemplate<CR>',          desc = 'Use Template' },
    { obsidian_leader .. 'h', '<cmd>:ObsidianSearch<CR>',            desc = 'Search' },
}
