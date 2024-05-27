require("zen-mode").setup {
    plugins = {
        tmux = { enabled = true },
    },
    on_open = function(_)
        vim.notify "💻 Breathe in, code out..."
    end,
}

vim.keymap.set("n", "<leader>zen", "<cmd>:ZenMode<cr>")
