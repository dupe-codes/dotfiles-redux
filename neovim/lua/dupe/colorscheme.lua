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

-- FAVORITES:
--vim.cmd.colorscheme 'kanagawa'
vim.cmd.colorscheme "catppuccin"
--vim.cmd.colorscheme 'zenburned'
--vim.cmd.colorscheme 'rose-pine'

-- OTHERS:
--vim.cmd.colorscheme 'everforest'
--vim.cmd.colorscheme 'gruvbox'
--vim.cmd.colorscheme 'tokyonight-moon'
--vim.cmd.colorscheme 'everblush'
--vim.cmd.colorscheme 'iceberg'
--vim.cmd.colorscheme 'mosel'
--vim.cmd.colorscheme 'nord'
--vim.cmd.colorscheme 'oxocarbon'
--vim.cmd.colorscheme 'carbonfox'

