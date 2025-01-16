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
