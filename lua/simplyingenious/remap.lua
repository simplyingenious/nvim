vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]])

-- next greatest remap ever : asbjornHaland
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

-- This is going to get me cancelled
vim.keymap.set("i", "<C-c>", "<Esc>")

vim.keymap.set("n", "W", [[:bd<CR>]])
vim.keymap.set("n", "<leader>w", [[:w<CR>]])
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
vim.keymap.set('n', '<leader>f', ':lua vim.lsp.buf.format({ async = true })<CR>', { silent = true, noremap = true })
vim.keymap.set('x', '<leader>f', ':lua vim.lsp.buf.format()<CR>', { silent = true, noremap = true })

-- git conflict resolution grabber
vim.keymap.set("n", "<leader>gf", [[:diffget //2<CR>]])
vim.keymap.set("n", "<leader>gj", [[:diffget //3<CR>]])

vim.keymap.set("n", "<leader>gl", [[:G pull<CR>]])
vim.keymap.set("n", "<leader>gp", [[:G push<CR>]])

vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

-- terminal
vim.keymap.set("n", "<C-n>", ":call OpenTerminal()<CR>")
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")
