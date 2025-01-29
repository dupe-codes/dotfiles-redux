-- Implements util function for selecting commit to visual diff current file
-- against. Credit to https://github.com/Civitasv/runvim

local gitsigns = require "gitsigns"

local function get_all_commits_of_this_file()
    local scripts = vim.api.nvim_exec("!git log --pretty=oneline --abbrev-commit --follow %", true)
    local res = vim.split(scripts, "\n")
    local output = {}
    for index = 3, #res - 1 do
        local item = res[index]
        local hash_id = string.sub(item, 1, 7)
        local message = string.sub(item, 8)
        output[index - 2] = { hash_id = hash_id, message = message }
    end
    return output
end

local function get_all_branches()
    local scripts = vim.fn.system "git branch --format='%(refname:short)'"
    vim.notify(scripts)
    local res = vim.split(scripts, "\n")
    local output = {}

    for _, item in ipairs(res) do
        local branch_name = vim.trim(item)
        vim.notify(branch_name)
        if branch_name ~= "" then
            output[#output + 1] = { name = branch_name }
        end
    end
    return output
end

local function is_fugitive_file()
    local filepath = vim.api.nvim_exec("echo expand('%:p')", true)
    return filepath:find("fugitive", 1, true) == 1
end

local function diff_with()
    -- check if it is a fugitive file
    if is_fugitive_file() then
        vim.ui.input({ prompt = "Please input commit hash id to compare with current version: " }, function(input)
            vim.cmd("Gvdiffsplit! " .. input)
        end)
    else
        local commits = get_all_commits_of_this_file()

        vim.ui.select(commits, {
            prompt = "Select commit to compare with current file",
            format_item = function(item)
                return item.hash_id .. " > " .. item.message
            end,
        }, function(choice)
            gitsigns.diffthis(choice.hash_id)
        end)
    end
end

local function diff_with_branch()
    local branches = get_all_branches()
    vim.notify(branches[1].name)

    vim.ui.select(branches, {
        prompt = "Select branch to compare with",
        format_item = function(item)
            return item.name
        end,
    }, function(choice)
        if not choice then
            return
        end

        local branch = choice.name
        local scripts = vim.api.nvim_exec("!git rev-parse " .. branch, true)
        local res = vim.split(scripts, "\n")

        -- Extract the last valid line, ignoring any command output or empty lines
        local commit_hash = res[#res - 1] or ""

        if commit_hash == "" then
            print "Invalid branch or unable to retrieve commit"
            return
        end

        if is_fugitive_file() then
            vim.cmd("Gvdiffsplit! " .. commit_hash)
        else
            gitsigns.diffthis(commit_hash)
        end
    end)
end

return {
    diff_with = diff_with,
    diff_with_branch = diff_with_branch,
}
