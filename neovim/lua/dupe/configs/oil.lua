require("oil").setup {
    view_options = {
        show_hidden = true,
    },
    win_options = {
        winbar = "%#@attribute.builtin#%{substitute(v:lua.require('oil').get_current_dir(), '^' . $HOME, '~', '')}",
    },
}

local keymap = {
    { "<leader>ff", "<CMD>Oil<CR>", desc = "open file system buffer (oil)", nowait = false, remap = false },
}

local whichkey = require "which-key"
whichkey.add(keymap)
