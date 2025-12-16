# AGENTS.md

## Commands
This is a Neovim configuration - no traditional build/test/lint commands. Use these for development:

- Lint/format Lua: `stylua --check .` / `stylua .`
- Check config: `nvim --headless -c "lua print('Config valid')" -c "q"`
- Test specific features: open test files with `nvim test_file.lua`

## Code Style Guidelines

### Lua Conventions
- Use `local` for all variables unless global is required
- Indentation: 2 spaces (configured in vim settings)
- String quotes: single quotes for consistency
- Table literals: use `{}` syntax, prefer comma separators

### Neovim API
- Use `vim.keymap.set()` over `vim.api.nvim_set_keymap()`
- Prefer `vim.opt` over `vim.cmd('set ...')`
- Use `vim.fn` for vimscript functions
- Lazy.nvim: use `opts = function()` pattern for complex configs

### File Organization
- `lua/simplyingenious/` for all modules
- `after/plugin/` for plugin-specific configs
- Keep keymaps in `remap.lua`, settings in `set.lua`
- Module structure: `require('simplyingenious.module')`

### Error Handling
- Use `pcall()` for external command calls
- Check if plugins exist before configuring
- Validate vim options before setting
- Use conditional loading for optional features

### Naming
- Files: lowercase with underscores (`file_config.lua`)
- Variables: `snake_case` for Lua, `camelCase` for some API calls
- Functions: descriptive names, avoid single letters
- Keymaps: use `<leader>` prefix for user mappings

### Performance
- Use lazy loading where possible
- Defer expensive operations to `BufRead`/`BufNewFile`
- Avoid global variables, use module locals
- Prefer built-in Neovim functions over external calls