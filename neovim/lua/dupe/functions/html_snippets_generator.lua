local tohtml = require "tohtml"

vim.api.nvim_create_user_command("GenerateSnippet", function(args)
    local filename = args.args
    vim.cmd.edit(filename)

    -- TODO:
    -- 1. parse out only the styling and main "pre" block of code
    -- 2. remove background color styling, or limit styling to only effect
    --    the code block html snippet
    -- 3. disable indent blank line for just this buffer
    local lines = tohtml.tohtml(0, {})

    io.stderr:write "\n\n"
    io.stderr:write(table.concat(lines, "\n"))
    io.stderr:flush()
end, { nargs = 1 })
