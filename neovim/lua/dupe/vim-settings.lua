vim.cmd "highlight LineNr ctermbg=NONE guibg=NONE"

-- Set diagnostics signs
vim.cmd "sign define DiagnosticSignError text= texthl=DiagnosticSignError linehl= numhl="
vim.cmd "sign define DiagnosticSignWarn text= texthl=DiagnosticSignWarn linehl= numhl="
vim.cmd "sign define DiagnosticSignInfo text= texthl=DiagnosticSignInfo linehl= numhl="
vim.cmd "sign define DiagnosticSignHint text= texthl=DiagnosticSignHint linehl= numhl="
vim.cmd "set signcolumn=yes"

local hl = vim.api.nvim_set_hl
hl(0, "DiagnosticError", { fg = "#db4b4b", bg = clear })
hl(0, "DiagnosticSignError", { fg = "#db4b4b", bg = clear })
hl(0, "DiagnosticSignHint", { fg = "#10B981", bg = clear })
hl(0, "DiagnosticSignInfo", { fg = "#0db9d7", bg = clear })
hl(0, "DiagnosticSignWarn", { fg = "#e0af68", bg = clear })

-- Set hidden to preserve buffers
vim.cmd "set hidden"

-- Highlight extra whitespace in all buffers but terminal windows
vim.cmd "au InsertEnter * if &buftype != 'terminal' | match ExtraWhitespace /\\s\\+\\%#\\@<!$/ | endif"
vim.cmd "au InsertLeave * if &buftype != 'terminal' | match ExtraWhitespace /\\s\\+$/ | endif"
--vim.cmd("au BufWinLeave * call clearmatches()")

-- Highlight text beyond 100 chars
local function apply_highlight()
    vim.schedule(function()
        if vim.bo.filetype ~= "dashboard" then
            vim.cmd "2match OverLength /\\%101v.\\+/"
        else
            vim.cmd "2match none"
        end
    end)
end
vim.api.nvim_create_augroup("OverLengthGroup", { clear = true })
vim.api.nvim_create_autocmd({
    "InsertEnter",
    "InsertLeave",
    "BufEnter",
    "BufWritePre",
    "BufReadPost",
    "BufNewFile",
}, {
    group = "OverLengthGroup",
    callback = apply_highlight,
})

-- Save last cursor position on exit
local lastplace = vim.api.nvim_create_augroup("LastPlace", {})
vim.api.nvim_clear_autocmds { group = lastplace }
vim.api.nvim_create_autocmd("BufReadPost", {
    group = lastplace,
    pattern = { "*" },
    desc = "Remember last cursor position",
    callback = function()
        local mark = vim.api.nvim_buf_get_mark(0, '"')
        local lcount = vim.api.nvim_buf_line_count(0)
        if mark[1] > 0 and mark[1] <= lcount then
            pcall(vim.api.nvim_win_set_cursor, 0, mark)
        end
    end,
})

vim.cmd "set nocompatible" -- disable compatibility to old-time vi
vim.cmd "set showmatch" -- show matching brackets.
vim.cmd "set ignorecase" -- case insensitive matching
vim.cmd "set hlsearch" -- highlight search results
vim.cmd "set incsearch" -- incremental search
vim.cmd "set autoindent" -- indent a new line the same amount as the line just typed
vim.cmd "set number" -- add line numbers
vim.cmd "set relativenumber" -- add relative line numbers
vim.cmd "set wildmode=longest,list" -- get bash-like tab completions
vim.cmd "filetype plugin indent on" -- allows auto-indenting depending on file type
vim.cmd "set tabstop=2" -- # cols for tab. TODO: set this based on filetype
vim.cmd "set expandtab" -- convert tabs to white space
vim.cmd "set shiftwidth=2 smarttab" -- width for autoindents
vim.cmd "set softtabstop=2" -- see multiple spaces as tabstops so <BS> does the right thing
vim.cmd "set scrolloff=8" -- keep 8 lines above and below the cursor
vim.cmd "set cmdheight=0" -- hide command line
vim.cmd "set showtabline=0"
vim.cmd "syntax on"
vim.cmd "set cursorline"

-- configure cursor as blinking block and vertical line
-- TODO: the blinking sometimes lags; debug it
vim.cmd(
    "set guicursor="
        .. "n-v-c:block,"
        .. "i-ci-ve:ver25,"
        .. "r-cr:hor20,"
        .. "o:hor50,"
        .. "a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,"
        .. "sm:block-blinkwait175-blinkoff150-blinkon175"
)

-- Setup path to include mason installed packages
vim.env.PATH = vim.fn.stdpath "data" .. "/mason/bin" .. ":" .. vim.env.PATH
