local whichkey = require "which-key"

local keymap = {
    g = {
        name = "git",
        s = { "<cmd>:Git<CR>", "Git status" },
        h = { "<cmd>diffget //2<CR>", "Accept left git diff" },
        l = { "<cmd>diffget //3<CR>", "Accept right git diff" },
        p = { "<cmd>Git push<CR>", "Git push" },
        b = { "<cmd>Git blame<CR>", "Git blame" },
        c = { "<cmd>Gclog<CR>", "Git change log" },
        o = { "<cmd>Telescope git_status<CR>", "Search changed files" },
        r = { "<cmd>Telescope git_branches<CR>", "Search git branches" },
        m = { "<cmd>Telescope git_commits<CR>", "Search git commits" },
        d = { "<cmd> lua require('dupe.configs.git-utils').diffWith() <CR>", "Diff with" },
    },
}

whichkey.register(keymap, {
    mode = "n",
    prefix = "<leader>",
    buffer = nil,
    silent = true,
    noremap = true,
    nowait = false,
})
