-- Load vimrc for initial configs and plugins
-- local vimrc = vim.fn.stdpath("config") .. "/vimrc.vim"
-- vim.cmd.source(vimrc)

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

require("dupe.vim-settings")  -- Add vim settings from custom file
require("dupe.remap")         -- Add remaps in custom file
require("dupe.plugins")       -- Add lazy managed plugins
require("dupe.colorscheme")   -- Add colorscheme setup
require("dupe.lsp")           -- configure lsp
