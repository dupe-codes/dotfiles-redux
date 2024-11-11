-- luasnip configuration
local ls = require "luasnip"
local types = require "luasnip.util.types"

ls.config.set_config {
    history = true, -- remember last snippet
    updateevents = "TextChanged,TextChangedI", -- update dynamic snips as you type
    enable_autosnippets = true,

    ext_opts = {
        [types.choiceNode] = {
            active = {
                virt_text = { { "<-", "Error" } },
            },
        },
    },
}

-- TODO: trim snippet configs in lsp.lua config
--       all snippet configs live here

-- jump forward in snippet
vim.keymap.set({ "i", "s" }, "<C-k>", function()
    if ls.expand_or_jumpable() then
        return ls.expand_or_jump()
    end
end, { silent = true })

-- jump back in snippet
vim.keymap.set({ "i", "s" }, "<C-j>", function()
    if ls.jumpable(-1) then
        return ls.jump(-1)
    end
end, { silent = true })

-- select within list of options
vim.keymap.set("i", "<C-l>", function()
    if ls.choice_active() then
        return ls.change_choice(1)
    end
end)

-- load all snippets
-- the luasnip loader will utomatically reload snippets when files
-- in this dir are added or changed
local snippets_dir = vim.fn.stdpath "config" .. "/lua/dupe/snippets/ft"
require("luasnip.loaders.from_lua").load { paths = { snippets_dir } }
