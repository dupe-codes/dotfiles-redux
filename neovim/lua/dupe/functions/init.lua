local links = require "dupe.functions.links"

--local key_mapper = require("dupe.util").key_mapper
--key_mapper('n', '<leader>sc', ':lua require("dupe.functions.scratch").scratch()<CR>')

local old_gx = vim.fn.maparg("gx", "n", nil, true)
vim.keymap.set("n", "gx", links.gx_extended_fn(old_gx.callback), { desc = old_gx.desc })
