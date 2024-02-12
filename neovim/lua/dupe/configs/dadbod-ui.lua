vim.g.db_ui_use_nerd_fonts = 1

local keymap = {
    z = {
        name = "databases",
        o = {
            ':DBUI<CR>',
            "open databases ui"
        },
    }
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
