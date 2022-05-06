require('nvim-lsp-installer').setup {}

local cmp = require 'cmp'
cmp.setup({
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)    -- Luasnip
    end,
  },
  window = {},
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- accept selected item
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'buffer' },
  }, {
    --{ name = 'buffer' },
  })
})

local opts = { noremap = true, silent = true }
-- Shorten function name
local keymap = vim.api.nvim_set_keymap

local function config(_config)
	return vim.tbl_deep_extend("force", {
		capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities()),
		on_attach = function()
			keymap("n", "gd", ":lua vim.lsp.buf.definition()<CR>", opts)
			keymap("n", "K", ":lua vim.lsp.buf.hover()<CR>", opts)
			keymap("n","<leader>vws", ":lua vim.lsp.buf.workspace_symbol()<CR>", opts)
			keymap("n", "<leader>vd", ":lua vim.diagnostic.open_float()<CR>", opts)
			keymap("n", "[d", ":lua vim.lsp.diagnostic.goto_next()<CR>", opts)
			keymap("n", "]d", ":lua vim.lsp.diagnostic.goto_prev()<CR>", opts)
			keymap("n", "<leader>vca", ":lua vim.lsp.buf.code_action()<CR>", opts)
			keymap("n", "<leader>vrr", ":lua vim.lsp.buf.references()<CR>", opts)
			keymap("n", "<leader>vrn", ":lua vim.lsp.buf.rename()<CR>", opts)
			keymap("n", "<C-h>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
		end,
	}, _config or {})
end

require('lspconfig').tsserver.setup(config())
require('lspconfig').sumneko_lua.setup(config())
require('lspconfig').gopls.setup(config())
require('lspconfig').jedi_language_server.setup(config())
require('lspconfig').jsonls.setup(config())
require('lspconfig').remark_ls.setup(config())
require('lspconfig').solidity_ls.setup(config())
