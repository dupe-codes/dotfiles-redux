-- gx_extended_fn
--
-- if word under cursor is a repo name in quotes (e.g. "dupe-codes/dotfiles-redux"),
-- opens it in github; otherwise, fallback to given fallback function behavior
local gx_extended_fn = function(fallback)
    return function()
        local word = vim.fn.expand("<cWORD>"):match "[\"']([%a_%.%-]+/[%a_%.%-]+)[\"']"
        if word then
            local url = "https://github.com/" .. word
            vim.ui.open(url)
            vim.notify("Opened " .. url .. " in browser")
        elseif fallback then
            fallback()
        end
    end
end

-- TODO: implement to open current file:line in github
--[[
   [local open_current_file_in_github = function()
   [    local repo = vim.fn.expand "%:h"
   [    local file = vim.fn.expand "%:t"
   [    local line = vim.fn.line "."
   [end
   ]]

return {
    gx_extended_fn = gx_extended_fn,
}
