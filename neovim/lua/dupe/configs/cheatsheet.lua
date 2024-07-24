-- TODO: fix keybinds to yank selected icon/command/result
require("cheatsheet").setup {}

local keymap = {
    { "<leader>?", "<cmd> :Cheatsheet <CR>", desc = "cheatsheet", nowait = false, remap = false },
}

local whichkey = require "which-key"
whichkey.add(keymap)
