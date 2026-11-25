-- Soft wrap prose at word boundaries
vim.opt_local.wrap = true
vim.opt_local.linebreak = true
vim.opt_local.breakindent = true
vim.opt_local.colorcolumn = ''

-- LSP hover floats are markdown too, so only spell check real files
if vim.bo.buftype == '' then
	vim.opt_local.spell = true
	vim.opt_local.spelllang = 'en_us'
end

-- Move by display line, unless a count is given (so 5j still moves 5 lines)
vim.keymap.set({ 'n', 'x' }, 'j', "v:count == 0 ? 'gj' : 'j'", { buffer = true, expr = true })
vim.keymap.set({ 'n', 'x' }, 'k', "v:count == 0 ? 'gk' : 'k'", { buffer = true, expr = true })

vim.keymap.set('n', '<leader>mr', function()
	require('render-markdown').buf_toggle()
end, { buffer = true, desc = 'Toggle markdown rendering' })

vim.b.undo_ftplugin = (vim.b.undo_ftplugin or '')
	.. '\n setlocal wrap< linebreak< breakindent< colorcolumn< spell< spelllang<'
	.. '\n silent! nunmap <buffer> j'
	.. '\n silent! xunmap <buffer> j'
	.. '\n silent! nunmap <buffer> k'
	.. '\n silent! xunmap <buffer> k'
	.. '\n silent! nunmap <buffer> <leader>mr'
