--[[
	Source:

	https://github.com/rose-pine/neovim
]]--
function ColorMe(color)
	if not color then
		--print('no color set, setting rose-pine') -- Validation that this is running
		color = 'rose-pine'

		require('rose-pine').setup({
			variant = 'moon'
		})
	end

	vim.cmd.colorscheme(color)

	--[[
		Transparency

		vim api - set a highlight group
		https://neovim.io/doc/user/api.html

		If you do Visual instead of Normal,
		then this should set for the visual mode.

		When this is set to 0, then there's no background and neovim is transparent.
	]]--
    -- Uncomment the following lines for transparent background:
	--vim.api.nvim_set_hl(0, 'Normal', { bg = 'none' })
	--vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'none' })
end

ColorMe()
