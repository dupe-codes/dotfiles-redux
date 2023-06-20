local key_mapper = require('dupe.util').key_mapper

-- Set up nvim-tree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.termguicolors = true
require("nvim-tree").setup({
    view = {
        adaptive_size = true,
    },
})

local function open_nvim_tree()
    -- open the tree
    -- require("nvim-tree.api").tree.open()
    require("nvim-tree.api").tree.toggle({ focus = false })
end
vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })

key_mapper('n', '<leader>ff', ':NvimTreeFindFile<CR>')
key_mapper('n', '<leader>nt', ':NvimTreeToggle<CR>')

-- TODO: Fix symbol for new file

