local key_mapper = require('dupe.util').key_mapper

require("neotest").setup({
    adapters = {
        require("neotest-python")({
            dap = { justMyCode = false },
        }),
        require("neotest-plenary"),
        require("neotest-vim-test")({
            ignore_file_types = { "python", "vim", "lua" },
        }),
    },
})

key_mapper("n", "<leader>rt", [[:lua require("neotest").run.run() <CR>]])
key_mapper("n", "<leader>ra", [[:lua require("neotest").run.run(vim.fn.expand("%"))]])

