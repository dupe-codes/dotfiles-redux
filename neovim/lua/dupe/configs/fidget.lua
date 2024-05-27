local key_mapper = require("dupe.util").key_mapper

require("fidget").setup {
    notification = {
        override_vim_notify = true,
        window = {
            winblend = 0,
        },
    },
}

key_mapper("n", "<leader>sn", "<CMD>:Fidget history<CR>")
