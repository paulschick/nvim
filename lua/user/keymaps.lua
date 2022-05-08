local opts = { noremap = true, silent = true }
local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Normal --
-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<Leader>hh", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Resize with arrows
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Navigate buffers
--keymap("n", "<C-Tab>", ":bnext<CR>", opts)
--keymap("n", "<C-S-Tab>", ":bprevious<CR>", opts)
keymap("n", "<Tab>", ":bnext<CR>", opts)
keymap("n", "<S-Tab>", ":bprev<CR>", opts)

-- Splits
keymap("n", "<Leader>v", "<C-w>v", opts)
keymap("n", "<Leader>h", "<C-w>s", opts)

-- NvimTree
keymap("n", "<Leader>e", ":NvimTreeToggle<CR>", opts)

-- Nvim Telescope
keymap("n", "<Leader>ff", "<cmd>lua require('telescope.builtin').find_files()<CR>", opts)
--keymap("n", "<Leader>fp", "<cmd>lua require('telescope.builtin').find_files() cwd=../../<CR>", opts)
keymap("n", "<Leader>fp", "<cmd>Telescope find_files cwd=../<CR>", opts)
keymap("n", "<Leader>fr", "<cmd>Telescope find_files cwd=../../<CR>", opts)
keymap("n", "<Leader>fg", "<cmd>lua require('telescope.builtin').live_grep()<CR>", opts)
keymap("n", "<Leader>fb", "<cmd>lua require('telescope.builtin').buffers()<CR>", opts)
keymap("n", "<Leader>fh", "<cmd>lua require('telescope.builtin').help_tags()<CR>", opts)

-- Kill highlight
keymap("n", "<Leader><Space>", ":noh<CR>", opts)

-- Open lsp install info panel
keymap("n", "<Leader>lsp", "<cmd>LspInstallInfo<CR>", opts)

-- Fterm
keymap("n", "<C-t>", '<CMD>lua require("FTerm").toggle()<CR>', opts)
keymap("t", "<C-t>", '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>', opts)

-- Terminal Navigation
keymap("t", "<C-n>", "<C-\\><C-N>", term_opts)
keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)

-- Transparent
keymap("n", "<Leader>tt", "<cmd>TransparentToggle<CR>", opts)

-- Insert
keymap("i", "jk", "<Esc>", term_opts)

