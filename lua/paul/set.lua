vim.opt.guicursor = "n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,sm:block-blinkwait175-blinkoff150-blinkon175"

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

-- vim.opt.wrap = true -- Not sure yet.
-- set up an undo file, allows you to have long-running
-- undo functions (like days and stuff)
vim.opt.swapfile = false
vim.opt.backup = false

-- Create undo directory if it doesn't exist
local undodir = vim.fn.stdpath('data') .. '/undodir'
if vim.fn.isdirectory(undodir) == 0 then
	vim.fn.mkdir(undodir, 'p')
end
vim.opt.undodir = undodir
vim.opt.undofile = true

-- highlight search results
vim.opt.hlsearch = true
-- highlight while searching
vim.opt.incsearch = true
-- case insensitive search unless uppercase is used
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.termguicolors = true

-- As you go down, never less than 8 chars unless you're at the bottom
-- same with the top.
vim.opt.scrolloff = 8
vim.opt.signcolumn = 'yes'
vim.opt.isfname:append('@-@')

vim.opt.updatetime = 50
vim.opt.colorcolumn = '80'
