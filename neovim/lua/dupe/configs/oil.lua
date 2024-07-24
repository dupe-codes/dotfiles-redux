require("oil").setup {
    view_options = {
        show_hidden = true,
    },
}

local keymap = {
    { "<leader>ff", "<CMD>Oil<CR>", desc = "open file system buffer (oil)", nowait = false, remap = false },
}

local whichkey = require "which-key"
whichkey.add(keymap)
