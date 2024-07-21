-- convenience functions for working with makefiles

local M = {}

local get_root_makefile_buffer = function()
    -- TODO: Confirm we are in a git repo
    local makefile = vim.fn.trim(vim.fn.system "git rev-parse --show-toplevel") .. "/Makefile"
    vim.notify(makefile)
    local file = io.open(makefile, "r")
    if not file then
        vim.notify "list_targets: Makefile not found"
        return -1
    end
    local content = file:read "a"
    file:close()

    local bufnr = vim.api.nvim_create_buf(false, true)
    local lines = vim.split(content, "\n")
    vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, lines)
    return bufnr
end

M.list_targets = function()
    local targets = {}

    local bufnr = -1
    local close_buffer = false

    if vim.bo.filetype == "make" then
        bufnr = vim.api.nvim_get_current_buf()
    else
        -- otherwise, parse targets from Makefile in project root
        bufnr = get_root_makefile_buffer()
        close_buffer = true
    end

    if bufnr == -1 then
        return
    end

    local parser = vim.treesitter.get_parser(bufnr, "make")
    local tree = parser:parse()[1]
    local root = tree:root()

    local query = assert(vim.treesitter.query.get("make", "targets"), "Make targets query not found")
    for _, capture in query:iter_captures(root, bufnr) do
        local target = vim.treesitter.get_node_text(capture, bufnr)
        if target ~= ".PHONY" then
            table.insert(targets, target)
        end
    end

    vim.print(vim.inspect(targets))

    if close_buffer then
        vim.api.nvim_buf_delete(bufnr, { force = true })
    end

    -- list targets with telescope

    -- execute selected target
    -- TODO: this supports Makefiles in the git root directory. Extend to support
    --       nested Makefiles. ascend the directory structure and execute the closest
    --       Makefile found
    -- local cmd = 'make --directory "$(git rev-parse --show-toplevel)"' .. selected
end

return M
