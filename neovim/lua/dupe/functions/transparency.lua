local highlight_groups_to_clear = {
    "Normal",
    "NormalNC",
    "Comment",
    "Constant",
    "Special",
    "Identifier",
    "Statement",
    "PreProc",
    "Type",
    "Underlined",
    "Todo",
    "String",
    "Function",
    "Conditional",
    "Repeat",
    "Operator",
    "Structure",
    "LineNr",
    "NonText",
    "SignColumn",
    "StatusLine",
    "StatusLineNC",
    "EndOfBuffer",
}

local function clear_group(group)
    local ok, prev_attrs = pcall(vim.api.nvim_get_hl_by_name, group, true)
    if ok and (prev_attrs.background or prev_attrs.bg or prev_attrs.ctermbg) then
        local attrs = vim.tbl_extend("force", prev_attrs, { bg = "NONE", ctermbg = "NONE" })
        attrs[true] = nil
        vim.api.nvim_set_hl(0, group, attrs)
    end
end

local M = {}

M.enable_transparency = function()
    for _, group in ipairs(highlight_groups_to_clear) do
        clear_group(group)
    end
end

return M
