local whichkey = require "which-key"

local session_dir = vim.fn.stdpath("data") .. "/sessions/"

local start_session = function()
    local session_name = vim.fn.input("session name: ")
    if session_name ~= "" then
        -- make session directory if not exists
        if vim.fn.isdirectory(session_dir) == 0 then
            vim.fn.mkdir(session_dir, "p")
        end
        vim.cmd("Obsess " .. session_dir .. session_name .. ".session")
    end
end

local load_session = function()
    -- list all sessions in session directory
    local sessions = vim.fn.glob(session_dir .. "/*.session", false, true)

    local session_list = {}
    local name_to_session = {}
    for _, session in ipairs(sessions) do
        local name = session:match("([^/]+)%.session$")
        table.insert(session_list, name)
        name_to_session[name] = session
    end

    vim.ui.select(session_list, {}, function(selected)
        -- source selected session
        if selected then
            vim.cmd("source " .. name_to_session[selected])
        end
    end)
end

local keymap = {
    z = {
        name = "sessions",
        s = {
            function()
                start_session()
            end,
            "start a new sessions",
        },
        e = {
            "<CMD>Obsess!<CR>",
            "end the current session",
        },
        l = {
            function()
                load_session()
            end,
            "load a session",
        },
    }
}

whichkey.register(keymap, {
    mode = "n",
    prefix = "<leader>",
    buffer = nil,
    silent = true,
    noremap = true,
    nowait = false,
})

return {
    load_session = load_session,
    start_session = start_session,
}
