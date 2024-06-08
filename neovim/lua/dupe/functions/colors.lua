-- functions for managing color schemes

local M = {}

local FAVORITE_COLORSCHEMES = {
    "tokyonight-moon",
    "tokyonight-night",
    "nordic",
    "tokyobones",
    "nightfox",
    "carbonfox",
    "duskfox",
    "night-owl",
    "embark",
    "lavi",
}

local SAVED_COLORSCHEME_FILE = vim.fn.stdpath "data" .. "/colorscheme.txt"

M.load_colorscheme = function()
    local colorscheme = ""
    if vim.fn.filereadable(SAVED_COLORSCHEME_FILE) == 1 then
        colorscheme = vim.fn.system("cat " .. SAVED_COLORSCHEME_FILE):gsub("\n", "")
    end
    if colorscheme == "" then
        colorscheme = FAVORITE_COLORSCHEMES[1]
    end
    vim.cmd("colorscheme " .. colorscheme)
end

M.switch_colorscheme = function()
    vim.ui.select(FAVORITE_COLORSCHEMES, { prompt = "Select colorscheme" }, function(selected)
        if selected then
            vim.cmd("colorscheme " .. selected)
            vim.fn.system("echo " .. selected .. " > " .. SAVED_COLORSCHEME_FILE)
        end
    end)
end

return M
