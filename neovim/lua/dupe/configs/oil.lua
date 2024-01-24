require("oil").setup({})

local keymap = {
    f = {
        "<CMD>Oil<CR>",
        "Open file system buffer (oil)"
    }
}

local whichkey = require("which-key")
whichkey.register(keymap, {
    mode = "n",
    prefix = "<leader>f",
    buffer = nil,
    silent = true,
    noremap = true,
    nowait = false,
})


