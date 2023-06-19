local key_mapper = require('dupe.util').key_mapper

vim.opt.termguicolors = true

require("notify").setup({
    timeout = 500,
})
vim.notify = require("notify")

key_mapper("n", "<leader>sn", ":lua require('telescope').extensions.notify.notify()<CR>")

