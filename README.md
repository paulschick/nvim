# Neovim Configuration

A modern, modular Neovim configuration built with Lua, focusing on IDE-like features for software development with support for multiple languages.

## Overview

This configuration provides a complete development environment with LSP support, fuzzy finding, Git integration, and comprehensive syntax highlighting. It uses `lazy.nvim` as the plugin manager and follows a modular architecture for easy maintenance and customization.

**Neovim Version:** v0.11.4

## Features

- **Modern Plugin Manager:** `lazy.nvim` with automatic installation and lazy loading
- **LSP Integration:** Full Language Server Protocol support with Mason for easy server management
- **Intelligent Completion:** `nvim-cmp` with LSP, buffer, path, and snippet sources
- **Fuzzy Finding:** Telescope for files, buffers, grep, and more
- **Syntax Highlighting:** Tree-sitter with 18+ language parsers
- **Git Integration:** vim-fugitive and gitsigns for comprehensive Git workflow
- **File Explorer:** nvim-tree with icons and Git integration
- **Status Line:** lualine with informative status information
- **Code Formatting:** Automatic formatting on save via LSP
- **Smart Editing:** Auto-pairs, indent guides, commenting support
- **Custom UI:** Rose Pine color scheme, floating windows with rounded borders
- **Built-in Cheat Sheet:** Interactive keybinding reference (`<leader>?`)

## Supported Languages

Language servers configured and ready to use:

- **Lua** (`lua_ls`) - Configured with Neovim runtime integration
- **TypeScript/JavaScript** (`ts_ls`) - Full support for JS/TS projects
- **Rust** (`rust_analyzer`) - Complete Rust development setup
- **Bash/Shell** (`bashls`) - Shell scripting support
- **Go** (`gopls`) - Go development with full LSP features

Additional syntax support via Tree-sitter: Python, JSON, YAML, TOML, Markdown, HTML, CSS, and more.

## Directory Structure

```
~/.config/nvim/
├── init.lua                    # Entry point
├── lazy-lock.json              # Plugin version lock file
├── lua/paul/
│   ├── init.lua                # Module loader
│   ├── lazy.lua                # Plugin definitions
│   ├── remap.lua               # Custom keymaps
│   ├── set.lua                 # Editor settings
│   └── cheatsheet.lua          # Interactive cheat sheet
├── after/plugin/               # Plugin-specific configurations
│   ├── lsp.lua                 # LSP and completion setup
│   ├── telescope.lua           # Fuzzy finder keymaps
│   ├── treesitter.lua          # Syntax highlighting
│   ├── nvim-tree.lua           # File explorer
│   ├── colors.lua              # Color scheme
│   ├── lualine.lua             # Status line
│   ├── gitsigns.lua            # Git signs and hunks
│   ├── autopairs.lua           # Auto-closing brackets
│   ├── indent-blankline.lua    # Indent guides
│   ├── fidget.lua              # LSP progress
│   ├── zenmode.lua             # Distraction-free mode
│   ├── undotree.lua            # Undo history
│   ├── fugitive.lua            # Git integration
│   └── devicons.lua            # File icons
└── docs/
    └── neovim-lua.md           # Lua API reference
```

## Installation

### Prerequisites

