# Neovim Configuration Fixes and Improvements

This document outlines all the required fixes, potential issues, and improvements needed to make this Neovim configuration bulletproof.

## Critical Issues

### 1. **Deprecated API Usage in cheatsheet.lua** ✅ RESOLVED

**Location:** `lua/paul/cheatsheet.lua:157-161`

**Issue:** Using deprecated `vim.api.nvim_buf_set_option()` and `vim.api.nvim_win_set_option()` functions. These are deprecated in Neovim 0.10+ and will be removed in future versions.

**Status:** FIXED - Replaced with `vim.bo[buf]` and `vim.wo[win]` syntax.

**Current Code:**
```lua
vim.api.nvim_buf_set_option(buf, 'modifiable', false)
vim.api.nvim_buf_set_option(buf, 'bufhidden', 'wipe')
vim.api.nvim_buf_set_option(buf, 'buftype', 'nofile')
vim.api.nvim_buf_set_option(buf, 'swapfile', false)
vim.api.nvim_buf_set_option(buf, 'filetype', 'cheatsheet')

vim.api.nvim_win_set_option(win, 'wrap', false)
vim.api.nvim_win_set_option(win, 'cursorline', true)
```

**Fix:**
```lua
-- Use vim.bo for buffer options
vim.bo[buf].modifiable = false
vim.bo[buf].bufhidden = 'wipe'
vim.bo[buf].buftype = 'nofile'
vim.bo[buf].swapfile = false
vim.bo[buf].filetype = 'cheatsheet'

-- Use vim.wo for window options
vim.wo[win].wrap = false
vim.wo[win].cursorline = true
```

**Severity:** High - Will break in future Neovim versions

---

### 2. **Keymap Conflict: `<leader>w`** ✅ RESOLVED

**Location:** `lua/paul/remap.lua:5` and `lua/paul/remap.lua:104`

**Issue:** The `<leader>w` keymap is defined twice with different functions:
- Line 5: Maps to `<C-w>` for window commands
- Line 104: Toggles word wrap

**Status:** FIXED - Changed word wrap toggle to `<leader>tw`. Window commands remain on `<leader>w`.

**Current Code:**
```lua
-- Line 5
vim.keymap.set('n', '<leader>w', '<C-w>')

-- Line 104
vim.keymap.set('n', '<leader>w', function()
    vim.wo.wrap = not vim.wo.wrap
end, { desc = "Toggle word wrap" })
```

**Impact:** The second mapping overwrites the first. Window commands using `<leader>w` won't work; only word wrap toggle will function.

**Fix Options:**

**Option 1 - Change word wrap key (Recommended):**
```lua
-- Keep window commands on <leader>w
vim.keymap.set('n', '<leader>w', '<C-w>')

-- Move word wrap to different key
vim.keymap.set('n', '<leader>tw', function()
    vim.wo.wrap = not vim.wo.wrap
end, { desc = "Toggle word wrap" })
```

**Option 2 - Change window commands key:**
```lua
-- Move window commands to <leader>ww or different key
vim.keymap.set('n', '<leader>ww', '<C-w>')

-- Keep word wrap on <leader>w
vim.keymap.set('n', '<leader>w', function()
    vim.wo.wrap = not vim.wo.wrap
end, { desc = "Toggle word wrap" })
```

**Severity:** High - Core functionality broken (window navigation)

---

### 3. **Legacy packer_compiled.lua File** ✅ RESOLVED

**Location:** `plugin/packer_compiled.lua`

**Issue:** This file is leftover from the old packer.nvim plugin manager and is no longer needed. It can cause confusion and may interfere with lazy.nvim.

**Status:** FIXED - File has been removed.

**Fix:**
```bash
rm ~/.config/nvim/plugin/packer_compiled.lua
```

Or add to .gitignore if using version control:
```gitignore
plugin/packer_compiled.lua
```

**Severity:** Medium - Not critical but should be cleaned up

---

### 4. **Disabled matchparen Plugin** ✅ RESOLVED

