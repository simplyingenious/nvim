local Remap = require("simplyingenious.keymap")
local nnoremap = Remap.nnoremap
local vnoremap = Remap.vnoremap
local inoremap = Remap.inoremap
local xnoremap = Remap.xnoremap
local tnoremap = Remap.tnoremap
local nmap = Remap.nmap

nnoremap("<leader>pv", ":Ex<CR>")
nnoremap("<leader>f", ":lua vim.lsp.buf.format {async = true}<CR>")
nnoremap("<C-w>", ":bd<CR>")
vnoremap("<C-c>", "\"+y")

nnoremap("<C-d>", "<C-d>zz")
nnoremap("<C-u>", "<C-u>zz")
nnoremap("n", "nzz")
nnoremap("N", "Nzz")

-- terminal
nnoremap("<C-n>", ":call OpenTerminal()<CR>")
tnoremap("<Esc>", "<C-\\><C-n>")
