--------------------------------------------------------------------
--      | Index of core plugins |
--------------------------------------------------------------------
-- 1. nvim-tree - file explorer
-- 2. barbar - buffer manager
-- 3. telescope - fuzzy finder
-- 4. treesitter - syntax highlighting
-- 5. treesitter-context - show cursor context pinned to window top
-- 6. copilot.lua - ai autocomplete
-- 7. lualine - statusline
-- 8. nvim-cmp - autocomplete
-- 9. nvim-lspconfig - language servers
-- 10. vim-startify - startup screen
-- 11. indent-blankline - add line guides to indentation levels
-- 12. glance - go to definition/references
-- 13. nerd-commenter - comment lines
-- 14. nvim-lint - linting on save
-- 15. nvim-autopairs - auto close brackets
-- 16. vim-wakatime - track time spent in vim
-- 17. harpoon - bookmark files
-- 18. vim-fugitive - git integration
-- 19. undotree - undo history
-- 20. copilot-cmp - display copilot as completion options
-- 21. toggleterm - better terminal support
-- 22. hlargs - highlight function arguments
-- 23. nvim-dap - debugger adapter
-- 24. dap-ui - UI tools for debugger
-- 25. dap-virtual-text - virtual text support for dap debugging
-- 26. trouble - diagnostics lists
-- 27. which-key - show keymaps
-- 28. mason - package manager, mostly debugging dependencies
-- 29. todo-comments - highlight TODO comments
-- 30. zen-mode - distraction free mode
--------------------------------------------------------------------

-- Load vimrc for initial configs
local vimrc = vim.fn.stdpath("config") .. "/vimrc.vim"
vim.cmd.source(vimrc)

vim.cmd('au ColorScheme * hi clear SignColumn')

require('rose-pine').setup({
    disable_italics = true,
})

-- Set up colorscheme
-- Nothing beats kanagawa, catppuccin, zenburned,
-- or rose-pine :]
--vim.cmd.colorscheme 'kanagawa'
--vim.cmd.colorscheme "catppuccin"
--vim.cmd.colorscheme 'zenburned'
vim.cmd.colorscheme 'rose-pine'

--vim.cmd.colorscheme 'everforest'
--vim.cmd.colorscheme 'gruvbox'
--vim.cmd.colorscheme 'tokyonight-moon'
--vim.cmd.colorscheme 'everblush'
--vim.cmd.colorscheme 'iceberg'
--vim.cmd.colorscheme 'mosel'
--vim.cmd.colorscheme 'nord'
--vim.cmd.colorscheme 'oxocarbon'
--vim.cmd.colorscheme 'carbonfox'

-- Set up treesitter
require('nvim-treesitter.configs').setup {
    ensure_installed = {
        'bash',
        'c',
        'cpp',
        'css',
        'go',
        'html',
        'java',
        'javascript',
        'json',
        'lua',
        'python',
        'rust',
        'toml',
        'tsx',
        'typescript',
        'yaml',
        'scala',
        'terraform',
        'clojure',
        'markdown',
    },
    highlight = {
        enable = true,
    }
}

-- Treesitter context configs
require('treesitter-context').setup {
  enable = true,
  max_lines = 0,
  min_window_height = 0,
  line_numbers = true,
  multiline_threshold = 20, -- Maximum number of lines to collapse for a single context line
  trim_scope = 'outer', -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
  mode = 'cursor',  -- Line used to calculate context. Choices: 'cursor', 'topline'
  -- Separator between context and content. Should be a single character string, like '-'.
  -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
  separator = nil,
  zindex = 20, -- The Z-index of the context window
  on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
}

-- Configure keymappers
vim.g.mapleader = ' '

local key_mapper = function(mode, key, result)
    vim.api.nvim_set_keymap(
        mode,
        key,
        result,
        { noremap = true, silent = true }
    )
end

-- Unmap arrow keys
key_mapper('', '<up>', '<nop>')
key_mapper('', '<down>', '<nop>')
key_mapper('', '<left>', '<nop>')
key_mapper('', '<right>', '<nop>')

-- Move between windows with <leader>hjkl
key_mapper('n', '<leader>h', '<C-w>h')
key_mapper('n', '<leader>j', '<C-w>j')
key_mapper('n', '<leader>k', '<C-w>k')
key_mapper('n', '<leader>l', '<C-w>l')

 --Set up telescope shortcuts for fuzzy finding
key_mapper('n', '<C-p>', ':lua require"telescope.builtin".find_files()<CR>')
key_mapper('n', '<leader>fs', ':lua require"telescope.builtin".live_grep()<CR>')
key_mapper('n', '<leader>fh', ':lua require"telescope.builtin".help_tags()<CR>')
key_mapper('n', '<leader>fb', ':lua require"telescope.builtin".buffers()<CR>')

-- Clear search with <leader><leader>
key_mapper('n', '<leader><leader>', ':noh<CR>')

-- Barbar shortcuts & config
key_mapper('n', '<leader>1', ':BufferGoto 1<CR>')
key_mapper('n', '<leader>2', ':BufferGoto 2<CR>')
key_mapper('n', '<leader>3', ':BufferGoto 3<CR>')
key_mapper('n', '<leader>4', ':BufferGoto 4<CR>')
key_mapper('n', '<leader>5', ':BufferGoto 5<CR>')
key_mapper('n', '<leader>6', ':BufferGoto 6<CR>')
key_mapper('n', '<leader>7', ':BufferGoto 7<CR>')
key_mapper('n', '<leader>8', ':BufferGoto 8<CR>')
key_mapper('n', '<leader>.', ':BufferNext<CR>')
key_mapper('n', '<leader>,', ':BufferPrevious<CR>')
key_mapper('n', '<leader>q', ':BufferClose<CR>')
key_mapper('n', '<leader>aq', ':BufferCloseAllButCurrent<CR>')

