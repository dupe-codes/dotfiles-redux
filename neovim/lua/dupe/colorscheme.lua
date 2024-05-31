local function mod_hl(hl_name, opts)
    local is_ok, hl_def = pcall(vim.api.nvim_get_hl_by_name, hl_name, true)
    if is_ok then
        for k, v in pairs(opts) do
            hl_def[k] = v
        end
        vim.api.nvim_set_hl(0, hl_name, hl_def)
    end
end

vim.cmd "au ColorScheme * hi clear SignColumn"
--vim.cmd('au ColorScheme * hi Normal ctermbg=none guibg=none')

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
--  1. cursorline color is too dark
--  2. extra whitespace highlight doesn't work
--  3. line > 80 char highlight doesn't work
--vim.cmd.colorscheme "oldworld"

--vim.cmd.colorscheme 'kanagawa'
--vim.cmd.colorscheme "catppuccin"
--vim.cmd.colorscheme 'oxocarbon'
--vim.cmd.colorscheme 'zenburned'
--vim.cmd.colorscheme 'tokyobones'
--vim.cmd.colorscheme "zenwritten"
--vim.cmd.colorscheme "rosebones"
--vim.cmd.colorscheme 'duskfox'
--vim.cmd.colorscheme 'carbonfox'
--vim.cmd.colorscheme 'nightfox'
--vim.cmd.colorscheme "solarized-osaka"

----------------------------------------------
-- TODO: These need adjustments

--vim.cmd.colorscheme "mellifluous"
-- remove bg from icons
-- adjust color on lsp windows

--vim.cmd.colorscheme "oh-lucy-evening"
-- change color of barbar background
-- lsp windows need big adjustments (e.g. borders)
-- visual selection colors need to change

vim.cmd.colorscheme "night-owl"

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

---------------------------------------------

-- OTHERS:
--vim.cmd.colorscheme 'everforest'
--vim.cmd.colorscheme 'gruvbox'
--vim.cmd.colorscheme 'everblush'
--vim.cmd.colorscheme 'iceberg'
--vim.cmd.colorscheme 'mosel'
--vim.cmd.colorscheme 'nord'

--#region color corrections
-- various tweaks that can't be applied elsewhere for ~reasons~

-- something (a plugin?) is setting these to an unsatisfying orange. override here
-- since this config is evaluated _after_ plugins are loaded
vim.api.nvim_set_hl(0, "TelescopePromptBorder", { link = "TelescopeBorder" })
vim.api.nvim_set_hl(0, "TelescopePromptTitle", { link = "TelescopeTitle" })
vim.api.nvim_set_hl(0, "CursorLineNr", { link = "Type" })

--#endregion
