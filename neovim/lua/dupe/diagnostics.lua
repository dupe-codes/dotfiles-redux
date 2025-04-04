local key_mapper = require("dupe.util").key_mapper

local M = {}

function _G.open_floating_diagnostics()
    local _, winnr = vim.diagnostic.open_float(0, { scope = "line" })
    if winnr then
        vim.api.nvim_set_current_win(winnr)
    end
end

M.setup = function()
    local _border = "single"
    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
        border = _border,
    })

    vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
        border = _border,
    })

    vim.diagnostic.config {
        float = { border = _border },
        underline = true,
        virtual_text = false,
        virtual_lines = true,
        signs = true,
        update_in_insert = true,
        severity_sort = true,
    }

    key_mapper("n", "<Leader>e", "<Cmd>lua _G.open_floating_diagnostics()<CR>")
end

return M
