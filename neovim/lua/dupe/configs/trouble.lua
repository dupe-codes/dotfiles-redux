local whichkey = require "which-key"

require("trouble").setup {}

-- auto open trouble when quickfix used
vim.api.nvim_create_autocmd("QuickFixCmdPost", {
  callback = function()
    vim.cmd([[Trouble qflist open]])
  end,
})

local keymap = {
    { "<leader>x", group = "trouble diagnostics", nowait = false, remap = false },
    { "<leader>xL", "<cmd>Trouble loclist toggle<cr>", desc = "open location list", nowait = false, remap = false },
    {
        "<leader>xX",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "open diagnostics for workspace",
        nowait = false,
        remap = false,
    },
    {
        "<leader>xl",
        "<cmd>Trouble lsp toggle focus=false win.position=bottom<cr>",
        desc = "open LSP definitions / references / ...",
        nowait = false,
        remap = false,
    },
    { "<leader>xq", "<cmd>Trouble qflist toggle<cr>", desc = "open quickfix list", nowait = false, remap = false },
    {
        "<leader>xx",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "open diagnostics for buffer",
        nowait = false,
        remap = false,
    },
}

whichkey.add(keymap)
