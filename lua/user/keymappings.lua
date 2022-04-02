local opts = { noremap = true, silent = true }
local term_opts = { silent = true }

-- shorten function name
local keymap = vim.api.nvim_set_keymap

local function map_leader(key)
  keymap("", key, "<Nop>", opts)
  if (string.lower(key) == "<space>")
  then
    vim.g.mapleader = " "
    vim.g.maplocalleader = " "
  else
    vim.g.mapleader = key
    vim.g.maplocalleader = key
  end
end

-- Map Leader to Space
map_leader('<Space>')

-- Enter normal mode mapping
keymap('i', 'jk', '<Esc>', opts)

-- Better window navigation
keymap('n', '<C-h>', '<C-w>h', term_opts)
keymap('n', '<C-j>', '<C-w>j', term_opts)
keymap('n', '<C-k>', '<C-w>k', term_opts)
keymap('n', '<Leader>kk', '<C-w>k', term_opts)
keymap('n', '<C-l>', '<C-w>l', term_opts)

-- splits
keymap('n', '<Leader>v', '<C-w>v', opts)
keymap('n', '<Leader>h', '<C-w>s', opts)

-- Resize with arrows
keymap('n', '<C-Up>', ':resize +2<CR>', opts)
keymap('n', '<C-Down>', ':resize -2<CR>', opts)
keymap('n', '<C-Left>', ':vertical resize +2<CR>', opts)
keymap('n', '<C-Right>', ':vertical resize -2<CR>', opts)

-- Indenting - stay in indent mode
keymap('v', '<', '<gv', opts)
keymap('v', '>', '>gv', opts)

-- Buffer navigation
keymap('n', '<Tab>', ':bnext<CR>', opts)
keymap('n', '<S-Tab>', ':bprevious<CR>', opts)

-- Remove highlight
keymap('n', '<Leader><space>', ':noh<CR>', term_opts)

-- Nvim Tree
keymap('n', '<Leader>e', ':NvimTreeToggle<CR>', opts)

-- Save Actions
-- :wa write all changes and keep working
-- :xa exit all, save all changes and exit vim
-- :wqa same as :xa
-- :qa quit all but not if there are unsaved changes
-- :qa! quit all and discard unsaved changes


-- Vim Markdown
-- https://github.com/preservim/vim-markdown
-- zR: open all folds
-- zM fold everything all the way
-- za: open fold at cursor
-- zA: open fold from cursor recursively
-- zc: close fold cursor is on
-- zC: close a fold at cursor recursively

--  nvim lspconfig
-- https://github.com/neovim/nvim-lspconfig
-- must pass defined on_attach as argument to every
-- setup {} call and the keybindings in on_attach only
-- take effect on buffers with an active language server

-- See `:help vim.diagnostic.*` for documentation on any of the below functions
keymap('n', '<Leader>f', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
keymap('n', '<Leader>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)

-- Telescope bindings
keymap("n", "<leader>ff", "<cmd>lua require'telescope.builtin'.find_files(require('telescope.themes').get_dropdown({ previewer = false }))<cr>", opts)
keymap('n', '<Leader>fb', '<cmd>Telescope buffers<CR>', opts)
keymap("n", "<c-t>", "<cmd>Telescope live_grep<cr>", opts)

-- Terminal Navigation
keymap("t", "<C-n>", "<C-\\><C-N>", term_opts)
keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)

-- Glow
keymap('n', '<Leader>md', '<CMD>Glow<CR>', opts)

-- FTerm
keymap('n', '<C-t>', '<CMD>lua require("FTerm").toggle()<CR>', opts)
keymap('t', '<C-t>', '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>', opts)

-- Comment
-- keymap('n', '<C-/>', 'gcc', opts)         -- single line style comment
-- keymap('v', '<C-/>', 'gcc', opts)         -- single line style comment
-- keymap('n', '<Leader>bc', 'gbc', opts)    -- block style comment
-- keymap('v', '<Leader>bc', 'gbc', opts)    -- block style comment

