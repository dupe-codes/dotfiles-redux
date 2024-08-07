local project_note = function()
    -- wrap toggle_gitpad to add better error handling
    local repo_root = vim.fn.systemlist("git rev-parse --show-toplevel")[1]
    if not repo_root or repo_root == "" or repo_root:find "fatal" then
        vim.notify "Not inside a Git repository"
        return
    end
    require("gitpad").toggle_gitpad()
end

local open_file_note = nil
local file_note = function()
    -- close window if it is already open
    if open_file_note then
        require("gitpad").toggle_gitpad { filename = open_file_note }
        open_file_note = nil
        return
    end

    local filename = vim.fn.expand "%:p"
    if filename == "" then
        vim.notify "Empty buffer name"
        return
    end

    local repo_root = vim.fn.systemlist("git rev-parse --show-toplevel")[1]
    if not repo_root or repo_root == "" or repo_root:find "fatal" then
        vim.notify "Not inside a Git repository"
        return
    end

    local relative_path = filename:sub(#repo_root + 2) -- +2 to skip the trailing slash
    filename = relative_path:gsub("/", "-") .. ".md"
    open_file_note = filename
    require("gitpad").toggle_gitpad { filename = filename }
end

local keymap = {
    { "<leader>n", group = "notes", icon = "󰠮", nowait = false, remap = false },
    {
        "<leader>np",
        function()
            project_note()
        end,
        desc = "Open project note",
        nowait = false,
        remap = false,
    },
    {
        "<leader>nf",
        function()
            file_note()
        end,
        desc = "Open file note",
        nowait = false,
        remap = false,
    },
}

require("which-key").add(keymap)

require("gitpad").setup {
    dir = os.getenv "HOME" .. "/datastore/coding notes/",
}
