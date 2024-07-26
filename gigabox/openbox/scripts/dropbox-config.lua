#!/usr/bin/env lua

local dropbox_dir = os.getenv "HOME" .. "/Dropbox"
local exclude_file = os.getenv "HOME" .. "/.config/dropbox/excludes.txt"

-- TODO: compare file with current excluded, and _include_
--       any in the latter not in former. that way we cna
--       reactivate sync'ing by editting the config file
local exclude_from_dropbox = function()
    local file = io.open(exclude_file, "r")

    if not file then
        print("Failed to open file: " .. exclude_file)
        return
    end

    for line in file:lines() do
        local dropbox_path = dropbox_dir .. "/" .. line
        local command = string.format('dropbox-cli exclude add "%s"', dropbox_path)
        local result = os.execute(command)
        if result then
            print("Excluded: " .. line)
        else
            print("Failed to exclude: " .. line)
        end
    end

    file:close()
end

exclude_from_dropbox()
