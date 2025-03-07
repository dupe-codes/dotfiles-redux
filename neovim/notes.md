# Assorted notes useful for reference when using neovim

For project or file specific notes, use gitpad notes (see [the gitpad config](./lua/dupe/configs/gitpad.lua))
or scratch buffers

# Project Configs

## ignore files/dirs in telescope

Anything in .gitignore will be ignored, but sometimes its useful to keep stuff tracked in git that
should be excluded when telescope searching. Easy fix: include a `.rgignore` file! This is used to
selectively ignore files when using ripgrep, the fuzzy finder powering telescope.
