-- snippets for all filetypes

local ls = require "luasnip"

local fmt = require("luasnip.extras.fmt").fmt
local f = ls.function_node
local s = ls.snippet

--local t = ls.text_node
--local c = ls.choice_node
--local d = ls.dynamic_node

local ft_to_interpreter = {
    sh = "bash",
    python = "python",
    lua = "lua",
}

local get_interpreter_from_ft = function()
    local ft = vim.api.nvim_buf_get_option(0, "filetype")
    if ft_to_interpreter[ft] then
        return ft_to_interpreter[ft]
    else
        return "UNKNOWN for " .. ft
    end
end

return {
    s(
        "curdate",
        f(function()
            return os.date "%Y/%m/%d"
        end)
    ),
    s("bang", fmt("#!/usr/bin/env {}", { f(get_interpreter_from_ft) })),

    -- TODO: dynamic snippet for TODO/NOTE/FIXME/etc. comments
    --       based on filetype
    --s("todo",
    --fmt(
    --[[
        --{}{}{}: {}
      --]]
    --{
    --get_comment_prefix(1),
    --i(2),
    ----c(2, { t "TODO", t "NOTE", t "FIXME" }),
    --i(3),
    ----get_comment_annotation(3),
    --i(0),
    --}
    --)
    --)
}
