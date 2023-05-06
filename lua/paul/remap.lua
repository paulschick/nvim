-- Set leader key
vim.g.mapleader = ' '

-- Open built-in file explorer
vim.keymap.set('n', '<leader>pv', vim.cmd.Ex)

-- Enter normal mode
vim.keymap.set('i', 'jk', '<Esc>')

--[[
    Allows you to move a line up or down when in visual line mode.
    Use capital J and K to move the selected line up or down.
]]
--
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '>-2<CR>gv=gv")
--[[
    When in normal mode, use capital J to append the next line
    to the current line. This will also ensure that the cursor
    remains at its current position.
]]
--
vim.keymap.set('n', 'J', 'mzJ`z')
--[[
    C-d and C-u are half-page jumping keys.
    this will keep cursor in the middle of the screen
]]
--
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')
--[[
    Keep search terms in the middle when searching
    n - next result
    N - previous result
]]
--
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')
--[[
    1. Copy some text
    2. Highlight the text that you want to replace
    3. use leader p

    This copies the text to replace into the void register.
    As opposed to using dd, which would just re-paste whatever
    you deleted.

    This lets you keep what you want to copy+paste and not the stuff
    that you're deleting.
]]
   --
vim.keymap.set('x', '<leader>p', "\"_dp")
vim.keymap.set('n', '<leader>d', "\"_d")
vim.keymap.set('v', '<leader>d', "\"_d")
--[[
    leader y - copy into system clipboard
    regular y - copy in vim
]]
   --
vim.keymap.set('n', '<leader>y', "\"+y")
vim.keymap.set('v', '<leader>y', "\"+y")
vim.keymap.set('n', '<leader>Y', "\"+Y")

--[[
    make capital Q do nothing
    this is just an invalid register
]]
vim.keymap.set('n', 'Q', '<nop>')

-- should open a tmux sessionizer thing
-- probably need to have that installed
--vim.keymap.set('n', '<C-f>', '<cmd>silent !tmux neww tmux-sessionizer<CR>')

vim.keymap.set('n', '<leader>f', function()
    vim.lsp.buf.format()
end)

vim.keymap.set('n', '<C-k>', '<cmd>cnext<CR>zz')
vim.keymap.set('n', '<C-j>', '<cmd>cprev<CR>zz')
vim.keymap.set('n', '<leader>k', '<cmd>lnext<CR>zz')
vim.keymap.set('n', '<leader>j', '<cmd>lprev<CR>zz')

--[[
    When you have the cursor over a word in normal mode and press
    leader s, this will start a search and replace regex for that word.
    it will highlight and show the replacement for each instance
    in the current buffer.
]]--
vim.keymap.set('n', '<leader>s', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

--[[
    This will source the current file when you hit leader twice
]]--
vim.keymap.set('n', '<leader><leader>', function()
    vim.cmd('so')
end)

