local ls = require "luasnip"

local s = ls.snippet
local f = ls.function_node

-- TODO: snippets for all filetypes
return {
  s(
    "curtime",
    f(function()
      return os.date "%D - %H:%M"
    end)
  ),
}