**Location:** `lua/paul/lazy.lua:127`

**Issue:** The `matchparen` plugin is disabled in the performance optimizations. This plugin highlights matching brackets/parentheses, which is extremely useful for coding.

**Status:** FIXED - Removed matchparen from the disabled_plugins list. Bracket matching is now enabled.

**Current Code:**
```lua
disabled_plugins = {
    "gzip",
    "matchit",
    "matchparen",  -- This should NOT be disabled
    "netrwPlugin",
    "tarPlugin",
    "tohtml",
    "tutor",
    "zipPlugin",
},
```

**Fix:**
```lua
disabled_plugins = {
    "gzip",
    "matchit",
    -- "matchparen",  -- Keep this enabled for bracket matching
    "netrwPlugin",
    "tarPlugin",
    "tohtml",
    "tutor",
    "zipPlugin",
},
```

**Severity:** Medium - Reduces code readability

---

### 5. **Potential LSP Format-on-Save Race Condition** ✅ RESOLVED

**Location:** `after/plugin/lsp.lua:163-169`

**Issue:** Format-on-save uses `async = false` which blocks, but there's no error handling if LSP server is slow or unavailable. This can cause noticeable delays when saving files.

**Status:** FIXED - Now only formats if LSP client is attached. Added `:ToggleFormatOnSave` command to enable/disable formatting.

**Current Code:**
```lua
vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*",
    callback = function()
        vim.lsp.buf.format({ async = false })
    end,
})
```

**Issues:**
- No timeout configured
- No way to disable for specific file types
- No error handling
- Applies to ALL files, even those without LSP

**Fix:**
```lua
-- Format on save with timeout and error handling
vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*",
    callback = function()
        -- Only format if LSP client is attached
        local clients = vim.lsp.get_clients({ bufnr = 0 })
        if #clients > 0 then
            vim.lsp.buf.format({
                async = false,
                timeout_ms = 1000,  -- 1 second timeout
            })
        end
    end,
})

-- Optional: Add a command to toggle format-on-save
vim.g.format_on_save = true

vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*",
    callback = function()
        if not vim.g.format_on_save then return end

        local clients = vim.lsp.get_clients({ bufnr = 0 })
        if #clients > 0 then
            vim.lsp.buf.format({
                async = false,
                timeout_ms = 1000,
            })
        end
    end,
})

-- Toggle command
vim.api.nvim_create_user_command('ToggleFormatOnSave', function()
    vim.g.format_on_save = not vim.g.format_on_save
    print('Format on save: ' .. tostring(vim.g.format_on_save))
end, {})
```

**Severity:** Medium - Can cause performance issues

---

## Moderate Issues

### 6. **Missing Telescope Configuration Options**

**Location:** `after/plugin/telescope.lua`

**Issue:** Telescope is using default settings without customization for better performance and UX.

**Fix:**
Add telescope setup with optimized defaults:

```lua
local builtin = require('telescope.builtin')
local telescope = require('telescope')

telescope.setup({
    defaults = {
        file_ignore_patterns = {
            "node_modules",
            ".git/",
            "dist/",
            "build/",
            "target/",
            "*.lock",
        },
        mappings = {
            i = {
                ["<C-j>"] = "move_selection_next",
                ["<C-k>"] = "move_selection_previous",
                ["<C-q>"] = "send_to_qflist",
                ["<C-u>"] = false,  -- Clear prompt instead of preview scroll
            },
        },
        layout_config = {
            horizontal = {
                preview_width = 0.55,
                prompt_position = "top",
            },
        },
        sorting_strategy = "ascending",
    },
    pickers = {
        find_files = {
            hidden = true,  -- Show hidden files
        },
    },
})

-- Rest of keymaps...
```

**Severity:** Low - Nice to have improvements

---

### 7. **Missing Error Handling in LSP Configuration**

**Location:** `after/plugin/lsp.lua:45-101`

**Issue:** LSP server configurations don't verify if servers are actually installed before enabling them.

