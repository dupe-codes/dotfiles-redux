local M = {}

M.open_dashboard = function()
    vim.cmd "%bd"
    vim.cmd "Dashboard"
end

return M
