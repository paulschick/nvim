local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
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
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

-- Install your plugins here
return packer.startup(function(use)
    use "wbthomason/packer.nvim"
    use "nvim-lua/popup.nvim"
    use "nvim-lua/plenary.nvim"
    use "windwp/nvim-autopairs"
    use "kyazdani42/nvim-web-devicons"
    use { "kyazdani42/nvim-tree.lua" }
    use "folke/tokyonight.nvim"
    use "nvim-telescope/telescope.nvim"
    use "hrsh7th/cmp-buffer" -- buffer completions
    use "hrsh7th/cmp-path" -- path completions
    use "hrsh7th/cmp-cmdline" -- cmdline completions
    use 'L3MON4D3/LuaSnip'
    use "saadparwaiz1/cmp_luasnip" -- snippet completions
    use {
    "hrsh7th/nvim-cmp",
    -- commit = "dbc72290295cfc63075dab9ea635260d2b72f2e5",
    }
    use "onsails/lspkind-nvim"
    use "hrsh7th/cmp-nvim-lsp"
    use "hrsh7th/cmp-nvim-lua"
    use "neovim/nvim-lspconfig"
    use "williamboman/nvim-lsp-installer"
    use "jose-elias-alvarez/null-ls.nvim"

    use "nvim-treesitter/nvim-treesitter"
    -- https://github.com/xiyaowong/nvim-transparent
    use "xiyaowong/nvim-transparent"
    use "numToStr/FTerm.nvim"

    use "numToStr/Comment.nvim"

    use 'rust-lang/rust.vim'
    use 'darrikonn/vim-gofmt'
    use 'tomlion/vim-solidity'

    use 'flazz/vim-colorschemes'

    use 'EdenEast/nightfox.nvim'

end)