**Fix:**
Add existence checks:

```lua
-- Helper function to safely enable LSP
local function safe_enable_lsp(server_name)
    local ok, _ = pcall(vim.lsp.enable, server_name)
    if not ok then
        vim.notify(
            'Failed to enable LSP server: ' .. server_name,
            vim.log.levels.WARN
        )
    end
end

-- Then use it:
safe_enable_lsp('lua_ls')
safe_enable_lsp('bashls')
safe_enable_lsp('ts_ls')
safe_enable_lsp('rust_analyzer')
safe_enable_lsp('gopls')
```

**Severity:** Low - Mason handles installation, but explicit checks are better

---

### 8. **No Protection Against Tree-sitter Query Errors**

**Location:** `after/plugin/treesitter.lua:29-40`

**Issue:** Tree-sitter highlight can fail on malformed files or query errors without graceful degradation.

**Fix:**
Add additional error handling:

```lua
highlight = {
    enable = true,
    disable = function(lang, buf)
        local max_filesize = 100 * 1024 -- 100 KB
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
            return true
        end
        return false
    end,
    additional_vim_regex_highlighting = false,
},
```

**Severity:** Low - Rare edge case

---

### 9. **Incomplete nvim-cmp Setup for Cmdline Mode**

**Location:** `after/plugin/lsp.lua:134-148`

**Issue:** Cmdline completion doesn't include all useful sources like buffer history.

**Enhancement:**
```lua
-- Enhanced search completion (/)
cmp.setup.cmdline('/', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = 'buffer' }
    }),
    formatting = {
        fields = { "abbr" },
    },
})

-- Enhanced command completion (:)
cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = 'path' }
    }, {
        {
            name = 'cmdline',
            option = {
                ignore_cmds = { 'Man', '!' }
            }
        }
    }),
    formatting = {
        fields = { "abbr" },
    },
})
```

**Severity:** Low - Enhancement

---

### 10. **Hardcoded Undo Directory Path** ✅ RESOLVED

**Location:** `lua/paul/set.lua:18`

**Issue:** Uses hardcoded path `~/.vim/undodir` which may not exist, causing errors.

**Status:** FIXED - Now uses `vim.fn.stdpath('data') .. '/undodir'` and creates the directory if it doesn't exist.

**Current Code:**
```lua
vim.opt.undodir = os.getenv('HOME') .. '/.vim/undodir'
vim.opt.undofile = true
```

**Fix:**
```lua
-- Create undo directory if it doesn't exist
local undodir = vim.fn.stdpath('data') .. '/undodir'
if vim.fn.isdirectory(undodir) == 0 then
    vim.fn.mkdir(undodir, 'p')
end
vim.opt.undodir = undodir
vim.opt.undofile = true
```

**Severity:** Medium - Can cause errors if directory doesn't exist

---

## Minor Issues and Improvements

### 11. **Commented-Out Harpoon Configuration**

**Location:** `after/plugin/harpoon.lua`

**Issue:** Entire file is commented out, suggesting incomplete migration or abandoned feature.

**Fix Options:**
1. If Harpoon is not needed: Remove the plugin from `lazy.lua` and delete `harpoon.lua`
2. If needed later: Keep as-is with a comment explaining why it's disabled
3. If needed now: Uncomment and update to latest Harpoon 2.0 API

**Recommended Action:**
Remove from `lazy.lua` if not in active use:
```lua
-- Remove this if not using Harpoon:
-- 'ThePrimeagen/harpoon',
```

**Severity:** Low - Just cleanup

---

### 12. **Missing LSP Server-Specific Settings**

**Location:** `after/plugin/lsp.lua`

**Issue:** LSP servers are configured with minimal settings. Many servers have useful options that aren't configured.

**Enhancements:**

