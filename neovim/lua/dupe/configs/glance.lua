local key_mapper = require("dupe.util").key_mapper

local M = {}

M.reset = function()
    require("glance").setup {
        theme = {
            enable = true,
            mode = "darken",
        },
    }
end

M.reset()

-- Setup glance keymappers
key_mapper("n", "gd", "<CMD>Glance definitions<CR>")
key_mapper("n", "gr", "<CMD>Glance references<CR>")
key_mapper("n", "gt", "<CMD>Glance type_definitions<CR>")
key_mapper("n", "gi", "<CMD>Glance implementations<CR>")

return M
