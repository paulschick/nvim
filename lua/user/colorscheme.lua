vim.cmd([[
try
  " colorscheme one
  colorscheme tokyonight
  set background=dark
catch /^Vim\%((\a\+)\)\=:E185/
  colorscheme default
  " set background=light
  set background=dark
endtry
]])
