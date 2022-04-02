--[[
    1. Automatically change directory to open buffer
    2. Have nvimtree root directory change with open buffer

    Resource:
    https://www.reddit.com/r/neovim/comments/qnxf12/cwd_in_nvimtreelua/hjll42b/?context=8&depth=9
--]]
local tree_ok, nvim_tree = pcall(require, 'nvim-tree')
if not tree_ok then
  print('unable to load nvim-tree')
  return
end

vim.g.nvim_tree_respect_buf_cwd = 1

nvim_tree.setup {
  update_focused_file = {
    enable = true,
    update_cwd = true,
  },
}

vim.cmd [[
  autocmd BufEnter * silent! lcd %:p:h
]]
