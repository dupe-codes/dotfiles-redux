-- NOTE: Experimenting with new pattern:
--       1. have a custom configuration file dedicated to a particular functional category
--       2. have the file export a "plugins" list to define dependencies
--       3. have the file export a setup function to configure the functionality

local M = {}

M.plugins = {
    {
        "hrsh7th/nvim-cmp",
        lazy = false,
        priority = 100,
        dependencies = {
            "onsails/lspkind.nvim",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-buffer",
            { "L3MON4D3/LuaSnip", build = "make install_jsregexp" },
            "saadparwaiz1/cmp_luasnip",
        },
    },
    {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        event = "InsertEnter",
        config = function()
            local copilot = require "copilot"
            copilot.setup {
                suggestion = {
                    auto_trigger = false,
                },
            }
        end,
    },
}

M.setup = function()
    local lspkind = require "lspkind"
    lspkind.init {}

    local window_config = {
        winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:Visual",
    }

    local cmp = require "cmp"
    cmp.setup {
        sources = {
            { name = "nvim_lsp" },
            { name = "path" },
            { name = "buffer" },
            { name = "luasnip" },
        },
        window = {
            completion = cmp.config.window.bordered(window_config),
            documentation = cmp.config.window.bordered(window_config),
        },
        mapping = {
            ["<C-e>"] = cmp.mapping.abort(),
            ["<C-d>"] = cmp.mapping.scroll_docs(5),
            ["<C-u>"] = cmp.mapping.scroll_docs(-5),
            ["<C-f>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Select },
            ["<C-b>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Select },
            ["<C-y>"] = cmp.mapping(
                cmp.mapping.confirm {
                    behavior = cmp.ConfirmBehavior.Insert,
                    select = true,
                },
                { "i", "c" }
            ),
        },
        snippet = {
            expand = function(args)
                require("luasnip").lsp_expand(args.body)
            end,
        },
        formatting = {
            format = function(entry, vim_item)
                if vim.tbl_contains({ "path" }, entry.source.name) then
                    local icon, hl_group = require("nvim-web-devicons").get_icon(entry:get_completion_item().label)
                    if icon then
                        vim_item.kind = icon
                        vim_item.kind_hl_group = hl_group
                        return vim_item
                    end
                end
                return require("lspkind").cmp_format()(entry, vim_item)
            end,
        },
    }

    -- autopairs on functions
    local cmp_autopairs = require "nvim-autopairs.completion.cmp"
    cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
end

return M
