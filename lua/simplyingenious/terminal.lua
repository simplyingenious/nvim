vim.cmd [[
set splitright
set splitbelow

au BufEnter * if &buftype == 'terminal' | :startinsert | endif

function! OpenTerminal()
  split term://ash
  resize 15
endfunction
]]
