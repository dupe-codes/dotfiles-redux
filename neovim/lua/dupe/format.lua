local M = {}

M.plugins = {
    { "stevearc/conform.nvim" },
}

M.setup = function()
    local conform = require "conform"

    conform.setup {
        formatters_by_ft = {
            lua = { "stylua" },
            sh = { "shfmt" },
            ocaml = { "ocamlformat" },
            python = { "black" },
            zig = { "zigfmt" },
            gdscript = { "gdformat" },
            cs = { "csharpier" },
            javascript = { "prettierd" },
            javascriptreact = { "prettierd" },
            typescript = { "prettierd" },
            typescriptreact = { "prettierd" },
        },
    }

    -- set shfmt indentation to 4 spaces
    conform.formatters.shfmt = {
        prepend_args = { "-i", "4" },
    }

    -- TODO: experimenting with formatting on a keybind instead of on write
    --       on write was annoying because of latency in applying formatting changes
    local whichkey = require "which-key"
    local keymap = {
        { "<leader>p", group = "prettify", icon = "", nowait = false, remap = false },
        {
            "<leader>pf",
            function()
                local buffer = vim.api.nvim_get_current_buf()
                require("conform").format { bufnr = buffer }
            end,
            desc = "format file",
            nowait = false,
            remap = false,
        },
    }
    whichkey.add(keymap)

    --[[
   [vim.api.nvim_create_autocmd("BufWritePre", {
   [    pattern = "*",
   [    callback = function(args)
   [        require("conform").format { bufnr = args.buf }
   [    end,
   [})
   ]]
end

return M
