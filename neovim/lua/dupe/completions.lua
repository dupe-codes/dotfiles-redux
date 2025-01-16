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
        },
        window = {
            completion = cmp.config.window.bordered(window_config),
            documentation = cmp.config.window.bordered(window_config),
        },
        mapping = {
            ["<C-e>"] = cmp.mapping.abort(),
            ["<C-d>"] = cmp.mapping.scroll_docs(5),
            ["<C-u>"] = cmp.mapping.scroll_docs(-5),
            ["<C-n>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
            ["<C-p>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
            ["<CR>"] = cmp.mapping(
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
end

-- NOTE: previous completions setup, for reference. remove this soon
--[[
   [local cmp = require "cmp"
   [local luasnip = require "luasnip"
   [
   [luasnip.config.setup {}
   [
   [local window_config = {
   [    winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:Visual",
   [}
   [
   [cmp.setup {
   [    snippet = {
   [        expand = function(args)
   [            luasnip.lsp_expand(args.body)
   [        end,
   [    },
   [    window = {
   [        completion = cmp.config.window.bordered(window_config),
   [        documentation = cmp.config.window.bordered(window_config),
   [    },
   [    mapping = cmp.mapping.preset.insert {
   [        ["<C-e>"] = cmp.mapping.abort(),
   [        ["<C-d>"] = cmp.mapping.scroll_docs(5),
   [        ["<C-u>"] = cmp.mapping.scroll_docs(-5),
   [        ["<CR>"] = cmp.mapping.confirm {
   [            behavior = cmp.ConfirmBehavior.Insert,
   [            select = false,
   [        },
   [        ["<C-f>"] = cmp.mapping(function(fallback)
   [            if cmp.visible() then
   [                cmp.select_next_item()
   [            elseif luasnip.expand_or_jumpable() then
   [                luasnip.expand_or_jump()
   [            else
   [                fallback()
   [            end
   [        end, { "i", "s" }),
   [        ["<C-b>"] = cmp.mapping(function(fallback)
   [            if cmp.visible() then
   [                cmp.select_prev_item()
   [            elseif luasnip.jumpable(-1) then
   [                luasnip.jump(-1)
   [            else
   [                fallback()
   [            end
   [        end, { "i", "s" }),
   [    },
   [    sources = {
   [        { name = "copilot", group_index = 2 },
   [        { name = "nvim_lsp", group_index = 2 },
   [        { name = "luasnip", group_index = 2 },
   [    },
   [    formatting = {
   [        format = function(entry, vim_item)
   [            if vim.tbl_contains({ "path" }, entry.source.name) then
   [                local icon, hl_group = require("nvim-web-devicons").get_icon(entry:get_completion_item().label)
   [                if icon then
   [                    vim_item.kind = icon
   [                    vim_item.kind_hl_group = hl_group
   [                    return vim_item
   [                end
   [            end
   [            return require("lspkind").cmp_format()(entry, vim_item)
   [        end,
   [    },
   [}
   ]]

return M
