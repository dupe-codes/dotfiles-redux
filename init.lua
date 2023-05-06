-- Load vimrc for initial configs
local vimrc = vim.fn.stdpath("config") .. "/vimrc.vim"
vim.cmd.source(vimrc)

-- Set up colorscheme

-- vim.cmd.colorscheme "catppuccin-frappe"
-- vim.cmd.colorscheme 'everforest'
vim.cmd.colorscheme 'kanagawa'
-- vim.cmd.colorscheme 'gruvbox'
-- vim.cmd.colorscheme 'tokyonight-moon'

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
    },
    highlight = {
        enable = true,
    }
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

-- Exit modes with jk
key_mapper('i', 'jk', '<ESC>')
key_mapper('i', 'JK', '<ESC>')
key_mapper('i', 'jK', '<ESC>')
key_mapper('v', 'jk', '<ESC>')
key_mapper('v', 'JK', '<ESC>')
key_mapper('v', 'jK', '<ESC>')

-- Move between windows with <leader>hjkl
key_mapper('n', '<leader>h', '<C-w>h')
key_mapper('n', '<leader>j', '<C-w>j')
key_mapper('n', '<leader>k', '<C-w>k')
key_mapper('n', '<leader>l', '<C-w>l')

-- Set up telescope shortcuts for fuzzy finding
key_mapper('n', '<C-p>', ':lua require"telescope.builtin".find_files()<CR>')
key_mapper('n', '<leader>fs', ':lua require"telescope.builtin".live_grep()<CR>')
key_mapper('n', '<leader>fh', ':lua require"telescope.builtin".help_tags()<CR>')
key_mapper('n', '<leader>fb', ':lua require"telescope.builtin".buffers()<CR>')

-- Clear search with <leader>c
key_mapper('n', '<leader>c', ':noh<CR>')

-- Barbar shortcuts & config
key_mapper('n', '<leader>1', ':BufferGoto 1<CR>')
key_mapper('n', '<leader>2', ':BufferGoto 2<CR>')
key_mapper('n', '<leader>3', ':BufferGoto 3<CR>')
key_mapper('n', '<leader>4', ':BufferGoto 4<CR>')
key_mapper('n', '<leader>.', ':BufferNext<CR>')
key_mapper('n', '<leader>,', ':BufferPrevious<CR>')
key_mapper('n', '<leader>q', ':BufferClose<CR>')

require('barbar').setup {
    icons = {
        filetype = {
            enabled = false,
        }
    }
}

-- Set up nvim-tree
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

-- Setup indent blankline

require("indent_blankline").setup {
    -- for example, context is off by default, use this to turn it on
    show_current_context = true,
    show_current_context_start = true,
}

-- Set up lualine
require('lualine').setup {
    options = {
        icons_enabled = false,
        component_separators = '|',
        section_separators = '',
    },
}

-- Setup language service configs

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
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, attach_opts)
end


vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
        underline = true,
        virtual_text = false,
        signs = true,
        update_in_insert = true,
    }
)

function _G.open_floating_diagnostics()
    local bufnr, winnr = vim.diagnostic.open_float(0, { scope = "line" })
    if winnr then
        vim.api.nvim_set_current_win(winnr)
    end
end

key_mapper('n', '<Leader>e', '<Cmd>lua _G.open_floating_diagnostics()<CR>')

--[[
key_mapper('n', 'gd', ':lua vim.lsp.buf.definition()<CR>')
key_mapper('n', 'gD', ':lua vim.lsp.buf.declaration()<CR>')
key_mapper('n', 'gi', ':lua vim.lsp.buf.implementation()<CR>')
key_mapper('n', 'gw', ':lua vim.lsp.buf.document_symbol()<CR>')
key_mapper('n', 'gW', ':lua vim.lsp.buf.workspace_symbol()<CR>')
key_mapper('n', 'gr', ':lua vim.lsp.buf.references()<CR>')
key_mapper('n', 'gt', ':lua vim.lsp.buf.type_definition()<CR>')
key_mapper('n', 'K', ':lua vim.lsp.buf.hover()<CR>')
key_mapper('n', '<c-k>', ':lua vim.lsp.buf.signature_help()<CR>')
key_mapper('n', '<leader>af', ':lua vim.lsp.buf.code_action()<CR>')
key_mapper('n', '<leader>rn', ':lua vim.lsp.buf.rename()<CR>')
]]
-- nvim-cmp supports additional completion capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Enable the following language servers
local servers = {
    'clangd',
    'ccls',
    'rust_analyzer',
    'pyright',
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

require('neodev').setup {}

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

cmp.setup {
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert {
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
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
    },
}

