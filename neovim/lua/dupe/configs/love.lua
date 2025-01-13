-- grab the LÖVE binary location

local handle = io.popen "command -v love 2>/dev/null"

if not handle then
    vim.notify("Failed to grab LÖVE install location", vim.log.levels.WARN)
    return
end

local love_path = handle:read("*a"):gsub("%s+", "")
handle:close()

if love_path == "" then
    vim.notify("LÖVE is not installed or not in PATH.", vim.log.levels.WARN)
    return
end

require("love2d").setup {
    path_to_love_bin = love_path,
}

local keymap = {
    { "<leader>l", group = "LÖVE game engine", icon = "", nowait = false, remap = false },
    { "<leader>lr", "<cmd>LoveRun<cr>", desc = "Run LÖVE" },
    { "<leader>ls", "<cmd>LoveStop<cr>", desc = "Stop LÖVE" },
}

local whichkey = require "which-key"
whichkey.add(keymap)
