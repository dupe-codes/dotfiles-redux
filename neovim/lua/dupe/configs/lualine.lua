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

require("lualine").setup {
    options = {
        icons_enabled = true,
        globalstatus = true,
        component_separators = "|",
        section_separators = { left = "", right = "" },
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
            { "mode", separator = { left = "" }, right_padding = 2 },
            {
                function()
                    local reg = vim.fn.reg_recording()
                    if reg == "" then
                        return ""
                    end
                    return "=> recording to " .. reg
                end,
            },
        },
        lualine_b = {
            "branch",
            "diff",
            "diagnostics",
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
                indicators = { "1", "2", "3", "4", "5", "6", "7", "8" },
                active_indicators = { "[1]", "[2]", "[3]", "[4]", "[5]", "[6]", "[7]", "[8]" },
            },
        },
        lualine_x = {},
        lualine_y = {
            "filetype",
            -- show name of current session if in one
            {
                function()
                    local session = vim.v.this_session
                    if not session then
                        return ""
                    end
                    -- strip session path to just name of file
                    local session_name = string.match(session, "([^/]+).session$")
                    return "sesh: " .. session_name
                end,

                cond = function()
                    return vim.fn.ObsessionStatus() ~= ""
                end,
            },
            {
                function()
                    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
                        if vim.api.nvim_buf_get_option(buf, "modified") then
                            return " unsaved"
                        end
                    end
                    return ""
                end,
            },
            "progress",
        },
        lualine_z = {
            { "location", separator = { right = "" }, left_padding = 2 },
        },
    },
}

local M = {}

M.apply_default_theme = function()
    require("lualine").setup { options = { theme = bubbles_theme } }
end

return M
