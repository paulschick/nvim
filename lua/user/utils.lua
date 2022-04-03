local utils = {}

utils.bufmap = function(bufnr, mode, key, result)
	local opts = { noremap = true, silent = true }
	vim.api.nvim_buf_set_keymap(bufnr, mode, key, "<cmd> " .. result .. "<CR>", opts)
end

return utils
