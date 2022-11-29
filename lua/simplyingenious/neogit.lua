local neogit = require('neogit')
local nnoremap = require('simplyingenious.keymap').nnoremap

neogit.setup {}

nnoremap("<Leader>gs", function()
  neogit.open({})
end)

