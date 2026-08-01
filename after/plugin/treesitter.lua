-- nvim-treesitter `main` branch: no configs.setup(); install parsers
-- explicitly and start highlighting per-buffer via autocmd.
local ts = require('nvim-treesitter')

-- Install parsers for these languages (async, no-op if already installed)
ts.install({
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
	"kotlin",
})

local function enable(buf, lang)
	-- Disable in very large files
	local max_filesize = 100 * 1024 -- 100 KB
	local stat_ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(buf))
	if stat_ok and stats and stats.size > max_filesize then
		return
	end

	vim.treesitter.start(buf, lang)
	vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
end

vim.api.nvim_create_autocmd('FileType', {
	group = vim.api.nvim_create_augroup('paul.treesitter', {}),
	callback = function(args)
		local buf = args.buf
		local lang = vim.treesitter.language.get_lang(args.match)
		if not lang then
			return
		end

		local ok, added = pcall(vim.treesitter.language.add, lang)
		if ok and added then
			enable(buf, lang)
			return
		end

		-- Parser not installed: auto-install if available, then enable
		if not vim.tbl_contains(ts.get_available(), lang) then
			return
		end
		ts.install(lang):await(function(err)
			if err or not vim.api.nvim_buf_is_valid(buf) then
				return
			end
			vim.schedule(function()
				if vim.api.nvim_buf_is_valid(buf) then
					enable(buf, lang)
				end
			end)
		end)
	end,
})
