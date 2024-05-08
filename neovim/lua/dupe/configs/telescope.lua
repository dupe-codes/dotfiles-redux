local key_mapper = require('dupe.util').key_mapper

 --Set up telescope shortcuts for fuzzy finding
key_mapper('n', '<C-p>', ':lua require"telescope.builtin".find_files()<CR>')

local keymap = {
    f = {
        name = "Find & files",
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
        t = {
            '<cmd>TodoTelescope<CR>',
            "Search TODOs & notes"
        },
        i = {
            ':lua require"telescope.builtin".find_files({no_ignore=true})<CR>',
            'Search files including hidden/ignored'
        },
        c = {
            '<cmd>Telescope neoclip<CR>',
            'Search clipboard history'
        },
        j = {
            '<cmd>Telescope jumplist<CR>',
            'Search jumplist'
        },
        d = {
            '<cmd>Telescope command_history<CR>',
            'Search command history'
        },
        r = {
            '<cmd>Telescope frecency workspace=CWD<CR>',
            'Search files by frecency'
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
  pickers = {
    find_files = {
      hidden = true,
      file_ignore_patterns = { ".git/*" },
    },
  },
  extensions = {
    ["ui-select"] = {
      require("telescope.themes").get_dropdown {
        dropdown_configs
      }
    },
    ["frecency"] = {
      db_safe_mode = false,
    }
  }
}

require("telescope").load_extension("ui-select")
require("telescope").load_extension("frecency")
