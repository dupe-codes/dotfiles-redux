require("oil").setup {
    view_options = {
        show_hidden = true,
    },
    float = {
        max_width = 180,
        max_height= 40,
    },
}

local keymap = {
    { "<leader>ff", "<CMD>Oil --float<CR>", desc = "open file system buffer (oil)", nowait = false, remap = false },
}

local whichkey = require "which-key"
whichkey.add(keymap)
