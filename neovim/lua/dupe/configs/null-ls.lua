local null_ls = require('null-ls');

-- TODO: Potentially choose one out of: ruff, mypy
require('null-ls').setup({
    sources = {
        null_ls.builtins.diagnostics.mypy,
        null_ls.builtins.diagnostics.ruff,
    },
})

