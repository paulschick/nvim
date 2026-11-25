local M = {}

local TIMEOUT_MS = 5000

-- Replace only the lines that differ, so the cursor, marks and folds outside of
-- them stay on the same text. Windows keep their scroll relative to the cursor.
local function replace_lines(bufnr, old, new)
	local hunks = vim.text.diff(
		table.concat(old, '\n') .. '\n',
		table.concat(new, '\n') .. '\n',
		{ result_type = 'indices' }
	)
	if #hunks == 0 then return end

	local views = {}
	for _, win in ipairs(vim.fn.win_findbuf(bufnr)) do
		views[win] = vim.api.nvim_win_call(win, vim.fn.winsaveview)
	end

	for i = #hunks, 1, -1 do
		local start_old, count_old, start_new, count_new = unpack(hunks[i])
		-- A pure insertion has no old lines and reports the line it goes after
		local first = count_old == 0 and start_old or start_old - 1
		local lines = vim.list_slice(new, start_new, start_new + count_new - 1)
		vim.api.nvim_buf_set_lines(bufnr, first, first + count_old, true, lines)
	end

	for win, view in pairs(views) do
		vim.api.nvim_win_call(win, function()
			view.topline = math.max(1, vim.fn.line('.') - (view.lnum - view.topline))
			view.lnum = nil
			vim.fn.winrestview(view)
		end)
	end
end

-- Format the buffer's text (not the file on disk) with a Mason tool that reads
-- stdin and writes stdout. On any failure the buffer is left untouched.
local function format(bufnr, tool, args, opts)
	opts = opts or {}
	local function fail(reason)
		vim.notify(tool .. ': ' .. reason, vim.log.levels.ERROR)
	end

	local path = vim.fn.stdpath('data') .. '/mason/bin/' .. tool
	if vim.fn.executable(path) == 0 then
		return fail('not found. Install via :MasonInstall ' .. tool)
	end
	if not vim.bo[bufnr].modifiable then
		return fail('buffer is not modifiable')
	end

	local old = vim.api.nvim_buf_get_lines(bufnr, 0, -1, true)
	local ok, result = pcall(function()
		return vim.system(
			vim.list_extend({ path }, args),
			{ stdin = table.concat(old, '\n') .. '\n', cwd = opts.cwd }
		):wait(TIMEOUT_MS)
	end)
	if not ok then return fail(result) end
	-- No result at all means a child of the tool outlived the timeout
	if not result or result.code == 124 then return fail('timed out') end
	-- A process killed by a signal reports code 0. Empty output for a non-blank
	-- buffer is a failure too: ktlint exits 0 that way on a syntax error.
	local lost = result.stdout == '' and table.concat(old):find('%S')
	local code_ok = result.code == 0 or result.code == opts.partial_code
	if not code_ok or result.signal ~= 0 or lost then
		local stderr = vim.trim(result.stderr)
		return fail(stderr ~= '' and stderr or ('exit code %d, signal %d'):format(result.code, result.signal))
	end

	local text = result.stdout:gsub('\r\n', '\n'):gsub('\n$', '')
	replace_lines(bufnr, old, vim.split(text, '\n', { plain = true }))
end

function M.prettier(bufnr)
	-- Prettier picks its parser and config from this path
	local filepath = vim.api.nvim_buf_get_name(bufnr)
	if filepath == '' then filepath = 'untitled.md' end
	format(bufnr, 'prettier', { '--stdin-filepath', filepath })
end

function M.ktlint(bufnr)
	local name = vim.api.nvim_buf_get_name(bufnr)
	local dir = name ~= '' and vim.fs.dirname(name) or nil
	if dir and vim.fn.isdirectory(dir) == 0 then dir = nil end
	-- Not --stdin-path: with --format that writes the file on disk. ktlint finds
	-- .editorconfig from cwd instead, and exits 1 when some lint is not fixable.
	format(bufnr, 'ktlint', { '--stdin', '--format', '--log-level=none' }, { cwd = dir, partial_code = 1 })
end

return M
