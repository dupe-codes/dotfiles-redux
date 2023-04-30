set nocompatible            " disable compatibility to old-time vi
set showmatch               " show matching brackets.
set ignorecase              " case insensitive matching
set hlsearch                " highlight search results
set autoindent              " indent a new line the same amount as the line just typed
set number                  " add line numbers
set wildmode=longest,list   " get bash-like tab completions
set cc=88                   " set colour columns for good coding style
filetype plugin indent on   " allows auto-indenting depending on file type
set tabstop=4               " number of columns occupied by a tab character
set expandtab               " convert tabs to white space
set shiftwidth=4 smarttab   " width for autoindents
set softtabstop=4           " see multiple spaces as tabstops so <BS> does the right thing

set verbosefile=~/.log/nvim/verbose.log
set verbose=15

call plug#begin('~/.config/nvim/plugged')

Plug 'preservim/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'neanias/everforest-nvim', { 'branch': 'main' }
Plug 'ryanoasis/vim-devicons'
Plug 'github/copilot.vim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-tree/nvim-tree.lua'
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'
Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'nvim-lualine/lualine.nvim'
Plug 'folke/neodev.nvim'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
"Plug 'sheerun/vim-polyglot'
Plug 'quarto-dev/quarto-nvim'
Plug 'jmbuhr/otter.nvim'
Plug 'catppuccin/nvim', { 'as': 'catppuccin' }
Plug 'rebelot/kanagawa.nvim'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/telescope.nvim'
Plug 'jremmen/vim-ripgrep' 
Plug 'romgrk/barbar.nvim'

" Initialize plugin system
" - Automatically executes `filetype plugin indent on` and `syntax enable`.
call plug#end()

syntax on

