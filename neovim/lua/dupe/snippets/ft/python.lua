-- clear snippets for quick iteration
require("luasnip.session.snippet_collection").clear_snippets "python"

local ls = require "luasnip"

local fmta = require("luasnip.extras.fmt").fmta
local rep = require("luasnip.extras").rep

local s = ls.snippet
local c = ls.choice_node
local d = ls.dynamic_node
local i = ls.insert_node
local t = ls.text_node
local sn = ls.snippet_node

local function get_parameters()
  local ts_utils = require("nvim-treesitter.ts_utils")
  local current_node = ts_utils.get_node_at_cursor()

  while current_node do
    if current_node:type() == "function_definition" then
      break
    end
    current_node = current_node:parent()
  end

  if current_node then
    local params = {}
    print("current node:", current_node:type())

    for child in current_node:iter_children() do
      if child:type() == "parameters" then
        print("parameters")

        for param in child:iter_children() do
          if param:type() == "typed_parameter" or param:type() == "default_parameter" then
            local name, type

            for param_child in param:iter_children() do
              if param_child:type() == "identifier" then
                name = vim.treesitter.get_node_text(param_child, 0)
              elseif param_child:type() == "type" then
                type = vim.treesitter.get_node_text(param_child, 0)
              end
            end

            if name then
              type = type or "any"
              table.insert(params, { name = name, type = type })
            end
          end
        end
      end
    end

    return params
  end

  return nil
end

-- Dynamic node for the parameters section
local parameters_node = d(2, function()
  local params = get_parameters()
  if params and #params > 0 then
    local param_nodes = {}
    for _, param in ipairs(params) do
      table.insert(param_nodes, t({"", param.name .. " : " .. param.type}))
      table.insert(param_nodes, t({"", "    Description of " .. param.name .. "."}))
    end
    return sn(nil, {
      t("Parameters"),
      t({"", "----------"}),
      sn(nil, param_nodes),
    })
  else
    return sn(nil, {})
  end
end, {})

-- snippet for numpy style function docstring
-- TODO:
--    1. add support for return type
--    2. add support for exceptions
--    3. add support for examples
--    4. remove awkward newlines at end of parameter-less functions
--    5. automatically add indentation if needed
ls.add_snippets("python", {
    s(
      "fdstr", -- function docstring
      fmta(
        [[
        """<summary>

        <description>

        <parameters>
        """
        ]],
        {
          summary = i(1, "Function summary"),
          description = i(2, "Function description"),
          parameters = parameters_node,
        }
      )
    )
})
