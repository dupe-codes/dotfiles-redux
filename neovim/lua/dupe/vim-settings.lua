vim.cmd("highlight LineNr ctermbg=NONE guibg=NONE")

-- Set diagnostics signs
vim.cmd("sign define DiagnosticSignError text= texthl=DiagnosticSignError linehl= numhl=")
vim.cmd("sign define DiagnosticSignWarn text= texthl=DiagnosticSignWarn linehl= numhl=")
vim.cmd("sign define DiagnosticSignInfo text= texthl=DiagnosticSignInfo linehl= numhl=")
vim.cmd("sign define DiagnosticSignHint text= texthl=DiagnosticSignHint linehl= numhl=")
vim.cmd("set signcolumn=yes")

local hl = vim.api.nvim_set_hl
hl(0, "DiagnosticError", { fg = "#db4b4b", bg = clear })
hl(0, "DiagnosticSignError", { fg = "#db4b4b", bg = clear })
hl(0, "DiagnosticSignHint", { fg = "#10B981", bg = clear })
hl(0, "DiagnosticSignInfo", { fg = "#0db9d7", bg = clear })
hl(0, "DiagnosticSignWarn", { fg= "#e0af68", bg = clear })
