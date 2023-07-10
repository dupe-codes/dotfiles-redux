local mark = require("harpoon.mark")
local ui = require("harpoon.ui")
local notify = require("notify")

vim.keymap.set("n", "<leader>a", function()
    mark.add_file()
    notify("📌 Added harpoon mark to current file")
end)

vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu)

vim.keymap.set("n", "<C-1>", function()
    ui.nav_file(1)
end)

vim.keymap.set("n", "<C-2>", function()
    ui.nav_file(2)
end)

vim.keymap.set("n", "<C-3>", function()
    ui.nav_file(3)
end)

vim.keymap.set("n", "<C-4>", function()
    ui.nav_file(4)
end)

-- Style harpoon menu
vim.api.nvim_set_hl(0, 'HarpoonWindow', { link = 'NormalFloat' })
vim.api.nvim_set_hl(0, 'HarpoonBorder', { link = 'FloatBorder' })
