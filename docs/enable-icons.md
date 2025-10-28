# Enable Icons in Neovim

## Prerequisites

### Install a Nerd Font

1. Download JetBrains Mono Nerd Font:
```bash
mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts
wget https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip
unzip JetBrainsMono.zip
rm JetBrainsMono.zip
fc-cache -fv
```

2. Configure your terminal to use `JetBrainsMono Nerd Font`

## Verify Installation

1. Open Neovim
2. Check if plugin is loaded:
```vim
:lua print(vim.inspect(require('nvim-web-devicons')))
```

3. Verify icons display in:
   - File explorer: `:NvimTreeToggle`
   - Lazy plugin manager: `:Lazy`
   - Statusline (lualine)

## Configuration

Icons are configured in:
- Plugin: `lua/paul/lazy.lua` (lines 79, 85)
- Settings: `after/plugin/devicons.lua`

## Troubleshooting

- If icons show as squares/boxes: Terminal font is not set to a Nerd Font
- If icons are missing: Run `:Lazy sync` to reinstall plugins
- Check terminal supports UTF-8: `echo $LANG` should show `*.UTF-8`