**For ts_ls (TypeScript):**
```lua
vim.lsp.config('ts_ls', {
    cmd = { 'typescript-language-server', '--stdio' },
    filetypes = { 'javascript', 'javascriptreact', 'javascript.jsx', 'typescript', 'typescriptreact', 'typescript.tsx' },
    root_markers = { 'package.json', 'tsconfig.json', 'jsconfig.json', '.git' },
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
        typescript = {
            inlayHints = {
                includeInlayParameterNameHints = 'all',
                includeInlayFunctionParameterTypeHints = true,
                includeInlayVariableTypeHints = true,
            },
        },
        javascript = {
            inlayHints = {
                includeInlayParameterNameHints = 'all',
                includeInlayFunctionParameterTypeHints = true,
                includeInlayVariableTypeHints = true,
            },
        },
    },
})
```

**For rust_analyzer:**
```lua
vim.lsp.config('rust_analyzer', {
    cmd = { 'rust-analyzer' },
    filetypes = { 'rust' },
    root_markers = { 'Cargo.toml', 'rust-project.json', '.git' },
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
        ['rust-analyzer'] = {
            checkOnSave = {
                command = 'clippy',
            },
            cargo = {
                allFeatures = true,
            },
        },
    },
})
```

**Severity:** Low - Nice to have

---

### 13. **No Lazy Loading Configuration**

**Location:** `lua/paul/lazy.lua`

**Issue:** Most plugins load immediately rather than lazy loading based on events, commands, or file types.

**Optimization:**
```lua
-- Examples of lazy loading:
{
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    cmd = 'Telescope',  -- Load on :Telescope command
    keys = {
        { '<leader>pf', '<cmd>Telescope find_files<cr>', desc = 'Find files' },
        { '<leader>pg', '<cmd>Telescope git_files<cr>', desc = 'Git files' },
    },
    dependencies = { 'nvim-lua/plenary.nvim' }
},

{
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    event = { 'BufReadPost', 'BufNewFile' },  -- Load on file open
},

{
    'numToStr/Comment.nvim',
    keys = {
        { 'gcc', mode = 'n', desc = 'Comment line' },
        { 'gc', mode = 'v', desc = 'Comment block' },
    },
    config = function()
        require('Comment').setup()
    end
},
```

**Severity:** Low - Performance optimization

---

### 14. **No Diagnostic Configuration for Sign Column**

**Location:** `after/plugin/lsp.lua:151-161`

**Issue:** Diagnostic signs are completely disabled, making it harder to spot errors in the gutter.

**Current Code:**
```lua
vim.diagnostic.config({
    signs = false,  -- This removes all gutter indicators
    virtual_text = true,
    ...
})
```

**Better Approach:**
```lua
-- Define custom diagnostic signs
local signs = {
    Error = "E",
    Warn = "W",
    Hint = "H",
    Info = "I"
}

for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

vim.diagnostic.config({
    signs = true,  -- Enable signs in gutter
    virtual_text = {
        prefix = '●',
        spacing = 4,
    },
    update_in_insert = false,
    underline = true,
    severity_sort = true,
    float = {
        border = 'rounded',
        source = 'always',
        header = '',
        prefix = '',
    },
})
```

**Severity:** Low - UX improvement

---

### 15. **Missing Telescope Extensions**

**Location:** `lua/paul/lazy.lua` and `after/plugin/telescope.lua`

**Issue:** Telescope has useful extensions that aren't installed (fzf-native for better performance, file browser, etc.)

**Enhancement:**
```lua
-- In lazy.lua, add:
{
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    dependencies = {
        'nvim-lua/plenary.nvim',
        {
            'nvim-telescope/telescope-fzf-native.nvim',
            build = 'make',
        },
    }
},

-- In telescope.lua, add:
require('telescope').load_extension('fzf')
```

**Severity:** Low - Performance enhancement

---

### 16. **No Treesitter Text Objects Configuration**

**Location:** `after/plugin/treesitter.lua`

**Issue:** Missing text objects module which provides powerful text manipulation (like `vif` for inside function, `vac` for around class, etc.)

