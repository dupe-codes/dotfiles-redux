local ls = require "luasnip"

local s, i, t = ls.s, ls.insert_node, ls.text_node
local c = ls.choice_node
local fmt = require("luasnip.extras.fmt").fmt

return {
  -- add a test module
  s("modtest",
    fmt(
      [[
        #[cfg(test)]
        mod test {{
        {}

            {}
        }}
      ]],
      {
        c(1, { t "    use super::*;", t "" }),
        i(0),
      }
    )
  ),
}
