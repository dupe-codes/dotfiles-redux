require("neotest").setup {
    adapters = {
        require "neotest-python" {
            dap = { justMyCode = false },
        },
        require "neotest-vim-test" {
            ignore_file_types = { "python", "vim", "lua" },
        },
        require "neotest-rust",
        require "neotest-vitest",
    },
    summary = {
        open = "botright split | resize 15",
    },
}

local keymap = {
    { "<leader>t", group = "tests", nowait = false, remap = false },
    {
        "<leader>ta",
        "<cmd>lua require('neotest').run.run(vim.fn.expand('%'))<CR>",
        desc = "Run all tests",
        nowait = false,
        remap = false,
    },
    {
        "<leader>td",
        "<cmd>lua require('neotest').run.run({strategy = 'dap'})<CR>",
        desc = "Run nearest test with debugger",
        nowait = false,
        remap = false,
    },
    {
        "<leader>tr",
        "<cmd>lua require('neotest').run.run()<CR>",
        desc = "Run nearest test",
        nowait = false,
        remap = false,
    },
    {
        "<leader>ts",
        "<cmd>lua require('neotest').summary.toggle()<CR>",
        desc = "Toggle test summary",
        nowait = false,
        remap = false,
    },
}

local whichkey = require "which-key"
whichkey.add(keymap)
