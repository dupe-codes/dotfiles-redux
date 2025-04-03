local key_mapper = function(mode, key, result, desc)
    local meta = { noremap = true, silent = true }
    if desc then
        meta.desc = desc
    end
    vim.keymap.set(mode, key, result, meta)
end

local read_file_contents = function(file_path)
    local file = io.open(file_path, "r")
    if not file then
        return nil
    end
    local content = {}
    for line in file:lines() do
        table.insert(content, line)
    end
    file:close()
    return content
end

local table_concat = function(t1, t2)
    for _, v in ipairs(t2) do
        table.insert(t1, v)
    end
end

local is_quickfix_mode = function()
    local cmd_args = vim.v.argv
    local is_quickfix_mode = false
    for _, arg in ipairs(cmd_args) do
        if arg == "-q" then
            is_quickfix_mode = true
            break
        end
    end
    return is_quickfix_mode
end

return {
    key_mapper = key_mapper,
    read_file_contents = read_file_contents,
    table_concat = table_concat,
    is_quickfix_mode = is_quickfix_mode,
}
