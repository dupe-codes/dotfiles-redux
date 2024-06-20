-- dupe.functions.colors holds all data and utils for setting
-- colorscheme; only setup and loading of the colorscheme
-- lives in this file

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

require("decay").setup {
    style = "default",
    italics = {
        code = true,
        comments = true,
    },
}

require("nightfox").setup {
    options = {
        styles = {
            comments = "italic",
            functions = "italic",
            types = "italic",
        },
    },
}

require("kanagawa-paper").setup {
    commentStyle = { italic = true },
    functionStyle = { italic = true },
    typeStyle = { italic = true },
}

-- need to clear default colorscheme before loading custom
-- see https://github.com/neovim/neovim/issues/26378
vim.cmd "hi clear"
colors.load_colorscheme()

--#region color corrections
-- various tweaks that can't be applied elsewhere for ~reasons~

vim.api.nvim_set_hl(0, "CursorLineNr", { link = "Keyword" })
vim.api.nvim_set_hl(0, "ExtraWhitespace", { link = "DiagnosticUnderlineHint" })
vim.api.nvim_set_hl(0, "OverLength", { link = "DiagnosticUnderlineHint" })

--#endregion
