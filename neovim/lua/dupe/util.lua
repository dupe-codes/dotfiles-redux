local key_mapper = function(mode, key, result)
    vim.api.nvim_set_keymap(mode, key, result, { noremap = true, silent = true })
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

return {
    key_mapper = key_mapper,
    read_file_contents = read_file_contents,
    table_concat = table_concat,
}
