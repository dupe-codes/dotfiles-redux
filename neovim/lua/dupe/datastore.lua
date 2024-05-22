local key_mapper = require("dupe.util").key_mapper

local todays_note = os.getenv "HOME" .. "/datastore/daily notes/" .. os.date "%Y-%m-%d" .. ".md"

key_mapper("n", "<leader>]", "<CMD>Oil --float ~/datastore<CR>")
key_mapper("n", "<leader>[", "<CMD>e " .. todays_note .. "<CR>")
