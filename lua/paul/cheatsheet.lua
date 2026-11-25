local M = {}

-- Cheat sheet content organized by category
local cheatsheet_content = [[
╔═══════════════════════════════════════════════════════════════════════════╗
║                         NEOVIM KEYBINDINGS CHEAT SHEET                    ║
╠═══════════════════════════════════════════════════════════════════════════╣
║                                                                           ║
║  GENERAL                                                                  ║
║  ─────────────────────────────────────────────────────────────────────────║
║  <leader>    = Space                                                      ║
║  jk          = Exit insert mode                                           ║
║  <Esc>       = Clear search highlighting                                  ║
║  <leader>tw  = Toggle word wrap                                           ║
║  <leader>f   = Format buffer (LSP)                                        ║
║  <leader>s   = Search & replace word under cursor                         ║
║  Q           = Disabled (no-op)                                           ║
║                                                                           ║
║  NAVIGATION                                                               ║
║  ─────────────────────────────────────────────────────────────────────────║
║  <C-d>       = Half-page down (cursor centered)                           ║
║  <C-u>       = Half-page up (cursor centered)                             ║
║  n / N       = Next/previous search result (cursor centered)              ║
║  J (visual)  = Move selected line down                                    ║
║  K (visual)  = Move selected line up                                      ║
║  <leader>w   = Window commands (replaces <C-w>)                           ║
║                                                                           ║
║  CLIPBOARD & REGISTERS                                                    ║
║  ─────────────────────────────────────────────────────────────────────────║
║  <leader>y   = Yank to system clipboard                                   ║
║  <leader>Y   = Yank line to system clipboard                              ║
║  <leader>p   = Paste without overwriting register (visual)                ║
║  <leader>d   = Delete to void register (preserve clipboard)               ║
║                                                                           ║
║  TELESCOPE (FUZZY FINDER)                                                 ║
║  ─────────────────────────────────────────────────────────────────────────║
║  <leader>pf  = Find files                                                 ║
║  <leader>pg  = Find git files                                             ║
║  <leader>pb  = Find buffers                                               ║
║  <leader>ph  = Find help tags                                             ║
║  <leader>ps  = Grep search (with prompt)                                  ║
║  <leader>pl  = Live grep                                                  ║
║  <leader>pr  = LSP references                                             ║
║  <leader>pd  = Diagnostics                                                ║
║                                                                           ║
║  FILE EXPLORER                                                            ║
║  ─────────────────────────────────────────────────────────────────────────║
║  <leader>pv  = Toggle file tree (nvim-tree)                               ║
║  g?          = Show nvim-tree help (when tree is open)                    ║
║                                                                           ║
║  LSP (CODE INTELLIGENCE)                                                  ║
║  ─────────────────────────────────────────────────────────────────────────║
║  gd          = Go to definition                                           ║
║  gD          = Go to declaration                                          ║
║  gi          = Go to implementation                                       ║
║  K           = Hover documentation                                        ║
║  <C-h>       = Signature help (normal & insert mode)                      ║
║  [d          = Previous diagnostic                                        ║
║  ]d          = Next diagnostic                                            ║
║  <leader>vd  = Open diagnostic float                                      ║
║  <leader>vca = Code action                                                ║
║  <leader>vrr = Find references                                            ║
║  <leader>vrn = Rename symbol                                              ║
║  <leader>vws = Workspace symbol search                                    ║
║                                                                           ║
║  GIT                                                                      ║
║  ─────────────────────────────────────────────────────────────────────────║
║  <leader>gs  = Git status (fugitive)                                      ║
║  <leader>gc  = Git commits (telescope)                                    ║
║  <leader>gb  = Git branches (telescope)                                   ║
║                                                                           ║
║  GIT HUNKS (GITSIGNS)                                                     ║
║  ─────────────────────────────────────────────────────────────────────────║
║  ]c          = Next git hunk                                              ║
║  [c          = Previous git hunk                                          ║
║  <leader>hp  = Preview hunk                                               ║
║  <leader>hs  = Stage hunk                                                 ║
║  <leader>hr  = Reset hunk                                                 ║
║  <leader>hS  = Stage buffer                                               ║
║  <leader>hR  = Reset buffer                                               ║
║  <leader>hu  = Undo stage hunk                                            ║
║  <leader>hb  = Blame line                                                 ║
║  <leader>tb  = Toggle line blame                                          ║
║  <leader>hd  = Diff this                                                  ║
║  <leader>td  = Toggle deleted                                             ║
║                                                                           ║
║  UTILITIES                                                                ║
║  ─────────────────────────────────────────────────────────────────────────║
║  <leader>u   = Toggle undo tree                                           ║
║  <leader>zz  = Zen mode (120 width)                                       ║
║  <leader>zZ  = Full zen mode (80 width)                                   ║
║  gcc         = Toggle line comment                                        ║
║  gc (visual) = Toggle block comment                                       ║
║  <leader>?   = Toggle this cheat sheet                                    ║
║                                                                           ║
║  COMPLETION (INSERT MODE)                                                 ║
║  ─────────────────────────────────────────────────────────────────────────║
║  <C-Space>   = Trigger completion                                         ║
║  <C-n>       = Next completion item                                       ║
║  <C-p>       = Previous completion item                                   ║
║  <C-y>       = Confirm selection                                          ║
║  <C-e>       = Abort completion                                           ║
║  <C-f>       = Scroll docs down                                           ║
║  <C-b>       = Scroll docs up                                             ║
║                                                                           ║
║  QUICKFIX & LOCATION LISTS                                                ║
║  ─────────────────────────────────────────────────────────────────────────║
║  <C-k>       = Next quickfix item                                         ║
║  <C-j>       = Previous quickfix item                                     ║
║  <leader>k   = Next location list item                                    ║
║  <leader>j   = Previous location list item                                ║
║                                                                           ║
║  TREESITTER (VISUAL MODE)                                                 ║
║  ─────────────────────────────────────────────────────────────────────────║
║  <CR>        = Init/expand selection                                      ║
║  <TAB>       = Expand to scope                                            ║
║  <S-TAB>     = Shrink selection                                           ║
║                                                                           ║
║  MARKDOWN                                                                 ║
║  ─────────────────────────────────────────────────────────────────────────║
║  <leader>mr  = Toggle rendering                                           ║
║  j / k       = Down/up by display line (5j still moves 5 lines)           ║
║  z=          = Spelling suggestions for word under cursor                 ║
║  zg          = Add word under cursor to dictionary                        ║
║  <leader>f   = Format buffer (prettier)                                   ║
║                                                                           ║
║  USEFUL VIM COMMANDS                                                      ║
║  ─────────────────────────────────────────────────────────────────────────║
║  :Lazy       = Plugin manager (install/update/sync)                       ║
║  :Mason      = LSP server manager                                         ║
║  :TSUpdate   = Update Treesitter parsers                                  ║
║  :LspInfo    = Show LSP status                                            ║
║  :checkhealth= Check Neovim health                                        ║
║                                                                           ║
╚═══════════════════════════════════════════════════════════════════════════╝

Press 'q' or <Esc> to close this window
]]

