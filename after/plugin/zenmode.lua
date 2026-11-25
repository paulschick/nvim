vim.keymap.set("n", "<leader>zz", function()
    require("zen-mode").setup {
        window = {
            width = 120,
            options = { }
        },
    }
    require("zen-mode").toggle()
    vim.wo.wrap = vim.bo.filetype == 'markdown'
    vim.wo.number = true
    vim.wo.rnu = true
    ColorMe()
end)


vim.keymap.set("n", "<leader>zZ", function()
    require("zen-mode").setup {
        window = {
            width = 80,
            options = { }
        },
    }
    require("zen-mode").toggle()
    vim.wo.wrap = vim.bo.filetype == 'markdown'
    vim.wo.number = false
    vim.wo.rnu = false
    vim.opt.colorcolumn = "0"
    ColorMe()
end)
