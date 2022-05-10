-- local colorscheme = "tokyonight"
local colorscheme = "nightfox"

local palette = {
  nightfox = {
    pale_red = '#E06C75',
    dark_red = '#be5046',
    light_red = '#c43e1f',
    dark_orange = '#FF922B',
    green = '#98c379',
    bright_yellow = '#FAB005',
    light_yellow = '#e5c07b',
    dark_blue = '#4e88ff',
    magenta = '#c678dd',
    comment_grey = '#5c6370',
    grey = '#3E4556',
    whitesmoke = '#626262',
    bright_blue = '#51afef',
    teal = '#15AABF',
  }
}

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
  vim.notify("colorscheme " .. colorscheme .. " not found!")
  return
end

require("nightfox").setup({ palettes = palette })

