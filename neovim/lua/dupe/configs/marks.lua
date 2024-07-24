require("marks").setup {
    default_mappings = true,
    mappings = {
        annotate = "ma",
    },
}

-- Clear all marks on opening a file; otherwise, old marks are shown, even if
-- they had been previously deleted!
-- Marks are used on a per session basis, anyway, so this is the behavior
-- we want
vim.api.nvim_create_autocmd({ "BufRead" }, { command = ":delm a-zA-Z0-9" })

local keymap = {
    { "<leader>m", group = "marks", nowait = false, remap = false },
    {
        "<leader>ma",
        "<cmd> :MarksListAll <CR>",
        desc = "List all marks in all open buffers",
        nowait = false,
        remap = false,
    },
    {
        "<leader>mb",
        "<cmd> :MarksListBuf <CR>",
        desc = "List all marks in current buffer",
        nowait = false,
        remap = false,
    },
}

local whichkey = require "which-key"
whichkey.add(keymap)
