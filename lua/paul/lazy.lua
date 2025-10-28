-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- Configure lazy.nvim
require("lazy").setup({
	-- Telescope - Fuzzy finder
	{
		'nvim-telescope/telescope.nvim',
		tag = '0.1.8',
		dependencies = { 'nvim-lua/plenary.nvim' }
	},

	-- Color scheme
	{
		'rose-pine/neovim',
		name = 'rose-pine',
		priority = 1000,
	},

	-- Treesitter - Better syntax highlighting
	{
		'nvim-treesitter/nvim-treesitter',
		build = ':TSUpdate'
	},

	-- Undo tree
	'mbbill/undotree',

	-- Git integration
	'tpope/vim-fugitive',

	-- Git signs in gutter
	'lewis6991/gitsigns.nvim',

	-- LSP Support
	'neovim/nvim-lspconfig',
	'williamboman/mason.nvim',
	'williamboman/mason-lspconfig.nvim',

	-- Completion
	'hrsh7th/nvim-cmp',
	'hrsh7th/cmp-nvim-lsp',
	'hrsh7th/cmp-buffer',
	'hrsh7th/cmp-path',
	'hrsh7th/cmp-cmdline',

	-- Snippets
	'L3MON4D3/LuaSnip',
	'rafamadriz/friendly-snippets',
	'saadparwaiz1/cmp_luasnip',

	-- LSP UI improvements
	'onsails/lspkind.nvim',
	{
		'j-hui/fidget.nvim',
		opts = {},
	},

	-- Autopairs
	'windwp/nvim-autopairs',

	-- Indent guides
	'lukas-reineke/indent-blankline.nvim',

	-- Statusline
	{
		'nvim-lualine/lualine.nvim',
		dependencies = { 'nvim-tree/nvim-web-devicons' }
	},

	-- File explorer
	{
		'nvim-tree/nvim-tree.lua',
		dependencies = { 'nvim-tree/nvim-web-devicons' },
	},

	-- Zen mode
	'folke/zen-mode.nvim',

	-- Commenting
	{
		'numToStr/Comment.nvim',
		config = function()
			require('Comment').setup()
		end
	},

	-- Editorconfig support
	'editorconfig/editorconfig-vim',

}, {
	-- Lazy.nvim configuration options
	ui = {
		border = "rounded",
		icons = {
			cmd = "⌘",
			config = "🛠",
			event = "📅",
			ft = "📂",
			init = "⚙",
			keys = "🗝",
			plugin = "🔌",
			runtime = "💻",
			require = "🌙",
			source = "📄",
			start = "🚀",
			task = "📌",
			lazy = "💤 ",
		},
	},
	performance = {
		rtp = {
			disabled_plugins = {
				"gzip",
				"matchit",
				-- "matchparen",  -- Keep enabled for bracket matching
				"netrwPlugin",
				"tarPlugin",
				"tohtml",
				"tutor",
				"zipPlugin",
			},
		},
	},
})
