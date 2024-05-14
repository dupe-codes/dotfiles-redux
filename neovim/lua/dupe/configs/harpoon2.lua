local harpoon = require("harpoon")
local notify = require("notify")

harpoon:setup({
    settings = {
        save_on_toggle = true
    }
})

vim.keymap.set("n", "<leader>a", function()
    harpoon:list():append()
    notify("📌 Added harpoon mark to current file")
end)

vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

-- TODO: use this better way to set <leader>1..x as jump to file keys
--[[
   [for _, idx in ipairs { 1, 2, 3, 4, 5 } do
   [    vim.keymap.set("n", string.format("<leader>%d", idx), function()
   [        harpoon:list():select(idx)
   [    end)
   [end
   ]]

vim.keymap.set("n", "<leader>1", function() harpoon:list():select(1) end)
vim.keymap.set("n", "<leader>2", function() harpoon:list():select(2) end)
vim.keymap.set("n", "<leader>3", function() harpoon:list():select(3) end)
vim.keymap.set("n", "<leader>4", function() harpoon:list():select(4) end)
vim.keymap.set("n", "<leader>5", function() harpoon:list():select(5) end)
vim.keymap.set("n", "<leader>6", function() harpoon:list():select(6) end)

-- Toggle previous & next buffers stored within Harpoon list
vim.keymap.set("n", "<leader>,", function() harpoon:list():prev() end)
vim.keymap.set("n", "<leader>.", function() harpoon:list():next() end)
