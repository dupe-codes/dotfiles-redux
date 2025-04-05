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

-- neovim note taker
local notes_path = vim.fn.stdpath "config" .. "/notes.md"
whichkey.add {
    {
        "<leader>nn",
        ":edit " .. notes_path .. "<CR>",
        desc = "open neovim notes file",
        nowait = false,
        remap = false,
    },
}

-- close buffers and open dashboard
local open_dash = require("dupe.functions.dashboard").open_dashboard
whichkey.add {
    {
        "<localleader>d",
        open_dash,
        desc = "reset to dashboard",
        nowait = false,
        remap = false,
    },
}

-- script runner
local runner = require "dupe.functions.runner"
whichkey.add {
    { "<localleader>r", group = "runner", mode = "n", nowait = false, remap = false },
    { "<localleader>rr", runner.run_current_file, desc = "run current file", mode = "n" },
    { "<localleader>rs", runner.search_run_logs, desc = "search run logs", mode = "n" },
}
