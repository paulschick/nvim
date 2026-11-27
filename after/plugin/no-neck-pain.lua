-- Center markdown in a narrower column by padding the tab with empty side windows.
-- no-neck-pain works per tab, so turn it on when a markdown buffer is shown in a
-- normal window, and off when a normal window shows anything else.
local nnp = require('no-neck-pain')
local state = require('no-neck-pain.state')

nnp.setup({ width = 100 })

vim.api.nvim_create_autocmd('BufWinEnter', {
	group = vim.api.nvim_create_augroup('paul.markdown-margins', {}),
	callback = function()
		-- Wait for the layout, the filetype and no-neck-pain's own 2 ms debounced
		-- handlers to settle. Toggling sooner races them and they error on a `nil` tab.
		vim.defer_fn(function()
			local win = vim.api.nvim_get_current_win()
			if vim.api.nvim_win_get_config(win).relative ~= '' then return end
			local buf = vim.api.nvim_win_get_buf(win)
			-- File trees, help, quickfix and the side windows leave the layout alone
			if vim.bo[buf].buftype ~= '' or vim.bo[buf].filetype == 'no-neck-pain' then return end

			local want = vim.bo[buf].filetype == 'markdown'
			if want ~= state:is_active_tab_registered() then
				if want then nnp.enable() else nnp.disable() end
			end
		end, 30)
	end,
})