- Neovim v0.9.0 or higher (v0.11.4 recommended)
- Git
- A terminal with true color support
- A [Nerd Font](https://www.nerdfonts.com/) for icons (optional but recommended)
- ripgrep (for Telescope live grep)
- A C compiler (for Tree-sitter parsers)

### Quick Start

1. **Backup existing configuration** (if any):
   ```bash
   mv ~/.config/nvim ~/.config/nvim.backup
   mv ~/.local/share/nvim ~/.local/share/nvim.backup
   ```

2. **Clone this configuration:**
   ```bash
   git clone <your-repo-url> ~/.config/nvim
   ```

3. **Launch Neovim:**
   ```bash
   nvim
   ```

4. **Wait for automatic setup:**
   - `lazy.nvim` will install automatically
   - All plugins will be installed
   - LSP servers will be installed via Mason
   - Tree-sitter parsers will be compiled

5. **Verify installation:**
   ```vim
   :checkhealth
   :Lazy
   :Mason
   ```

## Key Mappings

**Leader key:** `<Space>`

### Quick Reference

Press `<leader>?` to open the built-in interactive cheat sheet with all keybindings.

### Essential Mappings

#### General
- `<Space>` - Leader key
- `jk` - Exit insert mode
- `<Esc>` - Clear search highlighting
- `<leader>w` - Toggle word wrap
- `<leader>f` - Format buffer using LSP
- `<leader>?` - Toggle cheat sheet

#### Navigation
- `<C-d>` / `<C-u>` - Half-page down/up (cursor centered)
- `n` / `N` - Next/previous search result (centered)
- `J` / `K` (visual) - Move selected lines down/up

#### Clipboard
- `<leader>y` - Yank to system clipboard
- `<leader>Y` - Yank line to system clipboard
- `<leader>p` - Paste without overwriting register
- `<leader>d` - Delete to void register

#### Telescope (Fuzzy Finder)
- `<leader>pf` - Find files
- `<leader>pg` - Find Git files
- `<leader>pb` - Find buffers
- `<leader>pl` - Live grep
- `<leader>ph` - Find help tags
- `<leader>ps` - Grep search with prompt

#### File Explorer
- `<leader>e` - Toggle nvim-tree
- `<leader>ef` - Find current file in tree
- `<leader>pv` - Open built-in file explorer

#### LSP (Code Intelligence)
- `gd` - Go to definition
- `gD` - Go to declaration
- `gi` - Go to implementation
- `K` - Hover documentation
- `<C-h>` - Signature help
- `[d` / `]d` - Previous/next diagnostic
- `<leader>vd` - Open diagnostic float
- `<leader>vca` - Code action
- `<leader>vrr` - Find references
- `<leader>vrn` - Rename symbol

#### Git
- `<leader>gs` - Git status (fugitive)
- `<leader>gc` - Git commits (Telescope)
- `<leader>gb` - Git branches (Telescope)
- `]c` / `[c` - Next/previous hunk
- `<leader>hp` - Preview hunk
- `<leader>hs` - Stage hunk
- `<leader>hr` - Reset hunk
- `<leader>hb` - Blame line
- `<leader>tb` - Toggle line blame

#### Utilities
- `<leader>u` - Toggle undo tree
- `<leader>zz` - Zen mode (120 width)
- `gcc` - Toggle line comment
- `gc` (visual) - Toggle block comment

#### Completion (Insert Mode)
- `<C-Space>` - Trigger completion
- `<C-n>` / `<C-p>` - Next/previous item
- `<C-y>` - Confirm selection
- `<C-e>` - Abort completion

## Plugin List

### Core
- [lazy.nvim](https://github.com/folke/lazy.nvim) - Modern plugin manager
- [plenary.nvim](https://github.com/nvim-lua/plenary.nvim) - Lua utility library

### UI & Themes
- [rose-pine](https://github.com/rose-pine/neovim) - Soho vibes color scheme
- [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim) - Fast status line
- [nvim-web-devicons](https://github.com/nvim-tree/nvim-web-devicons) - File icons
- [zen-mode.nvim](https://github.com/folke/zen-mode.nvim) - Distraction-free coding

### Navigation & Search
- [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) - Fuzzy finder
- [nvim-tree.lua](https://github.com/nvim-tree/nvim-tree.lua) - File explorer

### Syntax & Highlighting
- [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) - Better syntax

### LSP & Completion
- [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) - LSP configurations
- [mason.nvim](https://github.com/williamboman/mason.nvim) - LSP server manager
- [mason-lspconfig.nvim](https://github.com/williamboman/mason-lspconfig.nvim) - Mason-LSP bridge
- [nvim-cmp](https://github.com/hrsh7th/nvim-cmp) - Completion engine
- [cmp-nvim-lsp](https://github.com/hrsh7th/cmp-nvim-lsp) - LSP completion source
- [cmp-buffer](https://github.com/hrsh7th/cmp-buffer) - Buffer completion
- [cmp-path](https://github.com/hrsh7th/cmp-path) - Path completion
- [cmp-cmdline](https://github.com/hrsh7th/cmp-cmdline) - Command-line completion
- [LuaSnip](https://github.com/L3MON4D3/LuaSnip) - Snippet engine
- [friendly-snippets](https://github.com/rafamadriz/friendly-snippets) - Snippet collection
- [cmp_luasnip](https://github.com/saadparwaiz1/cmp_luasnip) - LuaSnip completion
- [lspkind.nvim](https://github.com/onsails/lspkind.nvim) - LSP completion icons
- [fidget.nvim](https://github.com/j-hui/fidget.nvim) - LSP progress UI

### Git
- [vim-fugitive](https://github.com/tpope/vim-fugitive) - Git commands
- [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) - Git decorations

### Editing
- [nvim-autopairs](https://github.com/windwp/nvim-autopairs) - Auto-close brackets
- [indent-blankline.nvim](https://github.com/lukas-reineke/indent-blankline.nvim) - Indent guides
- [Comment.nvim](https://github.com/numToStr/Comment.nvim) - Smart commenting

### Utilities
- [undotree](https://github.com/mbbill/undotree) - Undo history visualizer
- [editorconfig-vim](https://github.com/editorconfig/editorconfig-vim) - EditorConfig support

## Configuration Files

### Core Configuration

- **init.lua** - Entry point that loads the main configuration module
- **lua/paul/init.lua** - Loads lazy.nvim, keymaps, and settings
- **lua/paul/lazy.lua** - Plugin definitions and lazy.nvim setup
- **lua/paul/remap.lua** - All custom keymaps (120 lines of mappings)
- **lua/paul/set.lua** - Editor settings and options
- **lua/paul/cheatsheet.lua** - Interactive keybinding reference system

### Plugin Configurations

All plugin-specific configurations are in `after/plugin/` and load automatically after plugins are installed:

- **lsp.lua** - Complete LSP setup with 5 language servers, completion, and format-on-save
- **telescope.lua** - Fuzzy finder keymaps for files, buffers, and grep
- **treesitter.lua** - Syntax highlighting with 18 parsers and incremental selection
- **nvim-tree.lua** - File explorer setup with Git integration
- **gitsigns.lua** - Git gutter signs and hunk operations
- **colors.lua** - Rose Pine color scheme configuration
- **lualine.lua** - Status line with Git, LSP, and file information
- **autopairs.lua** - Auto-closing brackets and quotes
- **indent-blankline.lua** - Visual indent guides
- **fidget.nvim** - LSP loading progress indicator
- **zenmode.lua** - Distraction-free writing mode
- **undotree.lua** - Undo tree visualization
- **fugitive.lua** - Git status keymap
- **devicons.lua** - File type icons configuration

## Customization

### Adding a New Language Server

1. Add the server name to Mason's `ensure_installed` in `after/plugin/lsp.lua`:
   ```lua
   ensure_installed = {
       'lua_ls',
       'ts_ls',
       'your_new_server',
   },
   ```

2. Configure the server:
   ```lua
   vim.lsp.config('your_new_server', {
       cmd = { 'your-server-command' },
       filetypes = { 'your-filetype' },
       root_markers = { '.git' },
       capabilities = capabilities,
       on_attach = on_attach,
   })
   vim.lsp.enable('your_new_server')
   ```

3. Restart Neovim and run `:Mason` to install the server

### Adding a New Plugin

1. Add the plugin to `lua/paul/lazy.lua`:
   ```lua
   {
       'author/plugin-name',
       dependencies = { 'any/dependencies' },
       config = function()
           require('plugin-name').setup({
               -- configuration here
           })
       end
   },
   ```

2. Create a configuration file in `after/plugin/` if complex setup is needed

3. Restart Neovim or run `:Lazy sync`

### Changing Color Scheme

Edit `after/plugin/colors.lua`:
```lua
vim.cmd('colorscheme your-preferred-theme')
```

### Modifying Keymaps

Edit `lua/paul/remap.lua` to add or modify keybindings:
```lua
vim.keymap.set('n', '<leader>x', function()
    -- your function here
end, { desc = 'Description for cheat sheet' })
```

### Adjusting Editor Settings

Edit `lua/paul/set.lua` to modify editor behavior:
```lua
vim.opt.tabstop = 2        -- Change tab width
vim.opt.wrap = true        -- Enable line wrapping
vim.opt.colorcolumn = '100' -- Change column guide
```

## Performance

This configuration includes several performance optimizations:

- **Lazy Loading:** Plugins load on-demand via lazy.nvim
- **Disabled Built-ins:** Unnecessary default plugins are disabled (gzip, tar, netrw, etc.)
- **Smart Highlighting:** Tree-sitter automatically disables in files >100KB
- **Fast Update Time:** 50ms update time for quick feedback
- **No Swap Files:** Disabled for better performance (persistent undo is used instead)

## Troubleshooting

### LSP Not Working

```vim
:LspInfo          " Check LSP server status
:Mason            " Verify servers are installed
:checkhealth lsp  " Run LSP health check
```

### Plugins Not Loading

```vim
:Lazy             " Open plugin manager
:Lazy sync        " Synchronize plugins
:Lazy clean       " Remove unused plugins
```

### Tree-sitter Issues

```vim
:TSUpdate         " Update all parsers
:TSInstall <lang> " Install specific parser
:checkhealth nvim-treesitter
```

### Icons Not Showing

Install a Nerd Font and configure your terminal to use it. Recommended fonts:
- JetBrainsMono Nerd Font
- FiraCode Nerd Font
- Hack Nerd Font

### General Health Check

```vim
:checkhealth      " Run all health checks
```

## Useful Commands

- `:Lazy` - Open plugin manager UI
- `:Mason` - Open LSP server manager
- `:TSUpdate` - Update Tree-sitter parsers
- `:LspInfo` - Show attached LSP servers
- `:checkhealth` - Run Neovim health checks
- `:Telescope` - Open Telescope picker
- `:NvimTreeToggle` - Toggle file explorer
- `:UndotreeToggle` - Open undo tree
- `:Git` - Open vim-fugitive

## Configuration Philosophy

This configuration follows these principles:

1. **Modular Design:** Separate files for different concerns (plugins, keymaps, settings)
2. **Lua-First:** Pure Lua configuration for better performance and integration
3. **IDE-like Features:** Full LSP, completion, and debugging support
4. **Ergonomic Keybindings:** Consistent, memorable keymaps with leader key patterns
5. **Visual Feedback:** Clear UI with status line, Git signs, and diagnostic indicators
6. **Performance:** Lazy loading and optimizations for fast startup
7. **Documentation:** Inline comments and built-in cheat sheet for discoverability
8. **Extensibility:** Easy to add new languages and plugins

## Contributing

This is a personal configuration, but feel free to fork and adapt it to your needs. If you find issues or have suggestions, please open an issue or pull request.

## License

This configuration is provided as-is for educational and personal use.

## Resources

- [Neovim Documentation](https://neovim.io/doc/)
- [Lua Guide](https://neovim.io/doc/user/lua-guide.html)
- [lazy.nvim](https://github.com/folke/lazy.nvim)
- [LSP Configuration](https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md)
- [Telescope](https://github.com/nvim-telescope/telescope.nvim)
- [Tree-sitter](https://github.com/nvim-treesitter/nvim-treesitter)

## Acknowledgments

This configuration is inspired by various Neovim configurations in the community, particularly:
- ThePrimeagen's Neovim setup
- TJ DeVries's Neovim configuration
- The Neovim community on GitHub and Reddit
