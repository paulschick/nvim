require('render-markdown').setup({
	sign = {
		-- Stay below gitsigns (6): signcolumn is a single slot and git status wins
		priority = 1,
	},
})
