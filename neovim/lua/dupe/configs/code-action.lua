local ca = require "tiny-code-action"

ca.setup {
    backend = "delta",
    backend_opts = {
        delta = {
            args = { "--line-numbers" },
        },
    },
}

vim.keymap.set("n", "<leader>ca", function()
    ca.code_action()
end, { noremap = true, silent = true })
