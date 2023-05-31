-- Open fugitive status window
vim.keymap.set('n', '<leader>gs', vim.cmd.Git)

-- Accept diffs in visual diff buffers
vim.keymap.set('n', 'gh', '<cmd>diffget //2<CR>')
vim.keymap.set('n', 'gl', '<cmd>diffget //3<CR>')

-- Push commits to origin
vim.keymap.set('n', '<leader>gp', '<cmd>Git push<CR>')

