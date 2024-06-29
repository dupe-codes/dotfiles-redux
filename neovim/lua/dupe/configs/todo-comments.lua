require("todo-comments").setup {
    highlight = {
        keyword = "bg",
        after = "",
    },
}

vim.keymap.set("n", "<leader>xt", function()
    local command = "TodoTrouble cwd=" .. vim.fn.expand "%"
    vim.api.nvim_command(command)
end)
