-- TODO: clean up this file. trim colorschemes down to
-- favorites and list them in dupe.functions.colors.
--
-- dupe.functions.colors holds all data and utils for setting
-- colorscheme; setup lives in this file
--
-- misc TODOs:
-- 1. add italics to embark
-- 2. add italics to lavi

local colors = require "dupe.functions.colors"

vim.cmd "au ColorScheme * hi clear SignColumn"

require("rose-pine").setup {
    variant = "moon",
    disable_italics = true,
}

require("catppuccin").setup {
    no_italic = true,
    integrations = {
        notify = true,
        harpoon = true,
        neotest = true,
    },
}

require("tokyonight").setup {
    styles = {
        comments = { italic = true },
        functions = { italic = true },
        variables = { italic = false },
        keywords = { italic = true },
    },
}

-- FAVORITES:

--vim.cmd.colorscheme "eldritch"
--vim.cmd.colorscheme "spaceduck"
--vim.cmd.colorscheme "tokyonight-night"
--vim.cmd.colorscheme "panda"
--vim.cmd.colorscheme "rose-pine"
--require "dupe.colors.tokyo-panda"

--require('decay').setup({
--style = 'default',
--italics = {
--code = true,
--comments = true
--},
--})

-- TODO: i like oldworld, but it needs a few tweaks:
--  1. get rid of transparent background behind some window titles
--  2. patch TelescopeTitle so it is visible
--  3. color on indent blank line guides
--  4. cursorline is too dark with dark bgs; lighten it
--vim.cmd.colorscheme "oldworld"
--vim.api.nvim_set_hl(0, "TelescopeTitle", { link = "Character" })
--require("ibl").setup {
--exclude = {
--filetypes = { "dashboard" },
--},
--indent = {
--highlight = {
--"Comment",
--},
--},
--scope = {
--highlight = {
--"Special",
--},
--},
--}

----------------------------------------------
-- TODO: These need adjustments

--vim.cmd.colorscheme "mellifluous"
-- remove bg from icons
-- adjust color on lsp windows

--vim.cmd.colorscheme "oh-lucy-evening"
-- change color of barbar background
-- lsp windows need big adjustments (e.g. borders)
-- visual selection colors need to change

-- TODO: adjust cursorline color
--vim.cmd.colorscheme "night-owl"

-- NOTE: optionally remove italics for night-owl colorscheme
--[[
   [local italics_overrides = {
   [    "Comment",
   [    "Constant",
   [    "Boolean",
   [    "Function",
   [    "Statement",
   [    "Include",
   [    "@class.constructor",
   [    "@type",
   [    "type.toml",
   [    "tomlTable",
   [    "@keyword.if.vim",
   [    "@keyword.return.vim",
   [    "@keyword.function.lua",
   [    "@keyword.function.vim",
   [    "@keyword.function.return",
   [    "@keyword.function.abort",
   [    "@namespace.vim",
   [    "@conditional.lua",
   [    "@variable.builtin.vim",
   [    "@variable.object",
   [    "@object.property",
   [    "@object.key",
   [    "@text.emphasis",
   [    "@tag.attribute",
   [    "@function.builtin.lua",
   [    "NvimTreeWindowPicker",
   [}
   [
   [for _, group in ipairs(italics_overrides) do
   [    mod_hl(group, { italic = false })
   [end
   ]]

require("nightfox").setup {
    options = {
        styles = {
            comments = "italic",
            functions = "italic",
            types = "italic",
        },
    },
}

---------------------------------------------

colors.load_colorscheme()

--#region color corrections
-- various tweaks that can't be applied elsewhere for ~reasons~

vim.api.nvim_set_hl(0, "CursorLineNr", { link = "Keyword" })
vim.api.nvim_set_hl(0, "ExtraWhitespace", { link = "DiagnosticUnderlineHint" })
vim.api.nvim_set_hl(0, "OverLength", { link = "DiagnosticUnderlineHint" })

--#endregion
