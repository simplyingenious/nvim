local lsp = require('lsp-zero')

lsp.preset('recommended')

lsp.ensure_installed({
  'html',
  'tsserver',
  'emmet_ls',
  'stylelint_lsp',
  'eslint',
  'biome',
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

-- lsp.configure('eslint', {
--   settings = {
--     filetypes = { 'html', 'javascript', 'javascriptreact' },
--   }
-- })

lsp.configure('emmet_ls', {
  settings = {
    filetypes = { 'html', 'javascript', 'javascriptreact', 'css', 'sass', 'scss', 'less' },
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

cmp_mappings['<Tab>'] = nil
cmp_mappings['<S-Tab>'] = nil

cmp.setup({
  mapping = cmp_mappings,
})


lsp.setup()


vim.diagnostic.config({
  virtual_text = true
})

-- vim.o.updatetime = 250
-- vim.cmd [[autocmd! CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus = false})]]
