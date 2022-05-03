local opts = { noremap = true, silent = true }
local term_opts = { silent = true }

-- shorten function name
local keymap = vim.api.nvim_set_keymap

local function map_leader(key)
    keymap("", key, "<Nop>", opts)
    if string.lower(key) == "<space>" then
        vim.g.mapleader = " "
        vim.g.maplocalleader = " "
    else
        vim.g.mapleader = key
        vim.g.maplocalleader = key
    end
end

-- Map Leader to Space
map_leader("<Space>")

-- Enter normal mode mapping
keymap("i", "jk", "<Esc>", opts)

-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", term_opts)
keymap("n", "<C-j>", "<C-w>j", term_opts)
keymap("n", "<C-k>", "<C-w>k", term_opts)
keymap("n", "<Leader>kk", "<C-w>k", term_opts)
keymap("n", "<C-l>", "<C-w>l", term_opts)

-- splits
keymap("n", "<Leader>v", "<C-w>v", opts)
keymap("n", "<Leader>h", "<C-w>s", opts)

-- Resize with arrows
keymap("n", "<C-Up>", ":resize +2<CR>", opts)
keymap("n", "<C-Down>", ":resize -2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize +2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize -2<CR>", opts)

-- Indenting - stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Buffer navigation
keymap("n", "<Tab>", ":bnext<CR>", opts)
keymap("n", "<S-Tab>", ":bprevious<CR>", opts)

-- Remove highlight
keymap("n", "<Leader><space>", ":noh<CR>", term_opts)

-- Nvim Tree
keymap("n", "<Leader>e", ":NvimTreeToggle<CR>", opts)

--keymap("n", "<Leader>f", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
--keymap("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
--keymap("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
--keymap("n", "<Leader>q", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)

-- Terminal Navigation
keymap("t", "<C-n>", "<C-\\><C-N>", term_opts)
keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)

--keymap("n", "<M-S-f>", "<CMD>Format<CR>", opts)