require("oil").setup {
    view_options = {
        show_hidden = true,
    },
}

local keymap = {
    f = {
        "<CMD>Oil<CR>",
        "open file system buffer (oil)",
    },
}

local whichkey = require "which-key"
whichkey.register(keymap, {
    mode = "n",
    prefix = "<leader>f",
    buffer = nil,
    silent = true,
    noremap = true,
    nowait = false,
})
