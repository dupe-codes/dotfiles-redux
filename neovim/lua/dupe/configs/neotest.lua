-- TODO: Figure out test debugging capabilities
require("neotest").setup({
    adapters = {
        require("neotest-python")({
            dap = { justMyCode = false },
        }),
        require("neotest-vim-test")({
            ignore_file_types = { "python", "vim", "lua" },
        }),
        require("neotest-rust"),
    },
})

local keymap = {
    t = {
        name = "Tests",
        r = {
            "<cmd>lua require('neotest').run.run()<CR>",
            "Run nearest test"
        },
        a = {
            "<cmd>lua require('neotest').run.run(vim.fn.expand('%'))<CR>",
            "Run all tests"
        },
        s = {
            "<cmd>lua require('neotest').summary.toggle()<CR>",
            "Toggle test summary"
        },
    }
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

