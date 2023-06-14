-- Configuration for vim-startify
vim.cmd [[
  let g:startify_custom_header = startify#pad(readfile(expand('~/.config/nvim/ascii-art.txt')))
]]

-- Configure nvim-web-devicons

function _G.webDevIcons(path)
  local filename = vim.fn.fnamemodify(path, ':t')
  local extension = vim.fn.fnamemodify(path, ':e')
  return require'nvim-web-devicons'.get_icon(filename, extension, { default = true })
end

vim.cmd [[
function! StartifyEntryFormat() abort
  return 'v:lua.webDevIcons(absolute_path) . " " . entry_path'
endfunction
]]

