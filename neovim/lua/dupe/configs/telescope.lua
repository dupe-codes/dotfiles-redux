local key_mapper = require("dupe.util").key_mapper
local make = require "dupe.functions.make"

-- #region Keymappings

--Set up telescope shortcuts for fuzzy finding
key_mapper("n", "<C-p>", ':lua require"telescope.builtin".find_files()<CR>')

local builtin = require "telescope.builtin"
local utils = require "telescope.utils"

local keymap = {
    f = {
        name = "find, grep, & files",
        s = {
            ':lua require"telescope.builtin".live_grep()<CR>',
            "Fuzzy search",
        },
        -- search cwd excluding subdirectories
        w = {
            function()
                builtin.find_files {
                    cwd = utils.buffer_dir(),
                    find_command = { "fd", "--type", "f", "--max-depth", "1" },
                }
            end,
            "Find files in cwd",
        },
        h = {
            ':lua require"telescope.builtin".help_tags()<CR>',
            "Search help tags",
        },
        b = {
            ':lua require"telescope.builtin".buffers()<CR>',
            "Search buffers",
        },
        t = {
            "<cmd>TodoTelescope<CR>",
            "Search TODOs & notes",
        },
        i = {
            ':lua require"telescope.builtin".find_files({no_ignore=true})<CR>',
            "Search files including hidden/ignored",
        },
        c = {
            "<cmd>Telescope neoclip<CR>",
            "Search clipboard history",
        },
        j = {
            "<cmd>Telescope jumplist<CR>",
            "Search jumplist",
        },
        d = {
            "<cmd>Telescope command_history<CR>",
            "Search command history",
        },
        r = {
            "<cmd>Telescope frecency workspace=CWD<CR>",
            "Search files by frecency",
        },
        y = {
            ':lua require"telescope.builtin".lsp_dynamic_workspace_symbols()<CR>',
            "Search LSP s(y)mbols",
        },
        m = {
            ':lua require"dupe.functions.make".list_targets()<CR>',
            "Search makefile targets",
        },
    },
}

local whichkey = require "which-key"
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

local standard_setup = {
    borderchars = {
        --           N    E    S    W   NW   NE   SE   SW
        prompt = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
        results = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
        preview = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
    },
    preview = { hide_on_startup = true },
    layout_strategy = "vertical", -- HORIZONTAL, VERTICAL, FLEX
    layout_config = {
        vertical = {
            mirror = true,
            prompt_position = "top",
            preview_cutoff = 10,
            preview_height = 0.4,
        },
    },
}

local function get_configuration(setup)
    return {
        defaults = vim.tbl_extend("error", setup, {
            results_title = "",
            sorting_strategy = "ascending",
            border = { prompt = { 1, 1, 1, 1 }, results = { 1, 1, 1, 1 }, preview = { 1, 1, 1, 1 } },
            path_display = { "filename_first" }, -- trunctate or filename_first
            mappings = {
                n = {
                    ["o"] = require("telescope.actions.layout").toggle_preview,
                    ["<C-c>"] = require("telescope.actions").close,
                },
                i = {
                    ["<C-o>"] = require("telescope.actions.layout").toggle_preview,
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
                    dropdown_configs,
                },
            },
            ["frecency"] = {
                db_safe_mode = false,
            },
        },
    }
end

require("telescope").setup(get_configuration(standard_setup))
require("telescope").load_extension "ui-select"
require("telescope").load_extension "frecency"
