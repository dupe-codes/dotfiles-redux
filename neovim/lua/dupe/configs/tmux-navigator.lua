local key_mapper = require('dupe.util').key_mapper

key_mapper('n', '<C-h>', '<cmd> TmuxNavigateLeft<CR>')
key_mapper('n', '<C-j>', '<cmd> TmuxNavigateDown<CR>')
key_mapper('n', '<C-k>', '<cmd> TmuxNavigateUp<CR>')
key_mapper('n', '<C-l>', '<cmd> TmuxNavigateRight<CR>')

