-- Set clipboard BEFORE plugins load to prevent pbcopy detection hang in tmux
vim.g.clipboard = 'osc52'

require('paul')
