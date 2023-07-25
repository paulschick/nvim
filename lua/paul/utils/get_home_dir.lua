local M = {}

function M.getWritingFolderPath()
    local platform = vim.loop.os_uname().sysname

    if platform == 'Windows' or platform == 'Windows_NT' then
        return vim.fn.expand('~') .. '\\Writing'
    else
        return vim.fn.expand('~') .. '/Writing'
    end
end

return M

