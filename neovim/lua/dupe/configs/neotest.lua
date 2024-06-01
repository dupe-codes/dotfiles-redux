require("neotest").setup {
    adapters = {
        require "neotest-python" {
            dap = { justMyCode = false },
        },
        require "neotest-vim-test" {
            ignore_file_types = { "python", "vim", "lua" },
        },
        require "neotest-rust",
    },
}

local keymap = {
    t = {
        name = "tests",
        r = {
            "<cmd>lua require('neotest').run.run()<CR>",
            "Run nearest test",
        },
        a = {
            "<cmd>lua require('neotest').run.run(vim.fn.expand('%'))<CR>",
            "Run all tests",
        },
        s = {
            "<cmd>lua require('neotest').summary.toggle()<CR>",
            "Toggle test summary",
        },
        d = {
            "<cmd>lua require('neotest').run.run({strategy = 'dap'})<CR>",
            "Run nearest test with debugger",
        },
    },
}

local whichkey = require "which-key"
whichkey.register(keymap, {
    mode = "n",
    prefix = "<leader>",
    buffer = nil,
    silent = true,
    noremap = true,
    nowait = false,
})
