local key_mapper = require("dupe.util").key_mapper
local make = require "dupe.functions.make"

-- #region Keymappings

--Set up telescope shortcuts for fuzzy finding
key_mapper("n", "<C-p>", ':lua require"telescope.builtin".find_files()<CR>')

local builtin = require "telescope.builtin"
local utils = require "telescope.utils"

local keymap = {
    { "<leader>f", group = "find, grep, & files", nowait = false, remap = false },
    {
        "<leader>fb",
        ':lua require"telescope.builtin".buffers()<CR>',
        desc = "Search buffers",
        nowait = false,
        remap = false,
    },
    { "<leader>fc", "<cmd>Telescope neoclip<CR>", desc = "Search clipboard history", nowait = false, remap = false },
    {
        "<leader>fd",
        "<cmd>Telescope command_history<CR>",
        desc = "Search command history",
        nowait = false,
        remap = false,
    },
    {
        "<leader>fh",
        ':lua require"telescope.builtin".help_tags()<CR>',
        desc = "Search help tags",
        nowait = false,
        remap = false,
    },
    {
        "<leader>fi",
        ':lua require"telescope.builtin".find_files({no_ignore=true})<CR>',
        desc = "Search files including hidden/ignored",
        nowait = false,
        remap = false,
    },
    { "<leader>fj", "<cmd>Telescope jumplist<CR>", desc = "Search jumplist", nowait = false, remap = false },
    {
        "<leader>fm",
        ':lua require"dupe.functions.make".list_targets()<CR>',
        desc = "Search makefile targets",
        nowait = false,
        remap = false,
    },
    {
        "<leader>fr",
        "<cmd>Telescope frecency workspace=CWD<CR>",
        desc = "Search files by frecency",
        nowait = false,
        remap = false,
    },
    {
        "<leader>fs",
        ':lua require"telescope.builtin".live_grep()<CR>',
        desc = "Fuzzy search",
        nowait = false,
        remap = false,
    },
    { "<leader>ft", "<cmd>TodoTelescope<CR>", desc = "Search TODOs & notes", nowait = false, remap = false },
    {
        "<leader>fw",
        function()
            builtin.find_files {
                cwd = utils.buffer_dir(),
                find_command = { "fd", "--type", "f", "--max-depth", "1" },
            }
        end,
        desc = "Find files in cwd",
        nowait = false,
        remap = false,
    },
    {
        "<leader>fy",
        ':lua require"telescope.builtin".lsp_dynamic_workspace_symbols()<CR>',
        desc = "Search LSP s(y)mbols",
        nowait = false,
        remap = false,
    },
}

local whichkey = require "which-key"
whichkey.add(keymap)

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
