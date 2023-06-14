-- Setup LSPs, diagnositcs, and completions
-- Done here because it involves so many plugins

local key_mapper = require('dupe.util').key_mapper

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
    'metals',
    'zls',
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


