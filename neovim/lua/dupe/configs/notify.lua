local key_mapper = require('dupe.util').key_mapper

vim.opt.termguicolors = true

-- TODO: Consider moving window position to bottom
--       left or right
require("notify").setup({
    timeout = 500,
    top_down = false,
    background_colour = "#000000",
})
vim.notify = require("notify")

key_mapper("n", "<leader>sn", ":lua require('telescope').extensions.notify.notify()<CR>")

