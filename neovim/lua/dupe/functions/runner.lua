local utils = require "dupe.functions.utils"

local LOGS_DIR = vim.fn.stdpath "data" .. "/run_logs"

local M = {}

local function file_has_shebang(filename)
    local first_line = vim.fn.readfile(filename, "", 1)[1] or ""
    return vim.startswith(first_line, "#!")
end

M.run_current_file = function()
    local buf = vim.api.nvim_get_current_buf()
    local filename = vim.api.nvim_buf_get_name(buf)

    if filename == "" then
        vim.notify("No file name found. Please save your file first.", vim.log.levels.WARN)
        return
    end

    if not file_has_shebang(filename) then
        vim.notify("File does not have shebang (#!). Aborting.", vim.log.levels.ERROR)
        return
    end

    vim.fn.mkdir(LOGS_DIR, "p")

    local timestamp = os.date "%Y%m%d_%H%M%S"
    local shortname = vim.fn.fnamemodify(filename, ":t")
    local log_file = string.format("%s/%s_%s_run.log", LOGS_DIR, timestamp, shortname)

    local output = {}

    vim.fn.jobstart({ filename }, {
        stdout_buffered = true,
        stderr_buffered = true,

        on_stdout = function(_, data, _)
            if data then
                for _, line in ipairs(data) do
                    table.insert(output, line)
                end
            end
        end,

        on_stderr = function(_, data, _)
            if data then
                for _, line in ipairs(data) do
                    table.insert(output, line)
                end
            end
        end,

        on_exit = function(_, exit_code, _)
            local exit_message = string.format("Process exited with code %d", exit_code)
            table.insert(output, exit_message)

            local fd = io.open(log_file, "w")
            if fd then
                fd:write(table.concat(output, "\n"))
                fd:close()
                vim.notify("Output saved to: " .. log_file, vim.log.levels.INFO)
            else
                vim.notify("Failed to write log file: " .. log_file, vim.log.levels.ERROR)
            end

            utils.display_cmd_output(output, "Run Output: " .. shortname)
        end,
    })
end

M.search_run_logs = function()
    require("telescope.builtin").find_files {
        prompt_title = "Run Logs",
        find_command = { "rg", "--files", "--sortr=modified" },
        cwd = LOGS_DIR,
    }
end

return M