local function create_buffer()
    -- Create a new buffer
    local buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_name(buf, "CHEATSHEET")

    -- Set buffer content
    local lines = vim.split(cheatsheet_content, '\n')
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)

    -- Buffer options
    vim.bo[buf].modifiable = false
    vim.bo[buf].bufhidden = 'wipe'
    vim.bo[buf].buftype = 'nofile'
    vim.bo[buf].swapfile = false
    vim.bo[buf].filetype = 'cheatsheet'

    return buf
end

local function add_syntax()
    -- Add syntax highlighting
    vim.cmd([[
		syn match CheatsheetHeader "^║.*NEOVIM.*║$"
		syn match CheatsheetCategory "^║  [A-Z ]*$"
		syn match CheatsheetSeparator "^║  ────.*$"
		syn match CheatsheetKey "<[^>]*>"
		syn match CheatsheetLeader "<leader>"
		syn match CheatsheetBorder "^[╔╗╚╝═║].*"
		syn match CheatsheetCommand ":[A-Za-z]*"

		hi CheatsheetHeader guifg=#eb6f92 gui=bold
		hi CheatsheetCategory guifg=#f6c177 gui=bold
		hi CheatsheetSeparator guifg=#6e6a86
		hi CheatsheetKey guifg=#9ccfd8
		hi CheatsheetLeader guifg=#c4a7e7 gui=bold
		hi CheatsheetBorder guifg=#908caa
		hi CheatsheetCommand guifg=#31748f
	]])
end

-- Function to create and show the cheat sheet
function M.toggle()
    -- Check if cheat sheet buffer already exists
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        if vim.api.nvim_buf_is_valid(buf) and vim.api.nvim_buf_get_name(buf):match("CHEATSHEET") then
            -- Find and close the window showing this buffer
            for _, win in ipairs(vim.api.nvim_list_wins()) do
                if vim.api.nvim_win_get_buf(win) == buf then
                    if vim.api.nvim_win_get_config(win).relative == '' then
                        -- Home page: may be the last window, so empty it instead
                        vim.api.nvim_win_call(win, vim.cmd.enew)
                    else
                        vim.api.nvim_win_close(win, true)
                    end
                    return
                end
            end
        end
    end

    local buf = create_buffer()

    -- Calculate window size (90% of screen)
    local width = math.floor(vim.o.columns * 0.9)
    local height = math.floor(vim.o.lines * 0.9)

    -- Calculate position to center the window
    local row = math.floor((vim.o.lines - height) / 2)
    local col = math.floor((vim.o.columns - width) / 2)

    -- Window options for floating window
    local opts = {
        relative = 'editor',
        width = width,
        height = height,
        row = row,
        col = col,
        style = 'minimal',
        border = 'rounded',
    }

    -- Create the floating window
    local win = vim.api.nvim_open_win(buf, true, opts)

    -- Window options
    vim.wo[win].wrap = false
    vim.wo[win].cursorline = true

    add_syntax()

    -- Keymaps to close the window
    local opts_map = { noremap = true, silent = true, buffer = buf }
    vim.keymap.set('n', 'q', '<cmd>close<CR>', opts_map)
    vim.keymap.set('n', '<Esc>', '<cmd>close<CR>', opts_map)
    vim.keymap.set('n', '<leader>?', '<cmd>close<CR>', opts_map)
end

-- Show the cheat sheet in the current window, in place of the empty start buffer
function M.home()
    local start_buf = vim.api.nvim_get_current_buf()
    local buf = create_buffer()
    vim.bo[start_buf].bufhidden = 'wipe'
    vim.api.nvim_win_set_buf(0, buf)

    -- Local to this buffer, so files opened in this window keep their defaults
    local wo = vim.wo[0][0]
    wo.number = false
    wo.relativenumber = false
    wo.signcolumn = 'no'
    wo.colorcolumn = ''
    wo.wrap = false
    wo.cursorline = true

    add_syntax()

    -- This may be the only window, so leave by opening an empty buffer
    local opts_map = { silent = true, buffer = buf }
    for _, key in ipairs({ 'q', '<Esc>' }) do
        vim.keymap.set('n', key, '<cmd>enew<CR>', opts_map)
    end
    vim.keymap.set('n', 'i', '<cmd>enew<CR><cmd>startinsert<CR>', opts_map)
end

return M
