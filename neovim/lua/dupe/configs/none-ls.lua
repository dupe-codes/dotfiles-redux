local null_lus = require('null-ls');

-- TODO: Potentially choose one out of: ruff, mypy
null_lus.setup({
    sources = {
        null_lus.builtins.diagnostics.mypy,
        null_lus.builtins.diagnostics.ruff,
    },
})

