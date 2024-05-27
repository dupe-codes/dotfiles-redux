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

-- open_current_file_in_github
--
-- opens current file + line number in github on the current branch
local open_current_file_in_github = function()
    local line_number = vim.fn.line "."
    local file_path = vim.fn.expand "%:p"
    local remote_repo = vim.fn.system("git remote get-url origin"):gsub("\n", "")

    -- check if repo contains fatal: not a git repository
    if remote_repo:find "fatal: not a git repository" then
        vim.notify "Not in a git repository"
        return
    end

    local branch = vim.fn.system("git branch --show-current"):gsub("\n", "")

    local account, repo = remote_repo:match "^git@github.com:([^/]+)/([^%.]+).git$"
    local escaped_repo = repo:gsub("%-", "%%-")
    local relative_path = file_path:match(".*/" .. escaped_repo .. "/(.+)")

    local url = "https://github.com/"
        .. account
        .. "/"
        .. repo
        .. "/blob/"
        .. branch
        .. "/"
        .. relative_path
        .. "#L"
        .. line_number

    vim.notify("Opening " .. url .. " in browser")
    vim.ui.open(url)
end

return {
    gx_extended_fn = gx_extended_fn,
    open_current_file_in_github = open_current_file_in_github,
}
