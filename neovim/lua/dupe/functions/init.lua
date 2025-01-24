local links = require "dupe.functions.links"
local colors = require "dupe.functions.colors"

local old_gx = vim.fn.maparg("gx", "n", nil, true)
vim.keymap.set("n", "gx", links.gx_extended_fn(old_gx.callback), { desc = old_gx.desc })
vim.keymap.set("n", "<localleader>o", links.open_current_file_in_github)

vim.keymap.set("n", "<leader>color", colors.switch_colorscheme)

require "dupe.functions.html_snippets_generator"

local fidget_history_search = require "dupe.functions.fidget_history"
local whichkey = require "which-key"
whichkey.add {
    {
        "<leader>fn",
        function()
            fidget_history_search.fidget_history_picker()
        end,
        desc = "search notification history",
        nowait = false,
        remap = false,
    },
}
