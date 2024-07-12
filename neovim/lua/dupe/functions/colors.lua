-- functions for managing color schemes
--
-- supports loading selected color schemes (selections are cached in the FS)
-- and switching between favorite schemes
--
-- adjustments to colorschemes can also be specified, to tweak them
-- to my heart's desire :]

local lush = require "lush"
local lavi = require "lush_theme.lavi"

local M = {}

local tokyo_night_adjustments = {
    after = function()
        -- these default to unsatisfying colors
        vim.api.nvim_set_hl(0, "TelescopePromptBorder", { link = "TelescopeBorder" })
        vim.api.nvim_set_hl(0, "TelescopePromptTitle", { link = "TelescopeTitle" })
    end,
}

local lavi_adjustments = {
    after = function()
        local spec = lush.extends({ lavi }).with(function()
            return {
                Function { lavi.Function, gui = "italic" },
                Type { lavi.Type, gui = "italic" },
            }
        end)
        lush.apply(lush.compile(spec))
    end,
}

local embark_adjustments = {
    before = function()
        vim.cmd "let g:embark_terminal_italics = 1"
    end,
}

local nordic_adjustments = {
    after = function()
        -- override cursorline color and treesitter context
        vim.api.nvim_set_hl(0, "CursorLine", { link = "DiffChange" })
        vim.api.nvim_set_hl(0, "TreesitterContext", { link = "DiffAdd" })
        vim.api.nvim_set_hl(0, "Visual", { link = "DiffAdd" })
    end,
}

local night_owl_adjustments = {
    after = function()
        vim.api.nvim_set_hl(0, "CursorLine", { link = "Visual" })
        vim.api.nvim_set_hl(0, "TreesitterContext", { link = "Visual" })
    end,
}

local carbonfox_adjustments = {
    after = function()
        vim.api.nvim_set_hl(0, "TreesitterContext", { link = "CursorLine" })
    end,
}

local no_adjustments = {}

-- applies any resets necessary after loading a colorscheme
local apply_resets = function()
    require("dupe.configs.glance").reset()
end

-- FAVORITE_COLORSCHEMES serves two purposes:
-- 1. It provides a list of favorite color schemes that can be selected from, as
--    keys in the table
-- 2. It maps colorschemes to adjustments to apply to them when loaded. The format of
--    adjustments is expected as a table with as follows:
--    {
--      before = function to apply _before_ loading the colorscheme
--      after = function to apply _after_ loading the colorscheme
--    }
--    either key can be omitted if no adjustment at that stage is needed
local FAVORITE_COLORSCHEMES = {
    ["tokyonight-moon"] = tokyo_night_adjustments,
    ["tokyonight-night"] = tokyo_night_adjustments,
    ["nordic"] = nordic_adjustments,
    ["tokyobones"] = no_adjustments,
    ["nightfox"] = no_adjustments,
    ["carbonfox"] = carbonfox_adjustments,
    ["duskfox"] = no_adjustments,
    ["night-owl"] = night_owl_adjustments,
    ["embark"] = embark_adjustments,
    ["lavi"] = lavi_adjustments,
    ["kanagawa-paper"] = no_adjustments,
    ["kanagawa"] = no_adjustments,
    ["cyberdream"] = no_adjustments,
}

local DEFAULT_COLORSCHEME = "tokyonight-moon"
local SAVED_COLORSCHEME_FILE = vim.fn.stdpath "data" .. "/colorscheme.txt"

local apply_before = function(colorscheme)
    local before_fn = FAVORITE_COLORSCHEMES[colorscheme].before
    if before_fn then
        before_fn()
    end
end

local apply_after = function(colorscheme)
    local after_fn = FAVORITE_COLORSCHEMES[colorscheme].after
    if after_fn then
        after_fn()
    end
end

local clear = function()
    -- need to clear default colorscheme before loading custom
    -- see https://github.com/neovim/neovim/issues/26378
    vim.cmd "hi clear"
end

M.load_colorscheme = function()
    clear()

    local colorscheme = ""
    if vim.fn.filereadable(SAVED_COLORSCHEME_FILE) == 1 then
        colorscheme = vim.fn.system("cat " .. SAVED_COLORSCHEME_FILE):gsub("\n", "")
    end
    if colorscheme == "" or FAVORITE_COLORSCHEMES[colorscheme] == nil then
        vim.notify "Using default colorscheme..."
        colorscheme = DEFAULT_COLORSCHEME
    end

    apply_before(colorscheme)
    vim.notify("loading colorscheme: " .. colorscheme)
    vim.cmd("colorscheme " .. colorscheme)
    apply_after(colorscheme)
    apply_resets()
end

M.switch_colorscheme = function()
    local colorschemes = {}
    for k, _ in pairs(FAVORITE_COLORSCHEMES) do
        table.insert(colorschemes, k)
    end

    vim.ui.select(colorschemes, { prompt = "Select colorscheme" }, function(selected)
        if selected then
            clear()
            apply_before(selected)
            vim.cmd("colorscheme " .. selected)
            vim.fn.system("echo " .. selected .. " > " .. SAVED_COLORSCHEME_FILE)
            apply_after(selected)
            apply_resets()
        end
    end)
end

M.get_current_colorscheme = function()
    return vim.fn.system("cat " .. SAVED_COLORSCHEME_FILE):gsub("\n", "")
end

return M
