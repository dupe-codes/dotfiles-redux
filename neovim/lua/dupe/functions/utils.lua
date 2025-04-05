local M = {}

M.display_cmd_output = function(output, title)
    local lines
    if type(output) == "string" then
        lines = vim.split(output, "\n")
    elseif type(output) == "table" then
        lines = output
    else
        error("output must be either a string or a table of lines, got: " .. type(output))
    end

    local bufnr = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, lines)

    local width = math.floor(vim.o.columns * 0.8)
    local height = math.floor(vim.o.lines * 0.8)
    local row = math.floor((vim.o.lines - height) / 2)
    local col = math.floor((vim.o.columns - width) / 2)

    local opts = {
        style = "minimal",
        relative = "editor",
        width = width,
        height = height,
        row = row,
        col = col,
        border = "single",
        title = title,
    }
    vim.api.nvim_open_win(bufnr, true, opts)
end

return M
