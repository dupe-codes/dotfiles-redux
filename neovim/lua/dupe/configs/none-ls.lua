local null_ls = require('null-ls');

-- set mypy to use python exe from current virtualenv
local python_env = require('swenv.api').get_current_venv()
local mypy_config = null_ls.builtins.diagnostics.mypy
if python_env then
    mypy_config = mypy_config.with({
        extra_args = { '--python-executable', python_env.path .. '/bin/python' }
    })
end

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
null_ls.setup({
    sources = {
        mypy_config,
        null_ls.builtins.formatting.black,
    },
    on_attach = function(client, bufnr)
        -- only set up if client is for python
        local filetype = vim.api.nvim_buf_get_option(0, "filetype")
        if filetype ~= "python" then
            return
        end
        if client.supports_method("textDocument/formatting") then
            vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
            vim.api.nvim_create_autocmd("BufWritePre", {
                group = augroup,
                buffer = bufnr,
                callback = function()
                    vim.lsp.buf.format({ async = false })
                end,
            })
        end
    end,
})

