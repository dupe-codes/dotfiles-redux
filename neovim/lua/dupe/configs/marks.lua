require('marks').setup {
    default_mappings = true,
    mappings = {
        annotate = 'ma',
    }
}

-- Clear all marks on opening a file; otherwise, old marks are shown, even if
-- they had been previously deleted!
-- Marks are used on a per session basis, anyway, so this is the behavior
-- we want
vim.api.nvim_create_autocmd({ "BufRead" }, { command = ":delm a-zA-Z0-9", })

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