**Enhancement:**
```lua
-- Add to lazy.lua:
'nvim-treesitter/nvim-treesitter-textobjects',

-- Add to treesitter.lua:
textobjects = {
    select = {
        enable = true,
        lookahead = true,
        keymaps = {
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["ac"] = "@class.outer",
            ["ic"] = "@class.inner",
            ["aa"] = "@parameter.outer",
            ["ia"] = "@parameter.inner",
        },
    },
    move = {
        enable = true,
        set_jumps = true,
        goto_next_start = {
            ["]f"] = "@function.outer",
            ["]c"] = "@class.outer",
        },
        goto_previous_start = {
            ["[f"] = "@function.outer",
            ["[c"] = "@class.outer",
        },
    },
},
```

**Severity:** Low - Powerful feature addition

---

### 17. **Incremental Selection Using `<CR>` May Conflict**

**Location:** `after/plugin/treesitter.lua:49-50`

**Issue:** Using `<CR>` (Enter) for incremental selection in visual mode can conflict with other mappings and is non-standard.

**Current Code:**
```lua
init_selection = '<CR>',
node_incremental = '<CR>',
```

**Better Alternative:**
```lua
init_selection = 'gnn',
node_incremental = 'grn',
scope_incremental = 'grc',
node_decremental = 'grm',
```

**Severity:** Low - Preference

---

### 18. **No Loading State Indicator**

**Issue:** Users don't get feedback when LSP servers are starting or plugins are loading.

**Enhancement:**
Already using fidget.nvim for LSP progress, but could add:

```lua
-- In lazy.lua, enhance fidget config:
{
    'j-hui/fidget.nvim',
    opts = {
        notification = {
            window = {
                winblend = 0,
                border = "rounded",
            },
        },
        progress = {
            display = {
                done_icon = "✓",
                progress_icon = { pattern = "dots", period = 1 },
            },
        },
    },
},
```

**Severity:** Low - UX enhancement

---

### 19. **nvim-tree Configuration Could Be Enhanced**

**Location:** `after/plugin/nvim-tree.lua`

**Enhancement:**
```lua
require("nvim-tree").setup({
    sort_by = "case_sensitive",
    view = {
        width = 30,
        side = "left",
    },
    renderer = {
        group_empty = true,
        highlight_git = true,
        highlight_opened_files = "name",
        icons = {
            show = {
                file = true,
                folder = true,
                folder_arrow = true,
                git = true,
            },
        },
    },
    filters = {
        dotfiles = false,
        custom = { "^.git$", "node_modules", ".cache" },
    },
    git = {
        enable = true,
        ignore = false,
    },
    actions = {
        open_file = {
            quit_on_open = false,
            window_picker = {
                enable = true,
            },
        },
    },
    update_focused_file = {
        enable = true,
        update_root = false,
    },
})
```

**Severity:** Low - UX improvements

---

### 20. **Missing Which-Key Plugin**

**Issue:** While you have a custom cheat sheet, the popular `which-key.nvim` plugin provides real-time key binding hints as you type.

**Optional Enhancement:**
```lua
-- Add to lazy.lua:
{
    'folke/which-key.nvim',
    event = 'VeryLazy',
    config = function()
        require('which-key').setup({
            window = {
                border = "rounded",
            },
        })
    end
},
```

**Severity:** Low - Nice to have (your cheat sheet is already good)

---

## Configuration Validation Checklist

### Pre-Flight Checks

Run these commands after implementing fixes:

```vim
:checkhealth
:checkhealth lazy
:checkhealth lsp
:checkhealth nvim-treesitter
:Lazy sync
:Mason
:TSUpdate
```

### Testing Protocol

1. **LSP Functionality:**
   - Open a Lua file: `:e test.lua`
   - Verify LSP attaches: `:LspInfo`
   - Test go to definition: `gd`
   - Test hover: `K`
   - Test completion: `<C-Space>` in insert mode
   - Test formatting: `<leader>f`

2. **Keymap Conflicts:**
   - Test window navigation: `<leader>w` then `h/j/k/l`
   - Test word wrap toggle: `<leader>tw` (if using recommended fix)
   - Test cheat sheet: `<leader>?`

