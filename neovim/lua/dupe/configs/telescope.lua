local key_mapper = require('dupe.util').key_mapper

-- #region Keymappings

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
        },
        l = {
          ':lua TOGGLE_TELESCOPE_SETUP()<CR>',
          'Toggle telescope layout'
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

-- #endregion

-- #region Configuration

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

local h_percentage = 0.85
local w_percentage = 0.85
local w_limit = 80

local standard_setup = {
  borderchars = {
    --           N    E    S    W   NW   NE   SE   SW
    prompt =  { '─', '│', '─', '│', '┌', '┐', '┘', '└' },
    results = { '─', '│', '─', '│', '┌', '┐', '┘', '└' },
    preview = { '─', '│', '─', '│', '┌', '┐', '┘', '└' },
  },
  preview = { hide_on_startup = true },
  layout_strategy = 'vertical', -- HORIZONTAL, VERTICAL, FLEX
  layout_config = {
    vertical = {
      mirror = true,
      prompt_position = 'top',
      width = function(_, cols, _)
        return math.min( math.floor( w_percentage * cols ), w_limit )
      end,
      height = function(_, _, rows)
        return math.floor( rows * h_percentage )
      end,
      preview_cutoff = 10,
      preview_height = 0.4,
    },
  },
}

local fullscreen_setup = {
  borderchars = {
    --           N    E    S    W   NW   NE   SE   SW
    prompt =  { ' ', ' ', '─', ' ', ' ', ' ', ' ', ' ' },
    results = { ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ' },
    preview = { '─', '│', '─', '│', '┌', '┐', '┘', '└' },
  },
  preview = { hide_on_startup = false },
  layout_strategy = 'flex', -- HORIZONTAL, VERTICAL, FLEX
  layout_config = {
    flex = { flip_columns = 100 },
    horizontal = {
      mirror = false,
      prompt_position = 'top',
      width = function(_, cols, _)
        return cols
      end,
      height = function(_, _, rows)
        return rows
      end,
      preview_cutoff = 10,
      preview_width = 0.5,
    },
    vertical = {
      mirror = true,
      prompt_position = 'top',
      width = function(_, cols, _)
        return cols
      end,
      height = function(_, _, rows)
        return rows
      end,
      preview_cutoff = 10,
      preview_height = 0.4,
    },
  },
}

local function get_configuration(setup)
  return {
    defaults = vim.tbl_extend('error', setup, {
      results_title = '',
      sorting_strategy = 'ascending',
      border = { prompt = { 1, 1, 1, 1 }, results = { 1, 1, 1, 1 }, preview = { 1, 1, 1, 1 }, },
      path_display = { "filename_first" }, -- trunctate or filename_first
      mappings = {
        n = {
          ['o'] = require('telescope.actions.layout').toggle_preview,
          ['<C-c>'] = require('telescope.actions').close,
        },
        i = {
          ['<C-o>'] = require('telescope.actions.layout').toggle_preview,
        },
      },
    }),
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
end

TELESCOPE_FULLSCREEN = false
function TOGGLE_TELESCOPE_SETUP()
  TELESCOPE_FULLSCREEN = not TELESCOPE_FULLSCREEN
  if TELESCOPE_FULLSCREEN then
    require("telescope").setup(get_configuration(fullscreen_setup))
    vim.notify("Telescope in fullscreen mode", nil, { title = "Telescope" })
  else
    require("telescope").setup(get_configuration(standard_setup))
    vim.notify("Telescope in standard mode", nil, { title = "Telescope" })
  end
end

require("telescope").setup(get_configuration(standard_setup))
require("telescope").load_extension("ui-select")
require("telescope").load_extension("frecency")
