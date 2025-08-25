# Agent Guidelines for Neovim Configuration

## Build/Test Commands
- **Neovim reload**: `:source %` or restart nvim
- **Plugin management**: `:Lazy` (update/install plugins)
- **Treesitter update**: `:TSUpdate`
- **LSP restart**: `:LspRestart`
- **Testing (Rust)**: `:RustLsp testables` or `<space>rt` for single test
- **Testing (.NET)**: Uses neotest-dotnet adapter via `:Neotest`

## Code Style Guidelines
- **Indentation**: 4 spaces, no tabs
- **Comments**: Use `--` for single line, start with capital letter
- **Tables**: Use snake_case for keys, trailing commas preferred
- **Functions**: snake_case naming, local functions preferred
- **Imports**: Group at top, `local var = require('module')` format
- **Plugin config**: Use `opts` table for simple config, `config` function for complex setup
- **Keymaps**: Use `vim.keymap.set()` or which-key groups with descriptive names
- **Leader key**: Main leader is `-`, space leaders for groups (`<space>f` for telescope)
- **Error handling**: Minimal, rely on Neovim's built-in handling
- **File structure**: Keep plugins in separate files under `lua/plugins/`
- **Custom movement**: Uses htns instead of hjkl (unique to this config)

## Notes
- This is a personal Neovim configuration, not a software project
- No formal linting/testing beyond Neovim's built-in Lua checking
- Plugin lazy-loading is handled by lazy.nvim automatically