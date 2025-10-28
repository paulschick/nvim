local builtin = require('telescope.builtin')

-- File pickers
vim.keymap.set('n', '<leader>pf', builtin.find_files, { desc = 'Find files' })
vim.keymap.set('n', '<leader>pg', builtin.git_files, { desc = 'Find git files' })
vim.keymap.set('n', '<leader>pb', builtin.buffers, { desc = 'Find buffers' })
vim.keymap.set('n', '<leader>ph', builtin.help_tags, { desc = 'Find help' })

-- Search
vim.keymap.set('n', '<leader>ps', function ()
	builtin.grep_string({ search = vim.fn.input("Grep > ") })
end, { desc = 'Grep search' })
vim.keymap.set('n', '<leader>pl', builtin.live_grep, { desc = 'Live grep' })

-- LSP pickers
vim.keymap.set('n', '<leader>pr', builtin.lsp_references, { desc = 'LSP references' })
vim.keymap.set('n', '<leader>pd', builtin.diagnostics, { desc = 'Diagnostics' })

-- Git pickers
vim.keymap.set('n', '<leader>gc', builtin.git_commits, { desc = 'Git commits' })
vim.keymap.set('n', '<leader>gb', builtin.git_branches, { desc = 'Git branches' })
