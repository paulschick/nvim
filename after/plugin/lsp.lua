-- Load snippet collection
require("luasnip.loaders.from_vscode").lazy_load()

-- Setup Mason for LSP server management
require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = {
		'lua_ls',
		'ts_ls',
		'rust_analyzer',
		'bashls',
		'gopls'
	},
	automatic_installation = true,
})

-- Setup completion capabilities
local cmp = require('cmp')
local cmp_nvim_lsp = require('cmp_nvim_lsp')
local lspkind = require('lspkind')

local capabilities = cmp_nvim_lsp.default_capabilities()

-- LSP on_attach function
local on_attach = function(client, bufnr)
	local opts = {buffer = bufnr, remap = false}

	-- LSP keymaps
	vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
	vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
	vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
	vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
	vim.keymap.set('n', '<leader>vws', vim.lsp.buf.workspace_symbol, opts)
	vim.keymap.set('n', '<leader>vd', vim.diagnostic.open_float, opts)
	vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
	vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
	vim.keymap.set('n', '<leader>vca', vim.lsp.buf.code_action, opts)
	vim.keymap.set('n', '<leader>vrr', vim.lsp.buf.references, opts)
	vim.keymap.set('n', '<leader>vrn', vim.lsp.buf.rename, opts)
	vim.keymap.set('n', '<C-h>', vim.lsp.buf.signature_help, opts)
	vim.keymap.set('i', '<C-h>', vim.lsp.buf.signature_help, opts)
end

-- Configure LSP servers using new vim.lsp.config API
vim.lsp.config('lua_ls', {
	cmd = { 'lua-language-server' },
	filetypes = { 'lua' },
	root_markers = { '.luarc.json', '.luarc.jsonc', '.luacheckrc', '.stylua.toml', 'stylua.toml', 'selene.toml', 'selene.yml', '.git' },
	capabilities = capabilities,
	on_attach = on_attach,
	settings = {
		Lua = {
			runtime = { version = 'LuaJIT' },
			diagnostics = { globals = { 'vim' } },
			workspace = {
				library = vim.api.nvim_get_runtime_file("", true),
				checkThirdParty = false,
			},
			telemetry = { enable = false },
		},
	},
})

vim.lsp.config('bashls', {
	cmd = { 'bash-language-server', 'start' },
	filetypes = { 'sh', 'zsh', 'bash' },
	root_markers = { '.git' },
	capabilities = capabilities,
	on_attach = on_attach,
})

vim.lsp.config('ts_ls', {
	cmd = { 'typescript-language-server', '--stdio' },
	filetypes = { 'javascript', 'javascriptreact', 'javascript.jsx', 'typescript', 'typescriptreact', 'typescript.tsx' },
	root_markers = { 'package.json', 'tsconfig.json', 'jsconfig.json', '.git' },
	capabilities = capabilities,
	on_attach = on_attach,
})

vim.lsp.config('rust_analyzer', {
	cmd = { 'rust-analyzer' },
	filetypes = { 'rust' },
	root_markers = { 'Cargo.toml', 'rust-project.json', '.git' },
	capabilities = capabilities,
	on_attach = on_attach,
})

vim.lsp.config('gopls', {
	cmd = { 'gopls' },
	filetypes = { 'go', 'gomod', 'gowork', 'gotmpl' },
	root_markers = { 'go.work', 'go.mod', '.git' },
	capabilities = capabilities,
	on_attach = on_attach,
})

-- Enable LSP servers
vim.lsp.enable('lua_ls')
vim.lsp.enable('bashls')
vim.lsp.enable('ts_ls')
vim.lsp.enable('rust_analyzer')
vim.lsp.enable('gopls')

-- Setup nvim-cmp
cmp.setup({
	snippet = {
		expand = function(args)
			require('luasnip').lsp_expand(args.body)
		end,
	},
	mapping = cmp.mapping.preset.insert({
		['<C-p>'] = cmp.mapping.select_prev_item({behavior = cmp.SelectBehavior.Select}),
		['<C-n>'] = cmp.mapping.select_next_item({behavior = cmp.SelectBehavior.Select}),
		['<C-y>'] = cmp.mapping.confirm({ select = true }),
		['<C-Space>'] = cmp.mapping.complete(),
		['<C-b>'] = cmp.mapping.scroll_docs(-4),
		['<C-f>'] = cmp.mapping.scroll_docs(4),
		['<C-e>'] = cmp.mapping.abort(),
	}),
	sources = cmp.config.sources({
		{ name = 'nvim_lsp' },
		{ name = 'luasnip' },
		{ name = 'buffer', keyword_length = 3 },
		{ name = 'path' },
	}),
	formatting = {
		format = lspkind.cmp_format({
			mode = 'symbol_text',
			maxwidth = 50,
			ellipsis_char = '...',
		})
	},
})

-- Setup cmdline completion
cmp.setup.cmdline(':', {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = 'path' },
		{ name = 'cmdline' }
	})
})

cmp.setup.cmdline('/', {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = 'buffer' }
	})
})

-- Diagnostic signs (no icons, clean gutter)
vim.diagnostic.config({
	signs = false,
	virtual_text = true,
	update_in_insert = false,
	underline = true,
	severity_sort = true,
	float = {
		border = 'rounded',
		source = 'always',
	},
})

-- Format on save (with toggle)
vim.g.format_on_save = true

vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*",
	callback = function()
		if not vim.g.format_on_save then return end

		-- Only format if LSP client is attached
		local clients = vim.lsp.get_clients({ bufnr = 0 })
		if #clients > 0 then
			vim.lsp.buf.format({ async = false })
		end
	end,
})

-- Toggle format-on-save command
vim.api.nvim_create_user_command('ToggleFormatOnSave', function()
	vim.g.format_on_save = not vim.g.format_on_save
	print('Format on save: ' .. tostring(vim.g.format_on_save))
end, {})
