local fn = vim.fn

local install_path = fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    'git',
    'clone',
    '--depth',
    '1',
    'https://github.com/wbthomason/packer.nvim',
    install_path,
  }
  print 'Installing packer... restart Neovim'
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end


-- Have packer use a popup window
-- I like this rather than the left side flyout
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

return packer.startup(function (use)
  use({
    'wbthomason/packer.nvim',
    -- lsp
    'L3MON4D3/LuaSnip',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-cmdline',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-path',
    'hrsh7th/nvim-cmp',
    'jose-elias-alvarez/null-ls.nvim',
    'neovim/nvim-lspconfig',
    'saadparwaiz1/cmp_luasnip',
    'tamago324/nlsp-settings.nvim',
    'williamboman/nvim-lsp-installer',
    --'nvim-lua/lsp-status.nvim',

    -- fterm
    -- https://github.com/numToStr/FTerm.nvim
    'numToStr/FTerm.nvim',

    -- https://github.com/ellisonleao/glow.nvim
    -- Markdown preview
    'ellisonleao/glow.nvim',

    -- Colorschemes
    'rakr/vim-one',
    'folke/tokyonight.nvim',

    'windwp/nvim-autopairs',
    'nvim-lua/popup.nvim',
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope.nvim',
    'lewis6991/gitsigns.nvim',
  })
  use {
    'kyazdani42/nvim-tree.lua',

    -- Add this if supporting icons -> use on Ubuntu Linux desktop
    requires = {
      'kyazdani42/nvim-web-devicons' -- optional for file icons
    },
    config = function() require'nvim-tree'.setup {} end
  }
  -- Treesitter
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
  }
  --[[
      Comments plugin
      I want to be able to toggle comments, just like an IDE

      Repository:
      https://github.com/numToStr/Comment.nvim

      gcc - toggle current lin
      gbc - toggle current line using blockwise comment
  --]]
  use {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end
  }
end)
