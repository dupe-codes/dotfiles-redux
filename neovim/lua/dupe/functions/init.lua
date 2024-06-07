local links = require "dupe.functions.links"
local colors = require "dupe.functions.colors"

--local key_mapper = require("dupe.util").key_mapper
--key_mapper('n', '<leader>sc', ':lua require("dupe.functions.scratch").scratch()<CR>')

local old_gx = vim.fn.maparg("gx", "n", nil, true)
vim.keymap.set("n", "gx", links.gx_extended_fn(old_gx.callback), { desc = old_gx.desc })
vim.keymap.set("n", "<leader>/", links.open_current_file_in_github)

vim.keymap.set("n", "<leader>color", colors.switch_colorscheme)
