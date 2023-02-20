local lsp = require('lsp-zero')

lsp.preset('recommended')

lsp.ensure_installed({
    'html',
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

lsp.configure('stylelint_lsp', {
    settings = {
        stylelintplus = {
            autoFixOnFormat = true
        }
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


-- local null_ls = require("null-ls")
-- local null_opts = lsp.build_options('null-ls', {})
-- local formatting = null_ls.builtins.formatting
-- local code_actions = null_ls.builtins.code_actions
-- local diagnostics = null_ls.builtins.diagnostics
--
-- null_ls.setup({
--     debug = true,
--     sources = {
--         code_actions.eslint_d,
--         formatting.eslint_d,
--         diagnostics.eslint_d,
--         -- diagnostics.stylelint,
--         formatting.prettierd,
--         -- formatting.stylelint,
--     },
--     on_attach = function(client, bufnr)
--       null_opts.on_attach(client, bufnr)
--       if client.server_capabilities.documentFormattingProvider then
--         vim.keymap.set('n', '<leader>f', ':lua vim.lsp.buf.format({ async = true })<CR>',
--             { silent = true, buffer = true })
--       end
--     end,
-- })


vim.diagnostic.config({
    virtual_text = true
})
