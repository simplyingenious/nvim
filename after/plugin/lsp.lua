-- Global capabilities
local capabilities
local ok, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
if not ok then
	vim.notify('cmp_nvim_lsp not found, LSP capabilities will be limited', vim.log.levels.WARN)
	capabilities = vim.lsp.protocol.make_client_capabilities()
else
	capabilities = cmp_nvim_lsp.default_capabilities()
end

-- Global on_attach function for all LSP servers
local function on_attach(client, bufnr)
	-- LSP keymaps
	vim.keymap.set('n', '<leader>f', vim.lsp.buf.format, { buffer = bufnr, desc = 'Format buffer' })
end

-- Set global defaults for ALL LSP servers
vim.lsp.config('*', {
	capabilities = capabilities,
	on_attach = on_attach,
})

-- Define ESLint configuration file patterns
local eslint_config_files = {
	'.eslintrc',
	'.eslintrc.json',
	'.eslintrc.js',
	'.eslintrc.cjs',
	'.eslintrc.yaml',
	'.eslintrc.yml',
	'eslint.config.js',
	'package.json', -- Contains ESLint config in 'eslintConfig' field
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

vim.lsp.config('lua_ls', {
	settings = {
		Lua = {
			diagnostics = {
				globals = { 'vim' },
			},
		},
	},
})

vim.lsp.config('eslint', {
	root_dir = function(fname)
		if not fname or type(fname) ~= 'string' then
			return vim.loop.os_homedir()
		end

		-- 1. Try to find ESLint config in current file's ancestry
		local eslint_files = vim.fs.find(eslint_config_files, { upward = true, path = fname })
		if eslint_files and #eslint_files > 0 then
			local eslint_root = vim.fs.dirname(eslint_files[1])
			if eslint_root then
				return eslint_root
			end
		end

		-- 2. Fall back to Git repository root (monorepo root)
		local git_files = vim.fs.find({ '.git' }, { upward = true, path = fname })
		if git_files and #git_files > 0 then
			local git_root = vim.fs.dirname(git_files[1])
			if git_root and has_eslint_config(git_root) then
				return git_root
			end
		end

		-- 3. Final fallback: user's home directory
		return vim.loop.os_homedir()
	end,
})

vim.lsp.config('emmet_ls', {
	filetypes = {
		'html',
		'javascript',
		'javascriptreact',
		'typescript',
		'typescriptreact',
		'css',
		'sass',
		'scss',
		'less',
	},
})

vim.lsp.config('stylelint_lsp', {
	settings = {
		stylelintplus = {
			autoFixOnFormat = true,
		},
	},
})

-- Setup servers without special config (they inherit global defaults)
vim.lsp.config('html', {})
vim.lsp.config('biome', {})
vim.lsp.config('cssls', {})
vim.lsp.config('cssmodules_ls', {})
vim.lsp.config('css_variables', {})
vim.lsp.config('somesass_ls', {})

-- Configure ts_ls (TypeScript language server) before enabling
vim.lsp.config('ts_ls', {
	filetypes = { 'typescript', 'typescriptreact', 'javascript', 'javascriptreact' },
})

-- Enable the servers
vim.lsp.enable('lua_ls')
vim.lsp.enable('eslint')
vim.lsp.enable('emmet_ls')
vim.lsp.enable('stylelint_lsp')
vim.lsp.enable('html')
vim.lsp.enable('biome')
vim.lsp.enable('cssls')
vim.lsp.enable('cssmodules_ls')
vim.lsp.enable('css_variables')
vim.lsp.enable('somesass_ls')
vim.lsp.enable('ts_ls')

local cmp = require('cmp')
local ls = require('luasnip')
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = cmp.mapping.preset.insert({
	['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
	['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
	['<CR>'] = cmp.mapping.confirm({ select = true }),
	['<C-Space>'] = cmp.mapping.complete(),
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
	sources = {
		{ name = 'nvim_lsp' },
		{ name = 'luasnip' },
		{ name = 'buffer' },
		{ name = 'path' },
		{ name = 'nvim_lua' },
	},
})

vim.diagnostic.config({
	virtual_text = true,
})

-- vim.o.updatetime = 250
-- vim.cmd [[autocmd! CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus = false})]]
