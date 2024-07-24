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
    { "<leader>p", group = "proofs (coq)", nowait = false, remap = false },
    { "<leader>pb", "<cmd>CoqUndo<CR>", desc = "Step back n sentences", nowait = false, remap = false },
    { "<leader>pc", group = "Queries", nowait = false, remap = false },
    {
        "<leader>pca",
        ":lua execute_command_with_word('Coq About %s')<CR>",
        desc = "Show info about <arg>",
        nowait = false,
        remap = false,
    },
    {
        "<leader>pcd",
        ":lua execute_command_with_word('Coq Locate %s')<CR>",
        desc = "Show location of <arg>",
        nowait = false,
        remap = false,
    },
    {
        "<leader>pch",
        ":lua execute_command_with_word('Coq Check %s')<CR>",
        desc = "Show type of <arg>",
        nowait = false,
        remap = false,
    },
    {
        "<leader>pcp",
        ":lua execute_command_with_word('Coq Print %s')<CR>",
        desc = "Show definition of <arg>",
        nowait = false,
        remap = false,
    },
    {
        "<leader>pcs",
        ":lua execute_command_with_word('Coq Search %s')<CR>",
        desc = "Search for theorems about <arg>",
        nowait = false,
        remap = false,
    },
    {
        "<leader>pd",
        "<cmd>CoqJumpToError<CR>",
        desc = "Move cursor to start of error region",
        nowait = false,
        remap = false,
    },
    {
        "<leader>pe",
        "<cmd>CoqJumpToEnd<CR>",
        desc = "Move cursor to end of checked region",
        nowait = false,
        remap = false,
    },
    { "<leader>pi", "<cmd>CoqInterrupt<CR>", desc = "Interrupt coq", nowait = false, remap = false },
    {
        "<leader>pl",
        "<cmd>CoqToLine<CR>",
        desc = "Send/rewind all sentences up to cursor",
        nowait = false,
        remap = false,
    },
    { "<leader>pn", "<cmd>CoqNext<CR>", desc = "Send next n sentences to Coq", nowait = false, remap = false },
    {
        "<leader>po",
        "<cmd>CoqOmitToLine<CR>",
        desc = "Send sentences up to line but omit processing opaque proofs",
        nowait = false,
        remap = false,
    },
    { "<leader>pq", "<cmd>CoqStop<CR>", desc = "Quit coq", nowait = false, remap = false },
    { "<leader>pr", "<cmd>CoqRestorePanels<CR>", desc = "Restore coq panels", nowait = false, remap = false },
    { "<leader>ps", "<cmd>CoqStart<CR>", desc = "Start coq", nowait = false, remap = false },
    { "<leader>pt", "<cmd>CoqToTop<CR>", desc = "Rewind to beginning of file", nowait = false, remap = false },
}

whichkey.add(keymap)
