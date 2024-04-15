-- Settings and configs for plugins I categorize as "tools".
-- These include:
--      rest.nvim     for making HTTP requests, a Postman replacement
--      vim-dadbod    ui and plugin for querying databases

require("rest-nvim").setup(
    {
        result = {
            split = {
                horizontal = true,
                in_place = false,
            }
        }
    }
)
vim.g.db_ui_use_nerd_fonts = 1

-- set up autocommand to properly detect http file types
local augroup_http = vim.api.nvim_create_augroup("http-filetype", { clear = true })
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
    group = augroup_http,
    pattern = "*.http",
    command = ":set ft=http",
})

local keymap = {
    z = {
        name = "tools",
        r = {
            name = "requests",
            r = {
                "<CMD>Rest run<CR>",
                "Run http request under cursor"
            },
            l = {
                "<CMD>Rest run last<CR>",
                "Rerun last http request"
            },
        },
        d = {
            name = "databases",
            o = {
                ':DBUI<CR>',
                "open databases ui"
            },
        }
    },
}

local whichkey = require("which-key")
whichkey.register(keymap, {
    mode = "n",
    prefix = "<leader>",
    buffer = nil,
    silent = true,
    noremap = true,
    nowait = false,
})
