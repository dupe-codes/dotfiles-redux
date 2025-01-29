local whichkey = require "which-key"

local keymap = {
    { "<leader>g", group = "git", nowait = false, remap = false },
    { "<leader>gb", "<cmd>Git blame<CR>", desc = "Git blame", nowait = false, remap = false },
    { "<leader>gc", "<cmd>Gclog<CR>", desc = "Git change log", nowait = false, remap = false },
    {
        "<leader>gdc",
        "<cmd> lua require('dupe.configs.git-utils').diff_with() <CR>",
        desc = "Diff with commit",
        nowait = false,
        remap = false,
    },
    {
        "<leader>gdb",
        "<cmd> lua require('dupe.configs.git-utils').diff_with_branch() <CR>",
        desc = "Diff with branch",
        nowait = false,
        remap = false,
    },
    { "<leader>gh", "<cmd>diffget //2<CR>", desc = "Accept left git diff", nowait = false, remap = false },
    { "<leader>gl", "<cmd>diffget //3<CR>", desc = "Accept right git diff", nowait = false, remap = false },
    { "<leader>gm", "<cmd>Telescope git_commits<CR>", desc = "Search git commits", nowait = false, remap = false },
    { "<leader>go", "<cmd>Telescope git_status<CR>", desc = "Search changed files", nowait = false, remap = false },
    { "<leader>gp", "<cmd>Git push<CR>", desc = "Git push", nowait = false, remap = false },
    { "<leader>gr", "<cmd>Telescope git_branches<CR>", desc = "Search git branches", nowait = false, remap = false },
    { "<leader>gs", "<cmd>:Git<CR>", desc = "Git status", nowait = false, remap = false },
}

whichkey.add(keymap)
