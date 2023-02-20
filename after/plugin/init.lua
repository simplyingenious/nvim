require("nvim-autopairs").setup {}
require('nvim-surround').setup()

require('gitsigns').setup({
  -- current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
})

require("colorizer").setup()

require('Comment').setup {
  pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
}
