require'nvim-treesitter.configs'.setup {
  ensure_installed = {
    "javascript",
    "typescript",
    "tsx",
    "dockerfile",
    "lua",
    "python",
    "rust",
    "c_sharp",
    "markdown",
    "markdown_inline"
  },
  sync_install = false,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },

}
