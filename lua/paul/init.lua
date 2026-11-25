-- Set leader before plugins load: lazy sources after/plugin, which maps <leader>
vim.g.mapleader = ' '

require('paul.lazy')
require('paul.remap')
require('paul.set')

-- Show the cheat sheet as the home page when nvim starts with nothing to edit
vim.api.nvim_create_autocmd('VimEnter', {
	group = vim.api.nvim_create_augroup('paul.home', {}),
	callback = function()
		local empty = vim.api.nvim_buf_get_name(0) == ''
			and vim.bo.buftype == ''
			and not vim.bo.modified
			and vim.api.nvim_buf_line_count(0) == 1
			and vim.api.nvim_get_current_line() == ''
		if vim.fn.argc() == 0 and empty then
			require('paul.cheatsheet').home()
		end
	end,
})
