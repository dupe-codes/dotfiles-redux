require('nvim-lightbulb').setup({
    autocmd = { enabled = true },
})

vim.o.updatetime = 1000

vim.fn.sign_define('LightBulbSign', {
    text = "󰌶",
    texthl = "DiagnosticSignHint",
    linehl="",
    numhl=""
})

--vim.api.nvim_command('highlight LightBulbFloatWin ctermfg= ctermbg= guifg= guibg=')
--vim.api.nvim_command('highlight LightBulbVirtualText ctermfg= ctermbg= guifg= guibg=')
