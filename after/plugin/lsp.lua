local lsp = require('lsp-zero').preset({})

-- (Optional) Configure lua language server for neovim
require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())
require('lspconfig').bashls.setup({
    filetypes = {"sh", "zsh", "bash"},
})

--'sumneko_lua',

lsp.ensure_installed({
	'tsserver',
	'rust_analyzer',
    'bashls'
})

local cmp = require('cmp')
local cmp_select = {behavior = cmp.SelectBehavior.Select}
local cmp_mappings = lsp.defaults.cmp_mappings({
	['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
	['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
	['<C-y>'] = cmp.mapping.confirm({ select = true }),
	['<C-Space>'] = cmp.mapping.complete(),
})

-- Turn off the icons
lsp.set_preferences({
	sign_icons = { }
})

lsp.setup_nvim_cmp({
	mapping = cmp_mappings
})

--[[
	on_attach happens on every buffer that has lsp.

	This means that if you don't have an lsp and you use a keybinding (if
	it has something in normal vim) then vim will use its own implementation.

	For example, if you use gd here, then it's going to prefer to use the
	lsp go to definition. If it doesn't have lsp, then vim will try to
	go to definition.
]]--
lsp.on_attach(function(client, bufnr)
	local opts = {buffer = bufnr, remap = false}
	--lsp.default_keymaps({buffer = bufnr})
	vim.keymap.set('n', 'gd', function() vim.lsp.buf.definition() end, opts)
	vim.keymap.set('n', 'K', function() vim.lsp.buf.hover() end, opts)
	vim.keymap.set('n', '<leader>vws', function() vim.lsp.buf.workspace_symbol() end, opts)
	vim.keymap.set('n', '<leader>vd', function() vim.diagnostic.open_float() end, opts)
	vim.keymap.set('n', '[d', function() vim.diagnostic.goto_next() end, opts)
	vim.keymap.set('n', ']d', function() vim.diagnostic.goto_prev() end, opts)
	vim.keymap.set('n', '<leader>vca', function() vim.lsp.buf.code_action() end, opts)
	vim.keymap.set('n', '<leader>vrr', function() vim.lsp.buf.references() end, opts)
	vim.keymap.set('n', '<leader>vrn', function() vim.lsp.buf.rename() end, opts)
	vim.keymap.set('n', '<C-h>', function() vim.lsp.buf.signature_help() end, opts)
end)

lsp.setup()
