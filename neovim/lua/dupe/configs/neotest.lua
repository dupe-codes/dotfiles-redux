local key_mapper = require('dupe.util').key_mapper

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

key_mapper("n", "<leader>tr", [[:lua require("neotest").run.run() <CR>]])
key_mapper("n", "<leader>ta", [[:lua require("neotest").run.run(vim.fn.expand("%")) <CR>]])
key_mapper("n", "<leader>ts", [[:lua require("neotest").summary.toggle() <CR>]])

