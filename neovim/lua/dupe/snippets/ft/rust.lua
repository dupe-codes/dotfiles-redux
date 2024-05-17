local ls = require "luasnip"

local s, i, t = ls.s, ls.insert_node, ls.text_node
local c = ls.choice_node
local d = ls.dynamic_node
local sn = ls.sn
local fmt = require("luasnip.extras.fmt").fmt

local get_test_result = function(position)
  return d(position, function()
    local nodes = {}
    table.insert(nodes, t " ")

    local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
    for _, line in ipairs(lines) do
      if line:match("anyhow::Result") then
        table.insert(nodes, t " -> Result<()> ")
        break
      end
    end

    return sn(nil, c (1, nodes))
  end, {})
end

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
  -- add a test function
  s(
    "test",
    fmt(
      [[
        #[test]
        fn {}(){}{{
            {}
        }}
      ]],
      {
        i(1, "testname"),
        get_test_result(2),
        i(0),
      }
    )
  ),
}