require('barbar').setup {
    icons = {
        filetype = {
            enabled = true,
        },
        modified = {button = '~'},
   }
}

-- Set up nvim-tree
-- Key mapping notes:
-- a: add file or directory (use / at end of filename to make dir)
-- d: delete file or directory
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.termguicolors = true
require("nvim-tree").setup()

local function open_nvim_tree()
    -- open the tree
    -- require("nvim-tree.api").tree.open()
    require("nvim-tree.api").tree.toggle({ focus = false })
end
vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })

key_mapper('n', '<leader>ff', ':NvimTreeFindFile<CR>')
key_mapper('n', '<leader>nt', ':NvimTreeToggle<CR>')

-- Setup indent blankline
require("indent_blankline").setup {
    -- for example, context is off by default, use this to turn it on
    show_current_context = true,
    show_current_context_start = true,
}

-- Set up lualine
require('lualine').setup {
    options = {
        icons_enabled = true,
        component_separators = '|',
        section_separators = '',
    },
}

-- Setup linting
require('lint').linters_by_ft = {
    python = { 'pylint', },
}

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  callback = function()
    require("lint").try_lint()

    -- Also match on extra whitespace
    vim.cmd([[match ExtraWhitespace /\s\+$/]])
  end,
})

-- Setup LSP and diagnostics configs

vim.diagnostic.config({
    underline = true,
    virtual_text = false,
    signs = true,
    update_in_insert = true,
    severity_sort = true,
})

local lspconfig = require 'lspconfig'
local on_attach = function(_, bufnr)
    local attach_opts = { silent = true, buffer = bufnr }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, attach_opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, attach_opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, attach_opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, attach_opts)
    vim.keymap.set('n', '<C-s>', vim.lsp.buf.signature_help, attach_opts)
    vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, attach_opts)
    vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, attach_opts)
    vim.keymap.set('n', '<leader>wl', function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end,
        attach_opts)
    vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, attach_opts)
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, attach_opts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, attach_opts)
end

-- Setup diagnostics
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
        underline = true,
        virtual_text = false,
        signs = true,
        update_in_insert = true,
        severity_sort = true,
    }
)

-- Add borders to diagnostic windows
local _border = "single"
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
  vim.lsp.handlers.hover, {
    border = _border
  }
)

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
  vim.lsp.handlers.signature_help, {
    border = _border
  }
)

vim.diagnostic.config {
  float={border=_border}
}

function _G.open_floating_diagnostics()
    local bufnr, winnr = vim.diagnostic.open_float(0, { scope = "line" })
    if winnr then
        vim.api.nvim_set_current_win(winnr)
    end
end

key_mapper('n', '<Leader>e', '<Cmd>lua _G.open_floating_diagnostics()<CR>')

-- nvim-cmp supports additional completion capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Enable the following language servers
local servers = {
    'ccls',
    'pyright',
    'rust_analyzer',
    'tsserver',
    'jdtls',
    'metals'
}
for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup {
        on_attach = on_attach,
        capabilities = capabilities,
    }
end

require('neodev').setup {
    -- pass types to dap UI
    library = { plugins = { "nvim-dap-ui" }, types = true },
}

lspconfig.lua_ls.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
        Lua = {
            completion = {
                callSnippet = 'Replace',
            },
        },
    },
}

-- nvim-cmp setup for snippets

local cmp = require 'cmp'
local luasnip = require 'luasnip'

luasnip.config.setup {}

-- Configure copilot as a completions source
require("copilot").setup({
  suggestion = { enabled = false },
  panel = { enabled = false },
})
require("copilot_cmp").setup()

local lspkind = require("lspkind")
lspkind.init({
  symbol_map = {
    Copilot = "",
  },
})

local window_config = {
    winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder",
}

cmp.setup {
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    --experimental = {
        --ghost_text = true,
    --},
    window = {
        completion = cmp.config.window.bordered(window_config),
        documentation = cmp.config.window.bordered(window_config),
    },
    mapping = cmp.mapping.preset.insert {
        ['<C-e>'] = cmp.mapping.abort(),
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-Space>'] = cmp.mapping.complete {},
        ['<CR>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        },
        ['<C-f>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end, { 'i', 's' }),
        ['<C-b>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { 'i', 's' }),
    },
    sources = {
        { name = "copilot", group_index = 2 },
        { name = 'nvim_lsp', group_index = 2 },
        { name = 'luasnip', group_index = 2 },
    },
    formatting = {
        format = function(entry, vim_item)
          if vim.tbl_contains({ 'path' }, entry.source.name) then
            local icon, hl_group = require('nvim-web-devicons').get_icon(entry:get_completion_item().label)
            if icon then
              vim_item.kind = icon
              vim_item.kind_hl_group = hl_group
              return vim_item
            end
          end
          return require('lspkind').cmp_format()(entry, vim_item)
        end
    },
}

-- Setup glance keymappers
key_mapper('n', '<leader>gd', '<CMD>Glance definitions<CR>')
key_mapper('n', '<leader>gr', '<CMD>Glance references<CR>')
key_mapper('n', '<leader>gy', '<CMD>Glance type_definitions<CR>')
key_mapper('n', '<leader>gm', '<CMD>Glance implementations<CR>')

-- Configure nvim-autopairs
require('nvim-autopairs').setup {}

-- Load custom submodules
require('dupe.remap') -- Add remaps in custom file
require('dupe.vim-settings') -- Add vim settings from custom file

