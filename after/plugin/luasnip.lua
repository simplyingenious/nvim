local ls = require('luasnip')
-- some shorthands...
local snip = ls.snippet
local node = ls.snippet_node
local text = ls.text_node
local insert = ls.insert_node
local func = ls.function_node
local choice = ls.choice_node
local dynamicn = ls.dynamic_node

vim.keymap.set({ 'i', 's' }, '<C-x>', function()
	ls.expand_or_jump()
end, { silent = true })
vim.keymap.set({ 'i', 's' }, '<C-n>', function()
	ls.change_choice(1)
end, { silent = true })
vim.keymap.set({ 'i', 's' }, '<C-p>', function()
	ls.change_choice(-1)
end, { silent = true })
vim.keymap.set({ 'i', 's' }, '<C-l>', function()
	ls.jump(1)
end, { silent = true })
vim.keymap.set({ 'i', 's' }, '<C-j>', function()
	ls.jump(-1)
end, { silent = true })

ls.add_snippets(nil, {
	javascript = {
		snip({
			trig = 'ci',
			name = 'Console Info',
			desc = 'console.info',
		}, {
			text('console.info('),
			insert(1),
			text(')'),
		}),
	},
	javascriptreact = {
		snip({
			trig = 'ci',
			name = 'Console Info',
			desc = 'console.info',
		}, {
			text('console.info('),
			insert(1),
			text(')'),
		}),
	},
	typescript = {
		snip({
			trig = 'ci',
			name = 'Console Info',
			desc = 'console.info',
		}, {
			text('console.info('),
			insert(1),
			text(')'),
		}),
	},
	typescriptreact = {
		snip({
			trig = 'ci',
			name = 'Console Info',
			desc = 'console.info',
		}, {
			text('console.info('),
			insert(1),
			text(')'),
		}),
	},
})
