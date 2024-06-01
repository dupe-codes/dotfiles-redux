local whichkey = require "which-key"

require("trouble").setup {}

local keymap = {
    x = {
        name = "trouble diagnostics",
        x = {
            "<cmd>Trouble diagnostics toggle<cr>",
            "open diagnostics",
        },
        X = {
            "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
            "open diagnostics for buffer",
        },
        l = {
            "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
            "open LSP definitions / references / ...",
        },
        L = {
            "<cmd>Trouble loclist toggle<cr>",
            "open location list",
        },
        q = {
            "<cmd>Trouble qflist toggle<cr>",
            "open quickfix list",
        },
    },
}

whichkey.register(keymap, {
    mode = "n",
    prefix = "<leader>",
    buffer = nil,
    silent = true,
    noremap = true,
    nowait = false,
})
