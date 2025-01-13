local api = require "dropbar.api"
local whichkey = require "which-key"

local keymap = {
    { "<leader>w", group = "dropbar", icon = "󰠶", nowait = false, remap = false },
    {
        "<leader>w;",
        api.pick,
        desc = "Pick symbols in winbar",
        nowait = false,
        remap = false,
    },
    {
        "<leader>w[",
        api.goto_context_start,
        desc = "Go to start of current context",
        nowait = false,
        remap = false,
    },
    {
        "<leader>w]",
        api.select_next_context,
        desc = "Select next context",
        nowait = false,
        remap = false,
    },
}

whichkey.add(keymap)
