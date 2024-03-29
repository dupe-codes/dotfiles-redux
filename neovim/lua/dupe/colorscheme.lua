local function mod_hl(hl_name, opts)
  local is_ok, hl_def = pcall(vim.api.nvim_get_hl_by_name, hl_name, true)
  if is_ok then
    for k,v in pairs(opts) do hl_def[k] = v end
    vim.api.nvim_set_hl(0, hl_name, hl_def)
  end
end

vim.cmd('au ColorScheme * hi clear SignColumn')
--vim.cmd('au ColorScheme * hi Normal ctermbg=none guibg=none')

require('rose-pine').setup({
    variant = "moon",
    disable_italics = true,
})

require('catppuccin').setup({
    no_italic = true,
    integrations = {
        notify = true,
        harpoon = true,
        neotest = true,
    },
})

require('tokyonight').setup({
    styles = {
      comments  = { italic = true },
      functions = { italic = true },
      variables = { italic = false },
      keywords  = { italic = true },
  },
})

-- FAVORITES:
--vim.cmd.colorscheme 'kanagawa'
--vim.cmd.colorscheme "catppuccin"
--vim.cmd.colorscheme 'oxocarbon'
--vim.cmd.colorscheme 'zenburned'
--vim.cmd.colorscheme 'tokyobones'
--vim.cmd.colorscheme 'zenwritten'
--vim.cmd.colorscheme 'rosebones'
--vim.cmd.colorscheme 'rose-pine'
--vim.cmd.colorscheme 'duskfox'
--vim.cmd.colorscheme 'carbonfox'
--vim.cmd.colorscheme 'nightfox'
vim.cmd.colorscheme 'tokyonight-night'
--vim.cmd.colorscheme 'solarized-osaka'


----------------------------------------------
-- TODO: These need adjustments

--vim.cmd.colorscheme "mellifluous"
-- remove bg from icons
-- adjust color on lsp windows

--vim.cmd.colorscheme 'oh-lucy-evening'
-- change color of barbar background
-- lsp windows need big adjustments (e.g. borders)
-- visual selection colors need to change

--vim.cmd.colorscheme "night-owl"
--local italics_overrides = {
  --"Comment", "Constant", "Boolean",
  --"Function", "Statement", "Include",
  --"@class.constructor", "@type", "type.toml",
  --"tomlTable", "@keyword.if.vim", "@keyword.return.vim",
  --"@keyword.function.lua", "@keyword.function.vim",
  --"@keyword.function.return", "@keyword.function.abort",
  --"@namespace.vim", "@conditional.lua", "@variable.builtin.vim",
  --"@variable.object", "@object.property", "@object.key",
  --"@text.emphasis", "@tag.attribute", "@function.builtin.lua",
  --"NvimTreeWindowPicker",
--}
--for _,group in ipairs(italics_overrides) do
  --mod_hl(group, { italic=false, })
--end

--mod_hl("BufferCurrentMod", { fg = "LightGreen" })
--mod_hl("BufferInactiveMod", { fg = "LightGreen" })

---------------------------------------------

-- OTHERS:
--vim.cmd.colorscheme 'everforest'
--vim.cmd.colorscheme 'gruvbox'
--vim.cmd.colorscheme 'everblush'
--vim.cmd.colorscheme 'iceberg'
--vim.cmd.colorscheme 'mosel'
--vim.cmd.colorscheme 'nord'

