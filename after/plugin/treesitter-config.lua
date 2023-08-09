require'nvim-treesitter.configs'.setup {
  ensure_installed = {
    "help",
    "javascript",
    "typescript",
    "tsx",
    "dockerfile",
    "lua",
    "python",
    "rust",
    "csharp",
  },
  sync_install = false,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },

}
