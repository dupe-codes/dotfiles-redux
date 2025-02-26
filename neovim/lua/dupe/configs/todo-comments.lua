local whichkey = require "which-key"

require("todo-comments").setup {
    highlight = {
        keyword = "bg",
        after = "",
    },
}

local keymap = {
    {
        "<leader>xt",
        "<cmd>Trouble todo toggle filter.buf=0<cr>",
        desc = "open todos for current buffer",
        nowait = false,
        remap = false,
    },
}
whichkey.add(keymap)
