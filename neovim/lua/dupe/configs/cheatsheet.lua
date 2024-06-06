-- TODO: fix keybinds to yank selected icon/command/result
require("cheatsheet").setup {}

local keymap = {
    ["?"] = { "<cmd> :Cheatsheet <CR>", "cheatsheet" },
}

local whichkey = require "which-key"
whichkey.register(keymap, {
    mode = "n",
    prefix = "<leader>",
    buffer = nil,
    silent = true,
    noremap = true,
    nowait = false,
})
