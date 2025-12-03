local lsp = require('lsp-zero')

lsp.preset('recommended')

lsp.ensure_installed({
  'html',
  'emmet_ls',
  'stylelint_lsp',
  'eslint',
  'biome',
  'cssls',
  'cssmodules_ls',
  'css_variables',
  'somesass_ls'
})

-- Fix Undefined global 'vim'
lsp.configure('lua-language-server', {
  settings = {
    Lua = {
      diagnostics = {
        globals = { 'vim' }
      }
    }
  }
})

local lspconfig = require('lspconfig')
local util = lspconfig.util

-- Define ESLint configuration file patterns
local eslint_config_files = {
  '.eslintrc',
  '.eslintrc.json',
  '.eslintrc.js',
  '.eslintrc.cjs',
  '.eslintrc.yaml',
  '.eslintrc.yml',
  'eslint.config.js',
  'package.json', -- Contains ESLint config in "eslintConfig" field
}

-- Helper function to check if a directory contains ESLint config
local function has_eslint_config(dir)
  for _, file in ipairs(eslint_config_files) do
    if vim.loop.fs_stat(dir .. '/' .. file) then
      return true
    end
  end
  return false
end

lspconfig.eslint.setup({
  root_dir = function(fname)
    -- 1. Try to find ESLint config in current file's ancestry
    local eslint_root = util.root_pattern(eslint_config_files)(fname)
    if eslint_root then
      return eslint_root
    end

    -- 2. Fall back to Git repository root (monorepo root)
    local git_root = util.find_git_ancestor(fname)
    -- root_dir = require('lspconfig.util').find_git_ancestor,
    if git_root and has_eslint_config(git_root) then
      return git_root
    end

    -- 3. Final fallback: user's home directory
    return vim.loop.os_homedir()
  end,
})




lsp.configure('emmet_ls', {
  settings = {
    filetypes = { 'html', 'javascript', 'javascriptreact', 'typescript', 'typescriptreact', 'css', 'sass', 'scss', 'less' },
  }
})

lsp.configure('stylelint_lsp', {
  settings = {
    stylelintplus = {
      autoFixOnFormat = true
    }
  }
})



local cmp = require('cmp')
local ls = require('luasnip')
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = cmp.mapping.preset.insert({
  ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
  ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
  ['<CR>'] = cmp.mapping.confirm({ select = true }),
  ["<C-Space>"] = cmp.mapping.complete(),
})

-- local cmp_sources = cmp.get_config()
--
-- table.insert(cmp_sources.sources, {
--    name = 'codeium',
-- })

cmp_mappings['<Tab>'] = nil
cmp_mappings['<S-Tab>'] = nil

cmp.setup({
  mapping = cmp_mappings,
  -- sources = cmp_sources,
})

lsp.setup()

vim.diagnostic.config({
  virtual_text = true
})

-- vim.o.updatetime = 250
-- vim.cmd [[autocmd! CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus = false})]]
