local key_mapper = require('dupe.util').key_mapper

key_mapper('n', '<leader>sc', ':lua require("dupe.functions.scratch").scratch()<CR>')
