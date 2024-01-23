local null_ls = require('null-ls');

-- set mypy to use python exe from current virtualenv
local python_env = require('swenv.api').get_current_venv()
local mypy_config = null_ls.builtins.diagnostics.mypy
if python_env then
    mypy_config = mypy_config.with({
        extra_args = { '--python-executable', python_env.path .. '/bin/python' }
    })
end

null_ls.setup({
    sources = {
        mypy_config,
        null_ls.builtins.diagnostics.ruff,
    },
})

