-- Open undotree and focus it
vim.keymap.set('n', '<leader>u', ':UndotreeToggle<CR>:UndotreeFocus<CR>')

-- Set undotree to the right of the screen
vim.cmd("let g:undotree_WindowLayout = 3")

