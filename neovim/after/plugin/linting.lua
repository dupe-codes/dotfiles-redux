-- Setup linting
require('lint').linters_by_ft = {
    python = { 'pylint', },
}

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  callback = function()
    require("lint").try_lint()

    -- Also match on extra whitespace
    vim.cmd([[match ExtraWhitespace /\s\+$/]])
  end,
})

