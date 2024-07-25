local whichkey = require "which-key"

local datastore_dir = os.getenv "HOME" .. "/datastore/"
local quest_log = "00 - quest log.md"

local get_current_week = function()
    local year = os.date "%Y"
    local day_of_year = os.date "%j"
    local week_number = math.ceil(day_of_year / 7)
    local formatted_week_number = string.format("%02d", week_number)
    return year .. "-W" .. formatted_week_number
end

local keymap = {
    {
        "<leader>nd",
        "<CMD>Oil --float ~/datastore<CR>",
        desc = "Open datastore explorer",
        nowait = false,
        remap = false,
    },
    {
        "<leader>nt",
        function()
            local todays_note = datastore_dir .. "daily notes/" .. os.date "%Y-%m-%d" .. ".md"
            vim.notify("Opening today's note: " .. todays_note)
            vim.cmd("e " .. todays_note)
        end,
        desc = "Open today's note",
        nowait = false,
        remap = false,
    },
    {
        "<leader>nw",
        function()
            local weekly_note = datastore_dir .. "weekly notes/" .. get_current_week() .. ".md"
            vim.notify("Opening weekly note: " .. weekly_note)
            vim.cmd("e " .. weekly_note)
        end,
        desc = "Open this week's note",
        nowait = false,
        remap = false,
    },
    {
        "<leader>nm",
        function()
            local monthly_note = datastore_dir .. "monthly notes/" .. os.date "%B %Y" .. ".md"
            vim.notify("Opening monthly note: " .. monthly_note)
            vim.cmd("e " .. monthly_note)
        end,
        desc = "Open this month's note",
        nowait = false,
        remap = false,
    },
    {
        "<leader>nq",
        function()
            local quest_log_path = datastore_dir .. quest_log
            vim.notify("Opening quest log: " .. quest_log_path)
            vim.cmd("e " .. quest_log_path)
        end,
        desc = "Open quest log",
        nowait = false,
        remap = false,
    },
}

whichkey.add(keymap)
