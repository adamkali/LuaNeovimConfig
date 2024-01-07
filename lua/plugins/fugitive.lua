return {
    "tpope/vim-fugitive",
    opt = true,
    cmd = {
        "G", "Git", "Gdiffsplit", "Gvdiffsplit", "Gedit", "Gsplit",
        "Gread", "Gwrite", "Ggrep", "Glgrep", "Gmove",
        "Gdelete", "Gremove", "Gbrowse",
    },
    keys = {
        { '-tt', "<cmd>Git<cr>", desc ="Open Git" },
        { '-tn', "<cmd>Git pull<cr>", desc = "Pull Git" },
        { '-ts', "<cmd>Gdiffsplit", desc ="Git Diff" }
    }
}
