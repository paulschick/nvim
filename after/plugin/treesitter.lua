-- nvim-treesitter new API (post-rewrite)
local ts = require('nvim-treesitter')

-- Parsers to install
local parsers = {
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
}

-- Install parsers on startup (fully non-blocking, no :wait())
ts.install(parsers)

-- Enable treesitter highlighting on FileType
vim.api.nvim_create_autocmd('FileType', {
	group = vim.api.nvim_create_augroup('treesitter_setup', { clear = true }),
	pattern = '*',
	callback = function(event)
		local buf = event.buf
		local ft = vim.bo[buf].filetype
		if ft == "" then return end

		local lang = vim.treesitter.language.get_lang(ft)
		if not lang then return end

		-- Skip large files (100KB)
		local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(buf))
		if ok and stats and stats.size > 100 * 1024 then return end

		-- Enable highlighting (only works if parser is already installed)
		pcall(vim.treesitter.start, buf, lang)
	end,
})
