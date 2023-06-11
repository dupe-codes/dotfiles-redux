local key_mapper = require('dupe.util').key_mapper

-- Setup glance keymappers
key_mapper('n', '<leader>gd', '<CMD>Glance definitions<CR>')
key_mapper('n', '<leader>gr', '<CMD>Glance references<CR>')
key_mapper('n', '<leader>gy', '<CMD>Glance type_definitions<CR>')
key_mapper('n', '<leader>gm', '<CMD>Glance implementations<CR>')

