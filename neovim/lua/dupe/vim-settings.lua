-- Run command to remove bg color on line numbers on VimEnter
--local function remove_line_number_bgcolor()
    vim.cmd("highlight LineNr ctermbg=NONE guibg=NONE")
--end
--vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = remove_line_number_bgcolor })

