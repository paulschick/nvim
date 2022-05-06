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
  }, {
    { name = 'buffer' },
  })
})

-- setup lspconfig
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
require('lspconfig')['sumneko_lua'].setup {
  capabilities = capabilities
}
require('lspconfig')['bashls'].setup {
  capabilities = capabilities
}
require('lspconfig')['clangd'].setup {
  capabilities = capabilities
}
require('lspconfig')['golangci_lint_ls'].setup {
  capabilities = capabilities
}
require('lspconfig')['gopls'].setup {
  capabilities = capabilities
}
require('lspconfig')['cssls'].setup {
  capabilities = capabilities
}
require('lspconfig')['dockerls'].setup {
  capabilities = capabilities
}
require('lspconfig')['jedi_language_server'].setup {
  capabilities = capabilities
}
require('lspconfig')['jsonls'].setup {
  capabilities = capabilities
}
require('lspconfig')['remark_ls'].setup {
  capabilities = capabilities
}
require('lspconfig')['rust_analyzer'].setup {
  capabilities = capabilities
}
require('lspconfig')['solang'].setup {
  capabilities = capabilities
}
require('lspconfig')['solc'].setup {
  capabilities = capabilities
}
require('lspconfig')['solidity_ls'].setup {
  capabilities = capabilities
}
require('lspconfig')['taplo'].setup {
  capabilities = capabilities
}
require('lspconfig')['tsserver'].setup {
  capabilities = capabilities
}
