vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
	-- Packer can manage itself
	use 'wbthomason/packer.nvim'

	use {
		'nvim-telescope/telescope.nvim',
		tag = '0.1.1',
		requires = { {'nvim-lua/plenary.nvim'} }
	}

	use({
		'rose-pine/neovim',
		as = 'rose-pine'
	})

	use('nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'})

	use('ThePrimeagen/harpoon')

	use('mbbill/undotree')

	use('tpope/vim-fugitive')

	use {
		'VonHeikemen/lsp-zero.nvim',
		branch = 'v2.x',
		requires = {
			-- LSP Support
			{'neovim/nvim-lspconfig'},
			{'williamboman/mason.nvim'},
			{'williamboman/mason-lspconfig.nvim'},
			{'hrsh7th/nvim-cmp'},
			{'hrsh7th/cmp-nvim-lsp'},
			{'L3MON4D3/LuaSnip'},
		},
	}

    use('folke/zen-mode.nvim')

    use {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        event = "VimEnter",
        config = function()
            vim.defer_fn(function()
                require('copilot').setup({
                    suggestion = { enabled = false },
                    panel = { enabled = false },
                })
            end, 100)
        end
    }
    use {
        'zbirenbaum/copilot-cmp',
        after = { 'copilot.lua', 'nvim-cmp' },
        config = function()
            require('copilot_cmp').setup()
        end
    }

end)
