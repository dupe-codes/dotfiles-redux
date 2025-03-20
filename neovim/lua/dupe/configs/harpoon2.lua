local harpoon = require "harpoon"
local harpoon_extensions = require "harpoon.extensions"

harpoon:setup {
    settings = {
        save_on_toggle = true,
    },
    default = {
        display = function(list_item)
            local path = list_item.value
            local parent_dir = path:match "([^/]+)/[^/]+$" or ""
            local filename = path:match "([^/]+)$" or path
            return parent_dir .. "/" .. filename
        end,
    },
}

harpoon:extend(harpoon_extensions.builtins.highlight_current_file())

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
