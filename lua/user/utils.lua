local utils = {}

utils.bufmap = function (mode, key, result)
  local opts = { noremap = true, silent = true }
  vim.api.nvim_buf_set_keymap(0, mode, key, "<cmd> " .. result .. "<CR>", opts)
end

return utils
