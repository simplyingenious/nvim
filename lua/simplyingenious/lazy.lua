require('lazy').setup({
	-- Colorschemes
	{
		'EdenEast/nightfox.nvim',
		lazy = false, -- make sure we load this during startup if it is your main colorscheme
		priority = 1000, -- make sure to load this before all the other start plugins
		name = 'nightfox',
		config = function()
			-- Available variants: dayfox, nightfox, dawnfox, duskfox, nordfox, terafox, carbonfox
			-- Use Theme() function in after/plugin/color.lua to set colorscheme
			vim.cmd([[colorscheme carbonfox]])
		end,
	},
	-- File finding
	{ 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
	{
		'nvim-telescope/telescope.nvim',
		branch = 'master',
		dependencies = { 'nvim-lua/plenary.nvim' },
		opts = function()
			local builtin = require('telescope.builtin')
			-- local open_with_trouble
			-- local ok, trouble_telescope = pcall(require, 'trouble.sources.telescope')
			-- if ok then
			-- 	open_with_trouble = trouble_telescope.open
			-- end
			local actions = require('telescope.actions')

			vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
			vim.keymap.set('n', '<C-p>', builtin.git_files, {})
			vim.keymap.set('n', '<leader>pb', function()
				builtin.buffers({ sort_lastused = true })
			end)
			vim.keymap.set('n', '<leader>pw', function()
				builtin.grep_string({ search = vim.fn.expand('<cword>') })
			end)
			vim.keymap.set('n', '<leader>psl', function()
				builtin.live_grep()
			end)
			-- vim.keymap.set('n', '<leader>ps', function()
			--   builtin.grep_string()
			-- end)
			vim.keymap.set('n', '<leader>ps', function()
				builtin.grep_string({ search = vim.fn.input('Grep ❯ ') })
			end)

			require('telescope').setup({
				-- defaults = {
				-- 	mappings = {
				-- 		i = open_with_trouble and { ['<C-t>'] = open_with_trouble } or {},
				-- 		n = open_with_trouble and { ['<C-t>'] = open_with_trouble } or {},
				-- 	},
				-- },
				pickers = {
					buffers = {
						mappings = {
							n = {
								['bd'] = actions.delete_buffer + actions.move_to_top,
							},
						},
					},
				},
				extensions = {
					fzf = {
						fuzzy = true, -- false will only do exact matching
						override_generic_sorter = true, -- override the generic sorter
						override_file_sorter = true, -- override the file sorter
						case_mode = 'smart_case', -- or 'ignore_case' or 'respect_case'
						-- the default case_mode is 'smart_case'
					},
				},
			})
			require('telescope').load_extension('fzf')
		end,
	},

	-- Syntax highlighting
	{
		'nvim-treesitter/nvim-treesitter',
		dependencies = {
			'JoosepAlviste/nvim-ts-context-commentstring',
		},
		build = ':TSUpdate',
		config = function()
			local configs = require('nvim-treesitter.config')

			configs.setup({
				ensure_installed = { 'javascript', 'typescript', 'css', 'lua', 'vim' },

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

				require('nvim-ts-autotag').setup(),

				autopairs = {
					enable = true,
				},
			})
		end,
	},
	{ 'nvim-treesitter/nvim-treesitter-context', opts = {} },

	-- Git integration (commented for minimal setup)
	{ 'tpope/vim-fugitive' },
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
				map({ 'n', 'v' }, ']c', function()
					if vim.wo.diff then
						return ']c'
					end
					vim.schedule(function()
						gs.next_hunk()
					end)
					return '<Ignore>'
				end, { expr = true, desc = 'Jump to next hunk' })

				map({ 'n', 'v' }, '[c', function()
					if vim.wo.diff then
						return '[c'
					end
					vim.schedule(function()
						gs.prev_hunk()
					end)
					return '<Ignore>'
				end, { expr = true, desc = 'Jump to previous hunk' })

				map('n', '<leader>hb', function()
					gs.blame_line({ full = false })
				end, { desc = 'git blame line' })
				map('n', '<leader>hd', gs.diffthis, { desc = 'git diff against index' })
				map('n', '<leader>hD', function()
					gs.diffthis('~')
				end, { desc = 'git diff against last commit' })

				-- Toggles
				map('n', '<leader>tb', gs.toggle_current_line_blame, { desc = 'toggle git blame line' })
				map('n', '<leader>td', gs.toggle_deleted, { desc = 'toggle git show deleted' })
			end,
		},
	},

	-- Code assistants (commented for minimal setup)
	{
		'Exafunction/windsurf.vim',
		config = function()
			-- Change '<C-g>' here to any keycode you like.
			vim.keymap.set('i', '<C-g>', function()
				return vim.fn['codeium#Accept']()
			end, { expr = true, silent = true })
			vim.keymap.set('i', '<c-;>', function()
				return vim.fn['codeium#CycleCompletions'](1)
			end, { expr = true, silent = true })
			vim.keymap.set('i', '<c-,>', function()
				return vim.fn['codeium#CycleCompletions'](-1)
			end, { expr = true, silent = true })
			vim.keymap.set('i', '<c-x>', function()
				return vim.fn['codeium#Clear']()
			end, { expr = true, silent = true })
		end,
	},

	-- Autocompletion
	{
		'hrsh7th/nvim-cmp',
		event = { 'InsertEnter', 'CmdlineEnter' },
	},
	{ 'hrsh7th/cmp-nvim-lsp' },
	{ 'hrsh7th/cmp-buffer' },
	{ 'hrsh7th/cmp-path' },

	-- Essential utilities
	{ 'windwp/nvim-autopairs', opts = {} },
	{ 'windwp/nvim-ts-autotag', opts = {} },
	{ 'kylechui/nvim-surround', opts = {} },
	{
		'numToStr/Comment.nvim',
		opts = function()
			local ok, comment = pcall(require, 'Comment')
			if not ok then
				vim.notify('Comment.nvim not found', vim.log.levels.WARN)
				return
			end

			local pre_hook = nil
			local ok_commentstring, ts_context = pcall(require, 'ts_context_commentstring.integrations.comment_nvim')
			if ok_commentstring then
				pre_hook = ts_context.create_pre_hook()
			end

			comment.setup({
				pre_hook = pre_hook,
			})
		end,
		lazy = false,
	},

	-- File management
	{
		'stevearc/oil.nvim',
		---@module 'oil'
		---@type oil.SetupOpts
		opts = {},
		-- Optional dependencies
		dependencies = { { 'echasnovski/mini.icons', opts = {} } },
		-- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
		-- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
		lazy = false,
	},

	-- Multi-cursor (commented for minimal setup)
	{
		'mg979/vim-visual-multi',
		event = { 'BufRead', 'BufNewFile' },
	},
})
