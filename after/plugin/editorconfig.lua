-- max_line_length adds a colorcolumn after the ftplugin has run. Keep it off in markdown.
vim.fn['editorconfig#AddNewHook'](function()
	if vim.bo.filetype == 'markdown' then
		vim.opt_local.colorcolumn = ''
	end
	return 0
end)
