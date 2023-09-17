local keymap = {
    ["?"] = { "<cmd> :Cheatsheet <CR>", "Open cheatsheet" },
}

local whichkey = require("which-key")
whichkey.register(keymap, {
    mode = "n",
    prefix = "<leader>",
    buffer = nil,
    silent = true,
    noremap = true,
    nowait = false,
})

