require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all"
  ensure_installed = { 
      "c", "lua", "rust", 
      "go", "gomod",
      "javascript", "typescript", "tsx",
      "vim", "c_sharp", "cpp",
      "help"
  },
  sync_install = false,
  auto_install = true,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
}
