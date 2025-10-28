require('nvim-treesitter.configs').setup {
	-- Install parsers for these languages
	ensure_installed = {
		"lua",
		"vim",
		"vimdoc",
		"javascript",
		"typescript",
		"tsx",
		"rust",
		"go",
		"bash",
		"python",
		"json",
		"yaml",
		"toml",
		"markdown",
		"markdown_inline",
		"html",
		"css",
	},

	-- Install parsers synchronously (only applied to `ensure_installed`)
	sync_install = false,

	-- Automatically install missing parsers when entering buffer
	auto_install = true,

	highlight = {
		enable = true,
		-- Disable in very large files
		disable = function(lang, buf)
			local max_filesize = 100 * 1024 -- 100 KB
			local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
			if ok and stats and stats.size > max_filesize then
				return true
			end
		end,
		additional_vim_regex_highlighting = false,
	},

	indent = {
		enable = true
	},

	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = '<CR>',
			node_incremental = '<CR>',
			scope_incremental = '<TAB>',
			node_decremental = '<S-TAB>',
		},
	},
}
