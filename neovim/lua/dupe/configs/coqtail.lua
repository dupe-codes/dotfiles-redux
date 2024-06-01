vim.cmd "let g:coqtail_nomap = 1"
-- Force .v files to be recognized as coq files
vim.cmd "autocmd BufNewFile,BufRead *.v set filetype=coq"

local whichkey = require "which-key"

-- TODO: This doesn't seem to work for symbolic notation like ++
local getcurword = function()
    -- Add '.' to definition of a keyword
    local old_keywd = vim.api.nvim_get_option "iskeyword"
    vim.api.nvim_buf_set_option(0, "iskeyword", old_keywd .. "," .. ".")

    local cword = vim.fn.expand "<cword>"

    -- Strip trailing '.'s
    local dotidx = string.find(cword, "[.]+$")
    if dotidx then
        cword = string.sub(cword, 1, dotidx - 1)
    end

    -- Reset iskeyword
    vim.api.nvim_buf_set_option(0, "iskeyword", old_keywd)

    return cword
end

function execute_command_with_word(command_base)
    local word = getcurword()
    local cmd = string.format(command_base, word)
    vim.cmd(cmd)
end

local keymap = {
    p = {
        name = "proofs (coq)",
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
            h = { ":lua execute_command_with_word('Coq Check %s')<CR>", "Show type of <arg>" },
            a = { ":lua execute_command_with_word('Coq About %s')<CR>", "Show info about <arg>" },
            p = { ":lua execute_command_with_word('Coq Print %s')<CR>", "Show definition of <arg>" },
            d = { ":lua execute_command_with_word('Coq Locate %s')<CR>", "Show location of <arg>" },
            s = { ":lua execute_command_with_word('Coq Search %s')<CR>", "Search for theorems about <arg>" },
        },
        r = { "<cmd>CoqRestorePanels<CR>", "Restore coq panels" },
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
