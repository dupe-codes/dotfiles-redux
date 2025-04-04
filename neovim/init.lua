local is_quickfix_mode = require("dupe.util").is_quickfix_mode
local enable_transparency = require("dupe.functions.transparency").enable_transparency

-- initialize lazy.vim
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system {
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    }
end
vim.opt.rtp:prepend(lazypath)

-- load custom submodules
require "dupe.vim-settings" -- add vim setting options
require "dupe.remap" -- add general remaps
require "dupe.plugins" -- add lazy managed plugins
require "dupe.configs.racket" -- config options for racket lang support
require "dupe.functions.init" -- initialize custom functions
require "dupe.snippets.init" -- initialize custom snippets
require "dupe.datastore" -- interactions with my obsidian 'datastore'
require "dupe.colorscheme" -- setup colorscheme (& other color related tweaks)

-- new giga setup
require("dupe.lsp").setup()
require("dupe.completions").setup()
require("dupe.diagnostics").setup()
require("dupe.format").setup()

enable_transparency()

-- prompt to load session for current project, if one exists and
-- neovim wasn't launched with arguments and/or quickfix selections
local args = vim.fn.argv()
if #args == 0 and not is_quickfix_mode() then
    require("dupe.configs.sessions").load_session_matching_default_name()
end
