local ls = require "luasnip"

local s = ls.s
local i = ls.insert_node
local f = ls.function_node

local fmt = require("luasnip.extras.fmt").fmt

return {
  s("matchfn",
    fmt([[
      let {} = function {} -> {}
    ]],
    { i(1, "fn_name"), i(2, "pattern"), i(0, "logic") })
  ),
  -- TODO: case snippet that fills in all branches of a match statement
  --       use treesitter to get the type of the match input, and all its
  --       branches
  --       e.g.,
  --       type t = A | B | C
  --
  --       let x = A in
  --       match x with
  --       ... <- cases here should fill in A -> {}, B -> {}, C -> {}
  --s("cases",
    --fmt([[
    --]],
    --{})
  --)
}

