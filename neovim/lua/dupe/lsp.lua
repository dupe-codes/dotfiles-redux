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

-- codelens configuration
local augroup_codelens = vim.api.nvim_create_augroup("custom-lsp-codelens", { clear = true })
vim.api.nvim_set_hl(0, "VirtNonText", { link = "Type" })

local lspconfig = require 'lspconfig'

local lsp_cmds = vim.api.nvim_create_augroup('lsp_cmds', {clear = true})
vim.api.nvim_create_autocmd('LspAttach', {
  group = lsp_cmds,
  desc = 'on_attach',
  callback = function(_)
    local filetype = vim.api.nvim_buf_get_option(0, "filetype")

    if filetype == "ocaml" then
        -- Display type information
        vim.api.nvim_clear_autocmds { group = augroup_codelens, buffer = 0 }
        vim.api.nvim_create_autocmd(
            { "BufEnter", "BufWritePost", "CursorHold" },
            {
                group = augroup_codelens,
                callback = require("dupe.codelens").refresh_virtlines,
                buffer = 0,
            }
        )
        key_mapper('n', '<leader>ot', ':lua require("dupe.codelens").toggle_virtlines()<CR>')

        -- format on save
        vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = 0,
            callback = function()
                vim.lsp.buf.format()
            end,
        })
    end
  end
})

local on_attach = function(_, bufnr)
    -- NOTE: on_attach isn't being fired for... whatever reason
    --       the LspAttach autocmd logic would ideally be here but, alas..
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
capabilities.textDocument.codeLens = { dynamicRegistration = false }
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

local servers = {
    -- NOTE: jdtls isn't working, getting an exit code 1 on attach
    'jdtls',
    'pyright',
    'rust_analyzer',
    'zls',
    'ocamllsp',
}
for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup {
        on_attach = on_attach,
        capabilities = capabilities,
    }
end

require('neodev').setup {
    -- pass types to dap UI
    library = {
        plugins = {
            "nvim-dap-ui",
            "neotest",
        },
        types = true
    },
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

-- NOTE: ccls must be installed separate from Mason
--lspconfig.ccls.setup {
    --on_attach = on_attach,
    --capabilities = capabilities,
    --filetypes = { 'cpp', },
--}

-- TODO: Figure out if this works with compile_commands.json
--       If it does, then we can remove ccls
lspconfig.clangd.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    filetypes = { 'c', 'cpp', },
    cmd = {
        "clangd",
        "--offset-encoding=utf-16",
    },
}

-- Lean theorem prover
require('lean').setup {
    lsp = { on_attach = on_attach },
    mappings = true,
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
    winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:Visual",
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
            select = false,
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

-- Setup keymaps for capabilities not handled by glance
key_mapper('n', '<leader>cd', ':lua vim.lsp.buf.hover()<CR>')
key_mapper('n', '<C-s>', ':lua vim.lsp.buf.signature_help()<CR>')
key_mapper('n', '<leader>ca', ':lua vim.lsp.buf.code_action()<CR>')
