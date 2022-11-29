local Remap = require('simplyingenious.keymap')
local nnoremap = Remap.nnoremap

local builtin = require('telescope.builtin')

nnoremap("<C-p>", function()
    builtin.find_files()
end)

nnoremap("<leader>ps", function()
    -- builtin.grep_string ({ search = vim.fn.input("Grep For > ")})
    builtin.live_grep()
end)

nnoremap("<leader>pw", function()
    builtin.grep_string { search = vim.fn.expand("<cword>") }
end)

nnoremap("<leader>pb", function()
    builtin.buffers()
end)

nnoremap("<leader>vh", function()
    builtin.help_tags()
end)

