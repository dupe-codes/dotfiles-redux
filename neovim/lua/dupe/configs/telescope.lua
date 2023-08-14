local key_mapper = require('dupe.util').key_mapper

 --Set up telescope shortcuts for fuzzy finding
key_mapper('n', '<C-p>', ':lua require"telescope.builtin".find_files()<CR>')

local keymap = {
    f = {
        name = "Find",
        s = {
            ':lua require"telescope.builtin".live_grep()<CR>',
            "Fuzzy search"
        },
        h = {
            ':lua require"telescope.builtin".help_tags()<CR>',
            "Search help tags"
        },
        b = {
            ':lua require"telescope.builtin".buffers()<CR>',
            "Search buffers"
        },
        c = {
            '<cmd>TodoTelescope<CR>',
            "Search TODOs & notes"
        },
        i = {
          ':lua require"telescope.builtin".find_files({no_ignore=true})<CR>',
          'Search files including hidden/ignored'
        }
    }
}

local whichkey = require("which-key")
whichkey.register(keymap, {
    mode = "n",
    prefix = "<leader>",
    buffer = nil,
    silent = true,
    noremap = true,
    nowait = false,
})

local dropdown_configs = {
  layout_strategy = "vertical",
  layout_config = {
    prompt_position = "bottom",
    vertical = {
      width = 0.8,
      height = 100,
    },
  },
}

require("telescope").setup {
  extensions = {
    ["ui-select"] = {
      require("telescope.themes").get_dropdown {
        dropdown_configs
      }
    }
  }
}
require("telescope").load_extension("ui-select")

