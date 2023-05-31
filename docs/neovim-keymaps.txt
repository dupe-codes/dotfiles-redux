# Neovim Keymaps

An index of my most important neovim keymaps

Many of these are direct copy-and-pastes of the key mapper commands from my
neovim config files

## General

Move between open panes:
- <leader>h
- <leader>j
- <leader>k
- <leader>l

Clear search buffer
- <leader><leader>

-- Keymap to move visual selection
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")

-- Keymap to yank into system clipboard
vim.keymap.set('n', '<leader>y', '"+y')
vim.keymap.set('v', '<leader>y', '"+y')
vim.keymap.set('n', '<leader>Y', '"+Y')

-- Keymap to replace in file text at current cursor
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left]])

## Telescope fuzzy finding

- <C-p> find_files()
- <leader>fs live_grep()

## Buffer naviation

-- Barbar 
key_mapper('n', '<leader>1', ':buffergoto 1<cr>')
key_mapper('n', '<leader>2', ':buffergoto 2<cr>')
key_mapper('n', '<leader>3', ':buffergoto 3<cr>')
key_mapper('n', '<leader>4', ':buffergoto 4<cr>')
key_mapper('n', '<leader>5', ':buffergoto 5<cr>')
key_mapper('n', '<leader>6', ':buffergoto 6<cr>')
key_mapper('n', '<leader>7', ':buffergoto 7<cr>')
key_mapper('n', '<leader>8', ':buffergoto 8<cr>')
key_mapper('n', '<leader>.', ':buffernext<cr>')
key_mapper('n', '<leader>,', ':bufferprevious<cr>')
key_mapper('n', '<leader>q', ':bufferclose<cr>')

-- Harpoon
vim.keymap.set("n", "<leader>a", mark.add_file)
vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu)

vim.keymap.set("n", "<C-h>", function()
    ui.nav_file(1)
end)

vim.keymap.set("n", "<C-j>", function()
    ui.nav_file(2)
end)

vim.keymap.set("n", "<C-k>", function()
    ui.nav_file(3)
end)

vim.keymap.set("n", "<C-l>", function()
    ui.nav_file(4)
end)

-- Keymap to go back and forth to/from last buffer
vim.keymap.set('n', '<leader>b', '<C-^>')


## nvim-tree/creating new files
For use in the nvim-tree buffer:

- a: add file or directory
- d: delete filter or directory
key_mapper('n', '<leader>ff', ':NvimTreeFindFile<CR>')
key_mapper(
    'n',
    '<leader>nf',
    ':edit %:h/<C-r>=input("New file name: ")<CR><CR>'
)

## language server/completions/code introspection
vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, attach_opts)
vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, attach_opts)
vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, attach_opts)
key_mapper('n', '<Leader>e', '<Cmd>lua _G.open_floating_diagnostics()<CR>')
key_mapper('n', '<leader>gd', '<CMD>Glance definitions<CR>')
key_mapper('n', '<leader>gr', '<CMD>Glance references<CR>')
key_mapper('n', '<leader>gy', '<CMD>Glance type_definitions<CR>')
key_mapper('n', '<leader>gm', '<CMD>Glance implementations<CR>')

## Nerdcommenter
key_mapper('n', '<leader>cc', '<Plug>NERDCommenterComment')
key_mapper('n', '<leader>cu', '<Plug>NERDCommenterUncomment')
key_mapper('n', '<leader>c<space>', '<Plug>NERDCommenterToggle')

## Using the terminal
key_mapper('n', '<leader>tt', '<Cmd>terminal<CR>')
key_mapper('t', '<Esc>', '<C-\\><C-n>')

## Undotree
-- Open undotree and focus it
vim.keymap.set('n', '<leader>u', ':UndotreeToggle<CR>:UndotreeFocus<CR>')

## Git status and commands
vim.keymap.set('n', '<leader>gs', vim.cmd.Git)

