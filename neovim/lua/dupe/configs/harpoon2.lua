local harpoon = require "harpoon"

harpoon:setup {
    settings = {
        save_on_toggle = true,
    },
}

vim.keymap.set("n", "<leader>a", function()
    harpoon:list():append()
    vim.notify "📌 Added harpoon mark to current file"
end)

vim.keymap.set("n", "<C-e>", function()
    harpoon.ui:toggle_quick_menu(harpoon:list())
end)

for _, idx in ipairs { 1, 2, 3, 4, 5, 6, 7, 8 } do
    vim.keymap.set("n", string.format("<leader>%d", idx), function()
        harpoon:list():select(idx)
    end)
end

-- Toggle previous & next buffers stored within Harpoon list
vim.keymap.set("n", "<leader>,", function()
    harpoon:list():prev()
end)
vim.keymap.set("n", "<leader>.", function()
    harpoon:list():next()
end)
