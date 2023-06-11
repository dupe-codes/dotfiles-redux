set nocompatible            " disable compatibility to old-time vi
set showmatch               " show matching brackets.
set ignorecase              " case insensitive matching
set hlsearch                " highlight search results
set incsearch               " incremental search
set autoindent              " indent a new line the same amount as the line just typed
set number                  " add line numbers
set relativenumber          " add relative line numbers
set wildmode=longest,list   " get bash-like tab completions
set cc=88                   " set colour columns for good coding style
filetype plugin indent on   " allows auto-indenting depending on file type
set tabstop=4               " number of columns occupied by a tab character
set expandtab               " convert tabs to white space
set shiftwidth=4 smarttab   " width for autoindents
set softtabstop=4           " see multiple spaces as tabstops so <BS> does the right thing
set scrolloff=8             " keep 8 lines above and below the cursor

call plug#begin('~/.config/nvim/plugged')

Plug 'preservim/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'ryanoasis/vim-devicons'
Plug 'zbirenbaum/copilot.lua'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-tree/nvim-tree.lua'
Plug 'nvim-tree/nvim-web-devicons'
Plug 'onsails/lspkind-nvim'
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
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/telescope.nvim'
Plug 'jremmen/vim-ripgrep'
Plug 'romgrk/barbar.nvim'
Plug 'gruvbox-community/gruvbox'
Plug 'mfussenegger/nvim-lint'
Plug 'preservim/nerdcommenter'
Plug 'Everblush/nvim'
Plug 'wakatime/vim-wakatime'
Plug 'mhinz/vim-startify'
Plug 'nvim-treesitter/nvim-treesitter-context'
Plug 'dnlhc/glance.nvim'
Plug 'windwp/nvim-autopairs'
Plug 'ThePrimeagen/harpoon'
Plug 'mbbill/undotree'
Plug 'tpope/vim-fugitive'
Plug 'zbirenbaum/copilot-cmp'
Plug 'akinsho/toggleterm.nvim'
Plug 'm-demare/hlargs.nvim'
Plug 'folke/trouble.nvim'
Plug 'folke/todo-comments.nvim'
Plug 'folke/zen-mode.nvim'
Plug 'ThePrimeagen/vim-be-good'

" Debugging plugins with dap
Plug 'mfussenegger/nvim-dap'
Plug 'rcarriga/nvim-dap-ui'
Plug 'theHamsta/nvim-dap-virtual-text'
Plug 'mfussenegger/nvim-dap-python'
Plug 'nvim-telescope/telescope-dap.nvim'
Plug 'folke/which-key.nvim'
Plug 'williamboman/mason.nvim'
Plug 'WhoIsSethDaniel/mason-tool-installer.nvim'

" Colorschemes
Plug 'cocopon/iceberg.vim'
Plug 'neanias/everforest-nvim', { 'branch': 'main' }
Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
Plug 'rebelot/kanagawa.nvim'
Plug 'catppuccin/nvim', { 'as': 'catppuccin' }
Plug 'Domeee/mosel.nvim'
Plug 'shaunsingh/nord.nvim'
Plug 'nyoom-engineering/oxocarbon.nvim'
Plug 'EdenEast/nightfox.nvim'
Plug 'mcchrish/zenbones.nvim'
Plug 'rktjmp/lush.nvim'
Plug 'rose-pine/neovim', { 'as': 'rose-pine' }

" Zig support
Plug 'ziglang/zig.vim'

" Initialize plugin system
" - Automatically executes `filetype plugin indent on` and `syntax enable`.
call plug#end()

syntax on

" Highlight extra whitespace in all buffers but terminal windows
highlight ExtraWhitespace ctermbg=grey guibg=grey
"match ExtraWhitespace /\s\+$/
"au BufWinEnter * if &buftype != 'terminal' | match ExtraWhitespace /\s\+$/ | endif
au InsertEnter * if &buftype != 'terminal' | match ExtraWhitespace /\s\+\%#\@<!$/ | endif
au InsertLeave * if &buftype != 'terminal' | match ExtraWhitespace /\s\+$/ | endif
au BufWinLeave * call clearmatches()


" Configuration for vim-startify
let g:startify_custom_header =
             \ startify#pad(readfile(expand('~/.config/nvim/ascii-art.txt')))

