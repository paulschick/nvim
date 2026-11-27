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

-- Widen or narrow the centered column, 5 columns per press (see after/plugin/no-neck-pain.lua)
local function resize(cmd)
	return function()
		-- Centering is off while markdown shares the tab with other windows
		if not require('no-neck-pain.state'):is_active_tab_registered() then
			return vim.notify('Markdown column is not centered in this layout')
		end
		vim.cmd(cmd)
	end
end
vim.keymap.set('n', '<leader>m=', resize('NoNeckPainWidthUp'), { buffer = true, desc = 'Widen markdown column' })
vim.keymap.set('n', '<leader>m-', resize('NoNeckPainWidthDown'), { buffer = true, desc = 'Narrow markdown column' })

vim.b.undo_ftplugin = (vim.b.undo_ftplugin or '')
	.. '\n setlocal wrap< linebreak< breakindent< colorcolumn< spell< spelllang<'
	.. '\n silent! nunmap <buffer> j'
	.. '\n silent! xunmap <buffer> j'
	.. '\n silent! nunmap <buffer> k'
	.. '\n silent! xunmap <buffer> k'
	.. '\n silent! nunmap <buffer> <leader>mr'
	.. '\n silent! nunmap <buffer> <leader>m='
	.. '\n silent! nunmap <buffer> <leader>m-'
