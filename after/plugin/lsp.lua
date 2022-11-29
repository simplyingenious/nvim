-- Set up nvim-cmp.
local cmp = require'cmp'

cmp.setup({
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
      require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
    end,
  },
  window = {
    -- completion = cmp.config.window.bordered(),
    -- documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
    ['<C-d>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'buffer' },
  })
})


local null_ls = require("null-ls")
null_ls.setup({
  on_attach = function(client, bufnr)
    if client.server_capabilities.documentFormattingProvider then
      vim.cmd("nnoremap <silent><buffer> <Leader>f :lua vim.lsp.buf.format {async = true}<CR>")

      -- format on save
      vim.cmd("autocmd BufWritePost <buffer> lua vim.lsp.buf.format {async = true}")
    end

    if client.server_capabilities.documentRangeFormattingProvider then
      vim.cmd("xnoremap <silent><buffer> <Leader>f :lua vim.lsp.buf.range_formatting({})<CR>")
    end
  end,
})


local prettier = require("prettier")
prettier.setup({
  bin = 'prettierd',
  filetypes = {
    "graphql",
    "html",
    "javascript",
    "javascriptreact",
    "json",
    -- "css",
    -- "less",
    -- "scss",
    "markdown",
    "typescript",
    "typescriptreact",
    "yaml",
  },
})

local lspconfig = require'lspconfig'
lspconfig.stylelint_lsp.setup{
  settings = {
    stylelintplus = {
      autoFixOnSave = true,
      autoFixOnFormat = true
    }
  }
}

lspconfig.emmet_ls.setup({
  -- on_attach = on_attach,
  -- capabilities = capabilities,
  filetypes = { 'html', 'javascript', 'javascriptreact', 'css', 'sass', 'scss', 'less' },
  -- init_options = {
  --   html = {
  --     options = {
  --       -- For possible options, see: https://github.com/emmetio/emmet/blob/master/src/config.ts#L79-L267
  --       ["bem.enabled"] = true,
  --     },
  --   },
  -- }
})
