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

  { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.2',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = function()
      local builtin = require('telescope.builtin')
      local trouble = require("trouble.providers.telescope")
      local actions = require "telescope.actions"

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
      -- vim.keymap.set('n', '<leader>ps', function()
      --   builtin.grep_string()
      -- end)
      vim.keymap.set('n', '<leader>ps', function()
        builtin.grep_string({ search = vim.fn.input("Grep ❯ ") })
      end)

      require('telescope').setup {
        defaults = {
          mappings = {
            i = { ["<C-t>"] = trouble.open_with_trouble },
            n = { ["<C-t>"] = trouble.open_with_trouble },
          }
        },
        pickers = {
          buffers = {
            mappings = {
              n = {
                ["bd"] = actions.delete_buffer + actions.move_to_top,
              },
              i = {
                ["<C-d>"] = actions.delete_buffer + actions.move_to_top,
              }
            }
          }
        },
        extensions = {
          fzf = {
            fuzzy = true,                   -- false will only do exact matching
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true,    -- override the file sorter
            case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
            -- the default case_mode is "smart_case"
          }
        }
      }
      require('telescope').load_extension('fzf')
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
        ensure_installed = { "javascript", "typescript", "css", "lua", "vim" },

        -- Install parsers synchronously (only applied to `ensure_installed`)
        sync_install = false,

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

  { 'tpope/vim-fugitive' },

  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v1.x',
    dependencies = {
      -- LSP Support
      { 'neovim/nvim-lspconfig' },             -- Required
      { 'williamboman/mason.nvim' },           -- Optional
      { 'williamboman/mason-lspconfig.nvim' }, -- Optional

      -- Snippets
      {
        'L3MON4D3/LuaSnip',
        version = "v2.*",
      },                                  -- Required
      { 'rafamadriz/friendly-snippets' }, -- Optional

      -- Autocompletion
      {
        'hrsh7th/nvim-cmp',
        event = { "InsertEnter", "CmdlineEnter" }
      },                              -- Required
      { 'hrsh7th/cmp-nvim-lsp' },     -- Required
      { 'hrsh7th/cmp-buffer' },       -- Optional
      { 'hrsh7th/cmp-path' },         -- Optional
      { 'saadparwaiz1/cmp_luasnip' }, -- Optional
      { 'hrsh7th/cmp-nvim-lua' },     -- Optional

      -- Additional Plugins
    }
  },

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
  {
    'lewis6991/gitsigns.nvim',
    opts = {
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map({ "n", "v" }, "]c", function()
          if vim.wo.diff then
            return "]c"
          end
          vim.schedule(function()
            gs.next_hunk()
          end)
          return "<Ignore>"
        end, { expr = true, desc = "Jump to next hunk" })

        map({ "n", "v" }, "[c", function()
          if vim.wo.diff then
            return "[c"
          end
          vim.schedule(function()
            gs.prev_hunk()
          end)
          return "<Ignore>"
        end, { expr = true, desc = "Jump to previous hunk" })

        -- Actions
        -- visual mode
        -- map("v", "<leader>hs", function()
        -- 	gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
        -- end, { desc = "stage git hunk" })
        -- map("v", "<leader>hr", function()
        -- 	gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
        -- end, { desc = "reset git hunk" })
        -- normal mode
        -- map("n", "<leader>hs", gs.stage_hunk, { desc = "git stage hunk" })
        -- map("n", "<leader>hr", gs.reset_hunk, { desc = "git reset hunk" })
        -- map("n", "<leader>hS", gs.stage_buffer, { desc = "git Stage buffer" })
        -- map("n", "<leader>hu", gs.undo_stage_hunk, { desc = "undo stage hunk" })
        -- map("n", "<leader>hR", gs.reset_buffer, { desc = "git Reset buffer" })
        -- map("n", "<leader>hp", gs.preview_hunk, { desc = "preview git hunk" })
        map("n", "<leader>hb", function()
          gs.blame_line({ full = false })
        end, { desc = "git blame line" })
        map("n", "<leader>hd", gs.diffthis, { desc = "git diff against index" })
        map("n", "<leader>hD", function()
          gs.diffthis("~")
        end, { desc = "git diff against last commit" })

        -- Toggles
        map("n", "<leader>tb", gs.toggle_current_line_blame, { desc = "toggle git blame line" })
        map("n", "<leader>td", gs.toggle_deleted, { desc = "toggle git show deleted" })
      end,
    }
  },
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {},
  },
  {
    'norcalli/nvim-colorizer.lua',
    event = { "BufRead", "BufNewFile" },
    config = function()
      require 'colorizer'.setup()
    end
  },
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {}
  },
  -- { 'RRethy/vim-illuminate', opts = {} },
})
