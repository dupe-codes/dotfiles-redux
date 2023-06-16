require('rust-tools').setup({
    tools = {
        inlay_hints = {
            max_len_align = true,
            max_len_align_padding = 10,
            --right_align = true,
            --right_align_padding = 15,
        },
    },
    -- turn off dap config, we handle that elsewhere
    dap = {},
})

