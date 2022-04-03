local status_ok, comment = pcall(require, "Comment")
if not status_ok then
	print("unable to load comment")
end

--[[
    https://github.com/numToStr/Comment.nvim

    - toggler: applies to normal and visual mapping
--]]
comment.setup({
	toggler = {
		-- line-comment toggle keymap
		line = "<C-_>", -- NOTE: <C-_> maps to CTRL + /, just like in most IDEs.
		-- Block-comment toggle keymap
		block = "<Leader>bb",
	},

	-- operator-pending mappings in n + v
	-- so like when you have multiple lines selected
	opleader = {
		-- line-comment keymap
		line = "<Leader>t",
		-- Block-comment keymap
		block = "<Leader>bb",
	},
})
