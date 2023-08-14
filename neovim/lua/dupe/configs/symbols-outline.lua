local key_mapper = require("dupe.util").key_mapper

require("symbols-outline").setup({
    position = "right",
})

key_mapper("n", "<leader>oo", "<cmd>SymbolsOutline<CR>")

