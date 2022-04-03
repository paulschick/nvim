local status_ok, npairs = pcall(require, "nvim-autopairs")
if not status_ok then
	print("Unable to load nvim-autopairs")
	return
end

--[[
    This is treesitter aware. Look at the README for general
    configuration settings.
    https://github.com/windwp/nvim-autopairs
    you configure the file types, configure the types of
    elements that this is going to work with.

        Fast Wrap
    this is going to show some characters on your line. When
    you press one of the characters, that's where the ending
    element will go.
    If the mapping is <M-e>, that should be ALT + e to do this,
    after placing the first character in insert mode.
--]]
npairs.setup({
	-- ts -> treesitter
	check_ts = true,
	ts_config = {
		lua = { "string", "source" },
		javascript = { "string", "template_string" },
		java = false,
	},
	disable_filetype = { "TelescopePrompt", "spectre_panel" },
	fast_wrap = {
		-- should be ALT + e
		map = "<M-e>",
		chars = { "{", "[", "(", '"', "'" },
		pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
		offset = 0, --offset from pattern match
		end_key = "$", -- $ will always be the furthest ending char
		keys = "qwertyuiopzxcvbnmasdfghjkl",
		check_comma = true,
		highlight = "PmenuSel",
		highlight_grey = "LineNr",
	},
})

local cmp_autopairs = require("nvim-autopairs.completion.cmp")
local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
	print("From autopairs.lua -> cmp_status_ok is FALSE")
	return
end
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done({ map_char = { tex = "" } }))
