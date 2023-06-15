-- TODO: Configure toggleterm keymaps
require("toggleterm").setup({
    open_mapping = [[<C-t>]],
    --direction = "float",
    --float_opts = {
        --border = "curved",
    --},
    size = function()
      return math.floor(vim.o.lines * 0.40)
    end,
    highlights = {
       FloatBorder = {
            guifg="#54546d",
            guibg=clear,
        },
    },
})

function _G.set_terminal_keymaps()
  local opts = {buffer = 0}
  vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
end

vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')

