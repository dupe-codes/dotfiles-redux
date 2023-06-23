local key_mapper = require('dupe.util').key_mapper

require("chatgpt").setup({})

key_mapper('v', '<C-e>', '<cmd> ChatGPTRun explain_code<CR>')
key_mapper('v', '<C-t>', '<cmd> ChatGPTRun add_tests<CR>')
--key_mapper('v', '<C-i>', '<cmd> ChatGPTEditWithInstructions<CR>')
key_mapper('n', '<C-g>', '<cmd> ChatGPT<CR>')

