local wk = require('which-key')

-- make which-key commands for git commands:
wk.register({
    ["="] = {
        -- :Git 
        name = "Git",
        ["="] = { "<cmd>Git<CR>", "Git" },
        ["+"] = { "<cmd>Git push<CR>", "Push" },
        r = { "<cmd>Git rebase<CR>", "Rebase" },
        l = { "<cmd>Git pull<CR>", "Pull" },
        ["!"] = { "<cmd>Git rebase --abort<CR>", "Abort Rebase" },
    }
}, { prefix = "<leader>" })
