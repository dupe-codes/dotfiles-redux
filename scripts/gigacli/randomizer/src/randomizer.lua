#!/usr/bin/env lua

local lfs = require "lfs"

local CHOICES_DIR = os.getenv "HOME" .. "/datastore/0 - quest journal/sagas"

local function list_sagas(dir)
    local sagas = {}
    for item in lfs.dir(dir) do
        if item ~= "." and item ~= ".." then
            local path = dir .. "/" .. item
            if lfs.attributes(path, "mode") == "directory" then
                table.insert(sagas, item)
            end
        end
    end
    return sagas
end

local function list_files(dir)
    local files = {}
    for file in lfs.dir(dir) do
        if file ~= "." and file ~= ".." then
            local path = dir .. "/" .. file
            if lfs.attributes(path, "mode") == "file" then
                table.insert(files, file)
            end
        end
    end
    return files
end

local function random_select(list)
    if #list == 0 then
        return nil
    end
    return list[math.random(#list)]
end

local function animate_selection(items, final_choice)
    local max_length = 0
    for _, item in ipairs(items) do
        if #item > max_length then
            max_length = #item
        end
    end
    max_length = max_length + 5

    local delay = 0.1
    for i = 1, 30 do
        local random_item = random_select(items)
        io.write("\r" .. random_item .. string.rep(" ", max_length - #random_item))
        io.flush()
        os.execute("sleep " .. string.format("%.2f", delay))
        delay = delay + 0.02
    end
    io.write("\r" .. final_choice .. string.rep(" ", max_length - #final_choice) .. "\n")
end

local M = {}

M.randomize = function()
    if not lfs.attributes(CHOICES_DIR, "mode") then
        error("Directory '" .. CHOICES_DIR .. "' does not exist.")
    end

    local sagas = list_sagas(CHOICES_DIR)
    if #sagas == 0 then
        print("No sagas found in '" .. CHOICES_DIR .. "'.")
        return
    end

    print "\nAvailable sagas:\n"
    for i, saga in ipairs(sagas) do
        print(i .. ". " .. saga)
    end

    io.write "\nSelect a saga by number: "
    local choice = tonumber(io.read())
    if not choice or choice < 1 or choice > #sagas then
        print "Invalid choice."
        return
    end

    local selected_saga = sagas[choice]
    local selected_path = CHOICES_DIR .. "/" .. selected_saga

    local files = list_files(selected_path)
    if #files == 0 then
        print("No files found in saga '" .. selected_saga .. "'.")
        return
    end

    print ""
    math.randomseed(os.time())
    local final_choice = random_select(files)
    animate_selection(files, final_choice)
end

M.randomize()
