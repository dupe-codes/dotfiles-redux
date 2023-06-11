local key_mapper = require('dupe.util').key_mapper

key_mapper('n', '<leader>1', ':BufferGoto 1<CR>')
key_mapper('n', '<leader>2', ':BufferGoto 2<CR>')
key_mapper('n', '<leader>3', ':BufferGoto 3<CR>')
key_mapper('n', '<leader>4', ':BufferGoto 4<CR>')
key_mapper('n', '<leader>5', ':BufferGoto 5<CR>')
key_mapper('n', '<leader>6', ':BufferGoto 6<CR>')
key_mapper('n', '<leader>7', ':BufferGoto 7<CR>')
key_mapper('n', '<leader>8', ':BufferGoto 8<CR>')
key_mapper('n', '<leader>.', ':BufferNext<CR>')
key_mapper('n', '<leader>,', ':BufferPrevious<CR>')
key_mapper('n', '<leader>q', ':BufferClose<CR>')
key_mapper('n', '<leader>aq', ':BufferCloseAllButCurrent<CR>')

require('barbar').setup {
    icons = {
        filetype = {
            enabled = true,
        },
        modified = {button = '~'},
   }
}


