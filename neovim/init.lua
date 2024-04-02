-- Initialize lazy.vim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Load custom submodules

require("dupe.vim-settings")      -- Add vim settings from custom file
require("dupe.remap")             -- Add remaps in custom file
require("dupe.plugins")           -- Add lazy managed plugins
require("dupe.colorscheme")       -- Add colorscheme setup
require("dupe.lsp")               -- configure LSP, completions, and diagnostics
require("dupe.configs.racket")    -- config options for racket lang support
require("dupe.functions.init")    -- custom functions
