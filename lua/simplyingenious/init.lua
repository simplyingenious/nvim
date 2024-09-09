require("simplyingenious.remap")
require("simplyingenious.set")
require("simplyingenious.terminal")


-- bootstraping Lazy plugin manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "git@github.com:folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
require("simplyingenious.lazy")


local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
local yank_group = augroup('HighlightYank', {})

autocmd('TextYankPost', {
  group = yank_group,
  pattern = '*',
  callback = function()
    vim.highlight.on_yank({
      higroup = 'IncSearch',
      timeout = 40,
    })
  end,
})

if vim.g.neovide then
  vim.o.guifont = "0xProto:h13"
  vim.o.linespace = 6

  vim.g.neovide_padding_top = 8
  vim.g.neovide_padding_bottom = 8
  vim.g.neovide_padding_right = 8
  vim.g.neovide_padding_left = 8

  vim.g.neovide_cursor_vfx_mode = "pixiedust"
  vim.g.neovide_cursor_vfx_particle_density = 8.0

  vim.opt.title = true
  vim.opt.titlelen = 0 -- do not shorten title
  -- vim.opt.titlestring = '%{expand("%:t")} – %{expand("%:p:h:t")}'

  local function set_relative_title()
    local folder = vim.fn.expand('%:p:h:t') -- Parent folder name
    local file = vim.fn.expand('%:t')       -- File name
    local title = file .. ' – ' .. folder
    vim.cmd('silent !title ' .. title)
  end

  vim.api.nvim_create_autocmd("BufEnter", { callback = set_relative_title })


  vim.keymap.set('n', '<D-s>', ':w<CR>')      -- Save
  vim.keymap.set('v', '<D-c>', '"+y')         -- Copy
  vim.keymap.set('n', '<D-v>', '"+P')         -- Paste normal mode
  vim.keymap.set('v', '<D-v>', '"+P')         -- Paste visual mode
  vim.keymap.set('c', '<D-v>', '<C-R>+')      -- Paste command mode
  vim.keymap.set('i', '<D-v>', '<ESC>l"+Pli') -- Paste insert mode
end
