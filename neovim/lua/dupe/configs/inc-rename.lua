local key_mapper = require("dupe.util").key_mapper

require("inc_rename").setup()

vim.keymap.set("n", "<leader>rn", function()
    return ":IncRename " .. vim.fn.expand "<cword>"
end, { expr = true })
