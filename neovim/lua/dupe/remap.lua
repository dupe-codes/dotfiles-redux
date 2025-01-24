vim.g.mapleader = " "
vim.g.maplocalleader = "  "

local key_mapper = require("dupe.util").key_mapper

-- Unmap arrow keys
key_mapper("", "<up>", "<nop>")
key_mapper("", "<down>", "<nop>")
key_mapper("", "<left>", "<nop>")
key_mapper("", "<right>", "<nop>")

-- Move between windows with <leader>hjkl
key_mapper("n", "<leader>h", "<C-w>h")
key_mapper("n", "<leader>j", "<C-w>j")
key_mapper("n", "<leader>k", "<C-w>k")
key_mapper("n", "<leader>l", "<C-w>l")

-- Resize windows with <localleader>hjkl
-- hold to resize faster
key_mapper("n", "<localleader>h", ":vertical resize +8<CR>")
key_mapper("n", "<localleader>j", ":resize +8<CR>")
key_mapper("n", "<localleader>k", ":resize -8<CR>")
key_mapper("n", "<localleader>l", ":vertical resize -8<CR>")

-- Clear search
key_mapper("n", "<leader>/", ":noh<CR>")

-- Close buffer
key_mapper("n", "<leader>q", ":bd<CR>")
-- close all other buffers
key_mapper("n", "<localleader>q", ":%bd|e#<CR>")

-- Keymap to go back and forth to/from last buffer
vim.keymap.set("n", "<leader>b", "<C-^>")

-- Keymap to move visual selection
-- TODO: doesn't work with repeated key presses on
-- visual blocks with >= 3 lines. weird. fix it
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Keymap to yank into system clipboard
vim.keymap.set("n", "<leader>y", '"+y')
vim.keymap.set("v", "<leader>y", '"+y')
vim.keymap.set("n", "<leader>Y", '"+Y')

-- Find and replace with sed
vim.keymap.set(
    "n",
    "<leader>s",
    [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
    { desc = "Find and replace word at current cursor" }
)
