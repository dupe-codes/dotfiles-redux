vim.g.mapleader = ' '
vim.g.maplocalleader = '  '

local key_mapper = require('dupe.util').key_mapper

-- Unmap arrow keys
key_mapper('', '<up>', '<nop>')
key_mapper('', '<down>', '<nop>')
key_mapper('', '<left>', '<nop>')
key_mapper('', '<right>', '<nop>')

-- Move between windows with <leader>hjkl
key_mapper('n', '<leader>h', '<C-w>h')
key_mapper('n', '<leader>j', '<C-w>j')
key_mapper('n', '<leader>k', '<C-w>k')
key_mapper('n', '<leader>l', '<C-w>l')

-- Clear search with <leader><leader>
key_mapper('n', '<leader><leader>', ':noh<CR>')

-- Close buffer
key_mapper('n', '<leader>q', ':bd<CR>')

-- Keymap to go back and forth to/from last buffer
vim.keymap.set('n', '<leader>b', '<C-^>')

-- Keymap to move visual selection
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")

-- Keymap to yank into system clipboard
vim.keymap.set('n', '<leader>y', '"+y')
vim.keymap.set('v', '<leader>y', '"+y')
vim.keymap.set('n', '<leader>Y', '"+Y')

-- Keymap to replace in file text at current cursor
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- open links
-- nnoremap gx <CMD>execute '!xdg-open ' .. shellescape(expand('<cfile>'), v:true)<CR>
vim.keymap.set('n', 'gx', [[:execute '!xdg-open' .. shellescape(expand('<cfile>'), v:true)<CR>]])
