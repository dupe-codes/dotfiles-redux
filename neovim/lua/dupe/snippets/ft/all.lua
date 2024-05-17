-- snipperts for all filetypes

local ls = require "luasnip"

local f = ls.function_node
local s = ls.snippet

--local t = ls.text_node
--local c = ls.choice_node
--local i = ls.insert_node
--local d = ls.dynamic_node
--local fmt = require("luasnip.extras.fmt").fmt

return {
  s(
    "curtime",
    f(function()
      return os.date "%D - %H:%M"
    end)
  )

  -- TODO: dynamic snippet for TODO/NOTE/FIXME/etc. comments
  --       based on filetype
  --s("todo",
    --fmt(
      --[[
        --{}{}{}: {}
      --]],
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