3. **Telescope:**
   - Find files: `<leader>pf`
   - Live grep: `<leader>pl`
   - Git files: `<leader>pg`

4. **Git Integration:**
   - Open a git repo file
   - Verify gitsigns in gutter
   - Test hunk navigation: `]c` and `[c`
   - Test fugitive: `<leader>gs`

5. **Completion:**
   - Open any code file
   - Enter insert mode
   - Type and verify LSP completion appears
   - Verify snippet expansion works

6. **Format on Save:**
   - Make changes to a file
   - Save with `:w`
   - Verify file is formatted

---

## Priority Implementation Order

### Immediate (Critical - Fix Now)

1. ✅ **Fix deprecated API in cheatsheet.lua** (Issue #1) - COMPLETED
2. ✅ **Resolve keymap conflict for `<leader>w`** (Issue #2) - COMPLETED
3. ✅ **Add timeout to format-on-save** (Issue #5) - COMPLETED

### Soon (Important - Fix This Week)

4. ✅ **Fix undo directory path** (Issue #10) - COMPLETED
5. ✅ **Remove packer_compiled.lua** (Issue #3) - COMPLETED
6. ✅ **Re-enable matchparen** (Issue #4) - COMPLETED

### Eventually (Nice to Have - When Time Permits)

7. Add Telescope configuration (Issue #6)
8. Add LSP error handling (Issue #7)
9. Enable diagnostic signs (Issue #14)
10. Add lazy loading configuration (Issue #13)
11. Configure Telescope extensions (Issue #15)
12. Add Tree-sitter text objects (Issue #16)
13. Enhance server-specific LSP settings (Issue #12)

### Optional (Consider Based on Workflow)

14. Remove or enable Harpoon (Issue #11)
15. Add Which-Key plugin (Issue #20)
16. Enhance nvim-tree config (Issue #19)
17. Add loading state indicators (Issue #18)

---

## Final Recommendations

### Code Quality

1. **Add a health check script** - Create a custom health check module
2. **Add version pinning** - Consider pinning plugin versions in production
3. **Add unit tests** - Test custom functions like cheatsheet toggle
4. **Document breaking changes** - Keep a CHANGELOG.md

### Performance

1. **Profile startup time:**
   ```bash
   nvim --startuptime startup.log
   ```
   Target: <100ms startup time

2. **Enable lazy loading** - Implement lazy loading for all non-essential plugins

### Maintainability

1. **Split large files** - Consider splitting `lsp.lua` into separate files per server
2. **Extract magic numbers** - Create a `constants.lua` for configurable values
3. **Add type annotations** - Use EmmyLua annotations for better LSP support

### Security

1. **Review plugin sources** - Regularly audit plugins for security issues
2. **Pin versions** - Use specific commits or tags instead of branches
3. **Validate inputs** - Add input validation to custom functions

---

## Conclusion

This configuration is well-structured and functional, but has several issues that should be addressed:

- **3 Critical Issues** requiring immediate attention
- **10 Moderate Issues** that improve stability and UX
- **7 Minor Issues** for optimization and enhancement

After implementing the critical fixes, this will be a robust, bulletproof Neovim configuration suitable for daily development work.

**Estimated Time to Fix All Critical Issues:** 30-45 minutes

**Estimated Time to Implement All Improvements:** 2-3 hours

---

## Support

If you encounter issues after implementing these fixes:

1. Check `:checkhealth` output
2. Review `:messages` for errors
3. Enable debug logging: `:set verbose=9`
4. Check plugin documentation
5. Search GitHub issues for known problems

## References

- [Neovim 0.10 Breaking Changes](https://neovim.io/doc/user/deprecated.html)
- [lazy.nvim Configuration](https://github.com/folke/lazy.nvim#-configuration)
- [LSP Configuration Guide](https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md)
- [Tree-sitter Configuration](https://github.com/nvim-treesitter/nvim-treesitter#modules)
