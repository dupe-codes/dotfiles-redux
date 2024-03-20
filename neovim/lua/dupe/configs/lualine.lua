-- stylua: ignore
local colors = {
  blue   = '#8aadf4',
  cyan   = '#91d7e3',
  white  = '#cad3f5',
  red    = '#ed8796',
  violet = '#c6a0f6',
  grey   = '#363a4f',
  black  = '#181926',
}

local bubbles_theme = {
  normal = {
    a = { fg = colors.black, bg = colors.violet },
    b = { fg = colors.white, bg = colors.grey },
    c = { fg = colors.white, bg = "NONE" },
  },

  insert = { a = { fg = colors.black, bg = colors.blue } },
  visual = { a = { fg = colors.black, bg = colors.cyan } },
  replace = { a = { fg = colors.black, bg = colors.red } },

  inactive = {
    a = { fg = colors.white, bg = colors.black },
    b = { fg = colors.white, bg = colors.black },
    c = { fg = colors.black, bg = colors.black },
  },
}

require('lualine').setup {
    options = {
        icons_enabled = true,
        component_separators = '|',
        section_separators = { left = '', right = '' },
        theme = bubbles_theme,
        disabled_filetypes = {
          "help",
          "alpha",
          "lazy",
          "NvimTree",
          "fugitive",
          "undotree",
          "Outline",
          "neotest-summary",
        },
    },
    sections = {
        lualine_a = {
          { "mode", separator = { left = ""}, right_padding = 2 },
        },
        lualine_b = {
          "branch",
          "diff",
          { "swenv", icon = "" },
        },
        lualine_c = {
          "%=",
          {
            "filename",
            icon = "",
            color = { fg = colors.white, bg = colors.grey },
            separator = { left = "", right = "" },
            path = 4,
          },
          {
            "harpoon2",
          },
        },
        lualine_x = {},
        lualine_y = {
          "filetype",
          {
              function()
                  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
                      if vim.api.nvim_buf_get_option(buf, 'modified') then
                          return ' unsaved'
                      end
                  end
                  return ''
              end,
          },
          "progress",
        },
        lualine_z = {
          { "location", separator = { right = "" }, left_padding = 2 },
        },
    },
}

