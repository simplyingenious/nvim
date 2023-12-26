require("lazy").setup({
  {
    "rose-pine/neovim",
    lazy = false,    -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    name = 'rose-pine',
    config = function()
      vim.cmd([[colorscheme rose-pine]])
    end,
  },

  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.2',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = function()
      local builtin = require('telescope.builtin')
      vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
      vim.keymap.set('n', '<C-p>', builtin.git_files, {})
      vim.keymap.set('n', '<leader>pb', function()
        builtin.buffers({ sort_lastused = true })
      end)
      vim.keymap.set('n', '<leader>pw', function()
        builtin.grep_string({ search = vim.fn.expand("<cword>") })
      end)
      vim.keymap.set('n', '<leader>psl', function()
        builtin.live_grep()
      end)
      vim.keymap.set('n', '<leader>ps', function()
        builtin.grep_string({ search = vim.fn.input("Grep ❯ ") })
      end)
    end
  },

  {
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'JoosepAlviste/nvim-ts-context-commentstring',
    },
    build = ':TSUpdate',
    config = function()
      local configs = require("nvim-treesitter.configs")

      configs.setup({
        -- A list of parser names, or "all" (the four listed parsers should always be installed)
        -- ensure_installed = { "javascript", "typescript", "css", "lua", "vim" },

        -- Install parsers synchronously (only applied to `ensure_installed`)
        -- sync_install = false,

        -- Automatically install missing parsers when entering buffer
        -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
        auto_install = true,

        highlight = {
          -- `false` will disable the whole extension
          enable = true,

          -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
          -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
          -- Using this option may slow down your editor, and you may see some duplicate highlights.
          -- Instead of true it can also be a list of languages
          additional_vim_regex_highlighting = false,
        },

        autotag = {
          enable = true,
        },

        autopairs = {
          enable = true,
        },
      })
    end
  },

  -- { 'tpope/vim-fugitive' },

  {
    'JoosepAlviste/nvim-ts-context-commentstring',
    opts = function()
      vim.g.skip_ts_context_commentstring_module = true
    end
  },
  { 'windwp/nvim-autopairs',  opts = {} },
  { 'windwp/nvim-ts-autotag', opts = {} },
  { 'kylechui/nvim-surround', opts = {} },
  {
    'numToStr/Comment.nvim',
    opts = function()
      require('Comment').setup {
        pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
      }
    end,
    lazy = false
  },
})
