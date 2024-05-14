local ls = require "luasnip"

local s = ls.s
local i = ls.insert_node
local f = ls.function_node

local fmt = require("luasnip.extras.fmt").fmt

return {
  ls.parser.parse_snippet("lf", "local $1 = function($2)\n  $0\nend"),
  s("req",
    fmt([[local {} = require "{}"]], {
        f(function(import_name)
          local parts = vim.split(import_name[1][1], ".", { plain = true })
          return parts[#parts] or ""
        end, { 1 }),
        i(1),
    })
  ),
}
