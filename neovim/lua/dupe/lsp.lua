local key_mapper = require("dupe.util").key_mapper

local M = {}

M.plugins = {
    { "neovim/nvim-lspconfig" },
    { "folke/neodev.nvim" },
}

M.setup = function()
    -- codelens and inlay-hints configurations
    -- TODO: figure out how to get neovim builtin capabilities working for this
    local augroup_codelens = vim.api.nvim_create_augroup("custom-lsp-codelens", { clear = true })
    vim.api.nvim_set_hl(0, "VirtNonText", { link = "Type" })

    local lspconfig = require "lspconfig"

    local lsp_cmds = vim.api.nvim_create_augroup("lsp_cmds", { clear = true })
    vim.api.nvim_create_autocmd("LspAttach", {
        group = lsp_cmds,
        desc = "on_attach",
        callback = function(_)
            local filetype = vim.api.nvim_buf_get_option(0, "filetype")
            if filetype == "ocaml" then
                -- display type information
                vim.api.nvim_clear_autocmds { group = augroup_codelens, buffer = 0 }
                vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "CursorHold" }, {
                    group = augroup_codelens,
                    callback = require("dupe.codelens").refresh_virtlines,
                    buffer = 0,
                })
                key_mapper("n", "<leader>ot", ':lua require("dupe.codelens").toggle_virtlines()<CR>')
            end
        end,
    })

    local on_attach = function(_, bufnr)
        -- NOTE: on_attach isn't being fired for... whatever reason
        --       the LspAttach autocmd logic would ideally be here but, alas..
    end

    -- nvim-cmp supports additional completion capabilities
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.codeLens = { dynamicRegistration = false }
    capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

    local servers = {
        "pyright",
        "rust_analyzer",
        "zls",
        "racket_langserver",
        "gleam",
        "vtsls",
        "eslint",
    }
    for _, lsp in ipairs(servers) do
        lspconfig[lsp].setup {
            on_attach = on_attach,
            capabilities = capabilities,
        }
    end

    require("neodev").setup {
        -- pass types to dap UI
        library = {
            plugins = {
                "nvim-dap-ui",
                "neotest",
            },
            types = true,
        },
    }

    lspconfig.ocamllsp.setup {
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
            codelens = { enable = true },
        },
    }

    lspconfig.lua_ls.setup {
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
            Lua = {
                completion = {
                    callSnippet = "Replace",
                },
            },
        },
    }

    lspconfig.clangd.setup {
        on_attach = on_attach,
        capabilities = capabilities,
        filetypes = { "c", "cpp" },
        cmd = {
            "clangd",
            "--offset-encoding=utf-16",
        },
    }

    -- Lean theorem prover
    require("lean").setup {
        lsp = { on_attach = on_attach },
        mappings = true,
    }

    -- godot game engine

    -- recognize .gd files
    vim.cmd "autocmd BufNewFile,BufRead *.gd set filetype=gdscript"

    lspconfig.gdscript.setup {
        on_attach = on_attach,
        filetypes = { "gd", "gdscript", "gdscript3" },
    }

    vim.api.nvim_create_autocmd("FileType", {
        pattern = "sh",
        callback = function()
            vim.lsp.start {
                name = "bash-language-server",
                cmd = { "bash-language-server", "start" },
            }
        end,
    })

    -- NOTE: omnisharp works with godot as long as you've compiled
    --       your godot project _at least once_
    lspconfig.omnisharp.setup {
        on_attach = on_attach,
        capabilities = capabilities,
        cmd = {
            "omnisharp",
            "--languageserver",
            "--hostPID",
            tostring(vim.fn.getpid()),
        },
        settings = {
            RoslynExtensionsOptions = {
                enableDecompilationSupport = false,
                enableImportCompletion = true,
                enableAnalyzersSupport = true,
            },
        },
        root_dir = lspconfig.util.root_pattern "*.sln",
    }

    -- setup keymaps for capabilities not handled by glance
    key_mapper("n", "<leader>cd", ":lua vim.lsp.buf.hover()<CR>")
    key_mapper("n", "<C-s>", ":lua vim.lsp.buf.signature_help()<CR>")
    key_mapper("n", "<leader>ca", ":lua vim.lsp.buf.code_action()<CR>")
end

return M
