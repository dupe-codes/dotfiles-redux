local whichkey = require "which-key"

local session_dir = vim.fn.stdpath "data" .. "/sessions/"

local get_default_session_name = function()
    local repo_name = vim.fn.system("git rev-parse --show-toplevel"):gsub("\n", "")
    local not_in_git_repo = repo_name:find "fatal: not a git repository"
    return not_in_git_repo and "" or vim.fn.fnamemodify(repo_name, ":t")
end

local start_session = function()
    -- get name of the current git repo; if we're in one, use its name
    -- as the default session name
    local default_name = get_default_session_name()

    vim.ui.input({ prompt = "session name: ", default = default_name }, function(session_name)
        if session_name ~= nil and session_name ~= "" then
            -- make sure session directory exists
            if vim.fn.isdirectory(session_dir) == 0 then
                vim.fn.mkdir(session_dir, "p")
            end

            -- avoid overwriting existing session
            local session_file = session_dir .. session_name .. ".session"
            if vim.fn.filereadable(session_file) == 1 then
                vim.notify("session " .. session_name .. " already exists")
                return
            end

            vim.cmd("Obsess " .. session_file)
            vim.notify("session " .. session_name .. " started")
        end
    end)
end

local get_saved_sessions = function()
    -- list all sessions in session directory
    local sessions = vim.fn.glob(session_dir .. "/*.session", false, true)

    local session_list = {}
    local name_to_session = {}
    for _, session in ipairs(sessions) do
        local name = session:match "([^/]+)%.session$"
        table.insert(session_list, name)
        name_to_session[name] = session
    end

    return {
        session_list,
        name_to_session,
    }
end

local load_session = function()
    local session_list, name_to_session = unpack(get_saved_sessions())
    vim.ui.select(session_list, { prompt = "Select session" }, function(selected)
        -- source selected session
        if selected then
            vim.cmd("source " .. name_to_session[selected])
            vim.notify(selected .. " session loaded")
        end
    end)
end

local load_session_matching_default_name = function()
    local default_name = get_default_session_name()
    local _, name_to_session = unpack(get_saved_sessions())

    if name_to_session[default_name] then
        vim.ui.input({ prompt = "Session " .. default_name .. " exists. Load it? (y/n)" }, function(input)
            if input == "y" then
                vim.cmd("source " .. name_to_session[default_name])
                vim.notify(default_name .. " session loaded")
            end
        end)
    end
end

local end_session = function()
    local session = vim.v.this_session
    if not session or session == "" then
        vim.notify "no session to end"
        return
    end

    vim.cmd "Obsess!"
    vim.v.this_session = ""

    local session_name = string.match(session, "([^/]+).session$")
    vim.notify("session " .. session_name .. " ended")
end

local delete_session = function()
    local sessions_list, name_to_session = unpack(get_saved_sessions())

    -- Remove current session if applicable
    local current_session = vim.v.this_session
    if current_session and current_session ~= "" then
        local current_session_name = current_session:match "([^/]+)%.session$"
        if current_session_name then
            for i, session_name in ipairs(sessions_list) do
                if session_name == current_session_name then
                    table.remove(sessions_list, i)
                    name_to_session[session_name] = nil
                    break
                end
            end
        end
    end

    -- Use vim.ui.select to choose a session to delete
    vim.ui.select(sessions_list, { prompt = "Select session to delete" }, function(selected)
        if selected then
            local session_file = name_to_session[selected]
            if session_file and vim.fn.filereadable(session_file) == 1 then
                vim.fn.delete(session_file)
                vim.notify("Deleted session: " .. selected)
            else
                vim.notify("Session file not found: " .. selected, vim.log.levels.ERROR)
            end
        end
    end)
end

local keymap = {
    { "<leader>z", group = "sessions", nowait = false, remap = false },
    {
        "<leader>ze",
        function()
            end_session()
        end,
        desc = "end the current session",
        nowait = false,
        remap = false,
    },
    {
        "<leader>zl",
        function()
            load_session()
        end,
        desc = "load a session",
        nowait = false,
        remap = false,
    },
    {
        "<leader>zs",
        function()
            start_session()
        end,
        desc = "start a new session",
        nowait = false,
        remap = false,
    },
    {
        "<leader>zd",
        function()
            delete_session()
        end,
        desc = "delete a session",
        nowait = false,
        remap = false,
    },
}

whichkey.add(keymap)

return {
    load_session = load_session,
    start_session = start_session,
    load_session_matching_default_name = load_session_matching_default_name,
}
