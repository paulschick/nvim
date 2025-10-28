-- Disable netrw (required for nvim-tree)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require("nvim-tree").setup({
	sort_by = "case_sensitive",
	view = {
		width = 30,
	},
	renderer = {
		group_empty = true,
		icons = {
			show = {
				file = true,
				folder = true,
				folder_arrow = true,
				git = true,
			},
		},
	},
	filters = {
		dotfiles = false,
	},
	git = {
		enable = true,
		ignore = false,
	},
})

-- Keymaps are in lua/paul/remap.lua
