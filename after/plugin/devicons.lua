-- Configure nvim-web-devicons
require('nvim-web-devicons').setup({
	-- globally enable different highlight colors per icon (default to true)
	color_icons = true,
	-- globally enable default icons (default to false)
	default = true,
	-- globally enable "strict" selection of icons - icon will be looked up in
	-- different tables, first by filename, and if not found by extension; this
	-- prevents cases when file doesn't have any extension but you still want icon
	strict = true,
	-- set the light or dark variant manually, otherwise it's automatically set
	-- based on vim.o.background
	variant = "dark",
})
