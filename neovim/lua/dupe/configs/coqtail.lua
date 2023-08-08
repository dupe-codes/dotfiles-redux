vim.cmd("let g:coqtail_nomap = 1")
-- Force .v files to be recognized as coq files
vim.cmd("autocmd BufNewFile,BufRead *.v set filetype=coq")

local whichkey = require("which-key")

local keymap = {
    p = {
        name = "Proofs (Coq)",
        s = { "<cmd>CoqStart<CR>", "Start coq" },
        q = { "<cmd>CoqStop<CR>", "Quit coq" },
        i = { "<cmd>CoqInterrupt<CR>", "Interrupt coq" },
        n = { "<cmd>CoqNext<CR>", "Send next n sentences to Coq" },
        b = { "<cmd>CoqUndo<CR>", "Step back n sentences" },
        l = { "<cmd>CoqToLine<CR>", "Send/rewind all sentences up to cursor" },
        o = { "<cmd>CoqOmitToLine<CR>", "Send sentences up to line but omit processing opaque proofs" },
        t = { "<cmd>CoqToTop<CR>", "Rewind to beginning of file" },
        e = { "<cmd>CoqJumpToEnd<CR>", "Move cursor to end of checked region" },
        d = { "<cmd>CoqJumpToError<CR>", "Move cursor to start of error region" },
        c = {
            name = "Queries",
            h = { "<cmd>Coq Check<CR>", "Show type of <arg>" },
            a = { "<cmd>Coq About<CR>", "Show info about <arg>" },
            p = { "<cmd>Coq Print<CR>", "Show definition of <arg>" },
            d = { "<cmd>Coq Locate<CR>", "Show location of <arg>" },
            s = { "<cmd>Coq Search<CR>", "Search for theorems about <arg>" },
        },
        r = { "<cmd>CoqRestorePanels<CR>", "Restore coq panels" },
    }
}

whichkey.register(keymap, {
    mode = "n",
    prefix = "<leader>",
    buffer = nil,
    silent = true,
    noremap = true,
    nowait = false,
})


