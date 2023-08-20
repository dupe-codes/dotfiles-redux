require('marks').setup {
    default_mappings = true,
    mappings = {
        annotate = 'ma',
    }
}

local keymap = {
    m = {
        name = "Marks",
        a = {
            '<cmd> :MarksListAll <CR>',
            "List all marks in all open buffers"
        },
        b = {
            '<cmd> :MarksListBuf <CR>',
            "List all marks in current buffer"
        }
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

