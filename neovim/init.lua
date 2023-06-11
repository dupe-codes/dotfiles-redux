-- Load vimrc for initial configs and plugins
local vimrc = vim.fn.stdpath("config") .. "/vimrc.vim"
vim.cmd.source(vimrc)

-- Load custom submodules
require('dupe.colorscheme') -- Add colorscheme setup
require('dupe.remap') -- Add remaps in custom file
require('dupe.vim-settings') -- Add vim settings from custom file

