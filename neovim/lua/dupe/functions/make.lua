-- convenience functions for working with makefiles

local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local conf = require("telescope.config").values
local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"

local display_cmd_output = require("dupe.functions.utils").display_cmd_output

local M = {}

local read_file = function(file_name)
    local file = io.open(file_name, "r")
    if not file then
        return nil
    end
    local content = file:read "a"
    file:close()
    return content
end

local in_git_repo = function()
    local repo_name = vim.fn.system("git rev-parse --show-toplevel"):gsub("\n", "")
    return not repo_name:find "fatal: not a git repository"
end

local jump_to_target = function(filepath, line_number)
    vim.cmd("e " .. filepath)
    vim.api.nvim_win_set_cursor(0, { line_number, 0 })
end

local make_telescope_picker = function(makefile_path, targets, opts)
    opts = opts or {}
    pickers
        .new(targets, {
            prompt_title = "Make targets",
            finder = finders.new_table {
                results = targets,
                entry_maker = function(entry)
                    return {
                        value = entry,
                        display = entry.name,
                        ordinal = entry.name,
                        path = makefile_path,
                        lnum = entry.line_num,
                    }
                end,
            },
            sorter = conf.generic_sorter(opts),
            previewer = conf.grep_previewer(opts),
            attach_mappings = function(prompt_bufnr, map)
                actions.select_default:replace(function()
                    actions.close(prompt_bufnr)
                    local selection = action_state.get_selected_entry().value
                    jump_to_target(makefile_path, selection.line_num)
                end)

                map({ "i", "n" }, "<C-r>", function()
                    actions.close(prompt_bufnr)
                    local selection = action_state.get_selected_entry().value
                    vim.notify("Running target: " .. selection.name)

                    -- TODO: handle make targets that do not immediately end
                    --       idea - run it async and pipe output to a persistent
                    --       buffer that can be toggled open. open that buffer
                    --       at the bottom of screen
                    local cmd = 'make --directory "$(git rev-parse --show-toplevel)" ' .. selection.name
                    local output = vim.fn.system(cmd)
                    display_cmd_output(output, "make output")
                end)

                return true
            end,
        })
        :find()
end

local get_root_makefile_buffer = function()
    if not in_git_repo() then
        vim.notify "list_targets: not in a git project"
        return -1, nil
    end

    local makefile = vim.fn.trim(vim.fn.system "git rev-parse --show-toplevel") .. "/Makefile"
    local content = read_file(makefile)
    if not content then
        vim.notify "list_targets: Makefile not found"
        return -1, nil
    end

    local bufnr = vim.api.nvim_create_buf(false, true)
    local lines = vim.split(content, "\n")
    vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, lines)
    return bufnr, makefile
end

M.list_targets = function()
    local targets = {}

    local bufnr = -1
    local makefile_path = nil
    local close_buffer = false

    if vim.bo.filetype == "make" then
        bufnr = vim.api.nvim_get_current_buf()
        makefile_path = vim.api.nvim_buf_get_name(0)
    else
        -- otherwise, parse targets from Makefile in project root
        bufnr, makefile_path = get_root_makefile_buffer()
        close_buffer = true
    end

    if bufnr == -1 then
        return
    end

    local parser = vim.treesitter.get_parser(bufnr, "make")
    local tree = parser:parse()[1]
    local root = tree:root()

    local query = assert(vim.treesitter.query.get("make", "targets"), "Make targets query not found")
    for _, capture in query:iter_captures(root, bufnr) do
        local target = vim.treesitter.get_node_text(capture, bufnr)
        if target ~= ".PHONY" then
            table.insert(targets, { name = target, line_num = capture:start() + 1 })
        end
    end

    if close_buffer then
        vim.api.nvim_buf_delete(bufnr, { force = true })
    end

    make_telescope_picker(makefile_path, targets)
end

M.show_make_dependency_graph = function()
    -- TODO: use treesitter to parse out the dependency structure
    --       of make targets, and render a simple dependency graph (mermaid?)
    vim.print "Hello!"
end

return M
