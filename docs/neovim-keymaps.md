# Neovim Keymaps

An index of my most important neovim keymaps.

## General

| Action | Key Map |
|--------|---------|
| Open split view pane (horizontal) | `<C-w> s` |
| Open split view pane (vertical) | `<C-w> v` |
| Move between open panes | `<leader>h`, `<leader>j`, `<leader>k`, `<leader>l` |
| Close all open panes | `<C-w> o` |
| Clear search buffer | `<leader><leader>` |
| Move visual selection | `'v', 'J'`, `'v', 'K'` |
| Yank into system clipboard | `'n', '<leader>y'`, `'v', '<leader>y'`, `'n', '<leader>Y'` |
| Replace in file text at current cursor | `"n", "<leader>s"` |

## Telescope fuzzy finding

| Action | Key Map |
|--------|---------|
| find_files() | `<C-p>` |
| live_grep() | `<leader>fs` |

## Buffer management & navigation

Barbar:

| Action | Key Map |
|--------|---------|
| Buffer goto | `'n', '<leader>1'` through to `'n', '<leader>8'` |
| Buffernext | `'n', '<leader>.'` |
| Bufferprevious | `'n', '<leader>,'` |
| BufferCloseAllButCurrent | `'n', '<leader>aq'` |
| bufferclose | `'n', '<leader>q'` |

Harpoon:

| Action | Key Map |
|--------|---------|
| mark.add_file | `"n", "<leader>a"` |
| ui.toggle_quick_menu | `"n", "<C-e>"` |
| ui.nav_file | `"n", "<C-h>"` through to `"n", "<C-l>"` |
| Go back and forth to/from last buffer | `'n', '<leader>b'` |

## nvim-tree/creating new files

| Action | Key Map |
|--------|---------|
| Add file or directory | (in tree) `a` |
| Delete file or directory | (in tree) `d`) |
| Rename a file or directory | (in tree) `<C-r>`) |
| NvimTreeFindFile | `'n', '<leader>ff'` |
| NvimTreeToggle | `'n', '<leader>nt'` |

## language server/completions/code introspection

| Action | Key Map |
|--------|---------|
| Type definition | `'n', '<leader>D'` |
| Code action | `'n', '<leader>ca'` |
| Rename | `'n', '<leader>rn'` |
| Open docs on current cursor | `'n', K` |
| Open manual entry at cursor | `'n', K -> K -> K` |
| Open floating diagnostics | `'n', '<Leader>e'` |
| Move forward/back in completions | `<C-f> <C-b>` |
| Abort completions | `<C-e>` |
| Accept completion | `<Tab>` |
| Glance definitions | `'n', '<leader>gd'` |
| Glance references | `'n', '<leader>gr'` |
| Glance type_definitions | `'n', '<leader>gy'` |
| Glance implementations | `'n', '<leader>gm'` |

## Nerdcommenter

| Action | Key Map |
|--------|---------|
| Comment | `'n', '<leader>cc'` |
| Uncomment | `'n', '<leader>cu'` |
| Toggle comment | `'n', '<leader>c<space>'` |

## Using the terminal

| Action | Key Map |
|--------|---------|
| Toggle terminal | `'n', '<C-\>'` |

## Undotree

| Action | Key Map |
|--------|---------|
| Open undotree and focus it | `'n', '<leader>u'` |

## Git status and commands

| Action | Key Map |
|--------|---------|
| Open git status buffer | `'n', '<leader>gs'` |
| Accept diffs in visual diff buffers | `'n', 'gh'`, `'n', 'gl'` |
| Push commits to origin | `'n', '<leader>gp'` |

When in fugitive buffer:

| Action | Key Map |
|--------|---------|
| Open diff for file under cursor | `=` |
| Stage file under cursor | `s` |
| Commit staged files | `cc` |
| Visual diff of file under cursor | `dv` |

Note that you can place your cursor on the section headers (e.g. "Unstaged") to apply one of these hotkeys to all files in the group.

## Debugger

| Action | Key Map |
| ------ | ------- |
| Close hover variables window | `<C-w>q` |

## Trouble

| Action | Key Map |
| ------ | ------- |
| Open trouble | `<leader>xx`|
| Open workspace diagnostics | `<leader>xw` |
| Open document diagnostics | `<leader>xd` |
| Open loclist | `<leader>xl` |
| Open quickfix | `<leader>xq` |
| Open LSP references | `gR` |

## Zen Mode

| Action | Key Map |
| ------ | ------- |
| Toggle zen mode | `<leader>zz` |
