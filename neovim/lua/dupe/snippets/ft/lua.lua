local ls = require "luasnip"

local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep

local s = ls.s
local i = ls.insert_node

return {
  ls.parser.parse_snippet("lf", "local $1 = function($2)\n  $0\nend"),
  s("req", fmt("local {} = require('{}')", { i(1, "default"), rep(1) })),
}
