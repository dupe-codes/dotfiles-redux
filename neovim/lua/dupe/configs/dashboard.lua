-- Custom dashboard configuration
--  TODO:
--    - bookmarked notes/files
--        - select from configured list using vim.ui.select

local read_file_contents = require("dupe.util").read_file_contents

local header_file = "take-your-time.txt"
local file_path = os.getenv "HOME" .. "/ascii-art/" .. header_file
local header = read_file_contents(file_path)
if not header then
    header = { "" }
end
table.insert(header, "")
table.insert(header, "❯❯❯  take your time  ❮❮❮")
table.insert(header, "")
table.insert(header, "")

local todays_note = os.getenv "HOME" .. "/datastore/daily notes/" .. os.date "%Y-%m-%d" .. ".md"
local quest_log = os.getenv "HOME" .. "/datastore/05 - quest journal/00 - quest log.md"

local center = {
    {
        icon = " ",
        icon_hl = "Title",
        desc = "New file",
        desc_hl = "String",
        key = "n",
        keymap = "",
        key_hl = "Number",
        key_format = " %s",
        action = "ene",
    },
    {
        icon = " ",
        icon_hl = "Title",
        desc = "File explorer",
        desc_hl = "String",
        key = "e",
        keymap = "",
        key_hl = "Number",
        key_format = " %s",
        action = "Oil",
    },
    {
        icon = " ",
        icon_hl = "Title",
        desc = "Load session",
        desc_hl = "String",
        key = "l",
        keymap = "",
        key_hl = "Number",
        key_format = " %s",
        action = 'lua require("dupe.configs.sessions").load_session()',
    },
    {
        icon = " ",
        icon_hl = "Title",
        desc = "Start session",
        desc_hl = "String",
        key = "s",
        keymap = "",
        key_hl = "Number",
        key_format = " %s",
        action = 'lua require("dupe.configs.sessions").start_session()',
    },

    {
        icon = " ",
        icon_hl = "Title",
        desc = "Recent files",
        desc_hl = "String",
        key = "r",
        keymap = "",
        key_hl = "Number",
        key_format = " %s",
        action = "Telescope oldfiles",
    },
    {
        icon = " ",
        icon_hl = "Title",
        desc = "Frecent files",
        desc_hl = "String",
        key = "f",
        keymap = "",
        key_hl = "Number",
        key_format = " %s",
        action = "Telescope frecency",
    },
    {
        icon = " ",
        icon_hl = "Title",
        desc = "Open notes",
        desc_hl = "String",
        key = "o",
        keymap = "",
        key_hl = "Number",
        key_format = " %s",
        action = "Oil --float ~/datastore",
    },
    {
        icon = "🗡",
        icon_hl = "Title",
        desc = "Quest log",
        desc_hl = "String",
        key = "q",
        keymap = "",
        key_hl = "Number",
        key_format = " %s",
        action = "e " .. quest_log,
    },
    {
        icon = " ",
        icon_hl = "Title",
        desc = "Today's note",
        desc_hl = "String",
        key = "t",
        keymap = "",
        key_hl = "Number",
        key_format = " %s",
        action = "e " .. todays_note,
    },
}

require("dashboard").setup {
    theme = "doom",
    config = {
        header = header,
        center = center,
        footer = function()
            return {
                "",
                "─── " .. os.date "%a, %m / %d / %Y" .. " ───",
            }
        end,
    },
}
