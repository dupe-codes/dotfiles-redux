require("zen-mode").setup({
    plugins = {
        tmux = { enabled = true, },
    },
    on_open = function (_)
        require('notify')("💻 Breathe in, code out...")
    end
})

vim.keymap.set('n', '<leader>zz', '<cmd>:ZenMode<cr>')

