local lsp = require('lsp-zero')

lsp.preset('recommended')

lsp.ensure_installed({
  'html',
  'cssls',
  'cssmodules_ls',
  'tsserver',
  'emmet_ls',
  'stylelint_lsp'
})

lsp.configure('emmet_ls', {
  settings = {
    filetypes = { 'html', 'javascript', 'javascriptreact', 'css', 'sass', 'scss', 'less' },
  }
})


local cmp = require('cmp')
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings({
  ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
  ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
  ['<CR>'] = cmp.mapping.confirm({ select = true }),
  ["<C-Space>"] = cmp.mapping.complete(),
})

cmp_mappings['<Tab>'] = nil
cmp_mappings['<S-Tab>'] = nil

lsp.setup_nvim_cmp({
  mapping = cmp_mappings
})


lsp.setup()


vim.diagnostic.config({
  virtual_text = true
})
