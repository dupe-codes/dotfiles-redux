#!/usr/bin/env lua

local lfs = require "lfs"

local CHOICES_DIR = os.getenv "HOME" .. "/datastore/13 - hacking/randomizer"

local function list_files(dir)
    local files = {}
    for file in lfs.dir(dir) do
        if file ~= "." and file ~= ".." then
            table.insert(files, file)
        end
    end
    return files
end

local function read_file(filepath)
    local lines = {}
    local file = io.open(filepath, "r")
    if file then
        for line in file:lines() do
            table.insert(lines, line)
        end
        file:close()
    else
        error("Could not open file: " .. filepath)
    end
    return lines
end

local function random_select(list)
    if #list == 0 then
        return nil
    end
    return list[math.random(#list)]
end

local function animate_selection(lines, final_choice)
    local max_length = 0
    for _, line in ipairs(lines) do
        if #line > max_length then
            max_length = #line
        end
    end
    max_length = max_length + 5

    local delay = 0.1
    for i = 1, 30 do
        local random_line = random_select(lines)
        io.write("\r" .. random_line .. string.rep(" ", max_length - #random_line))
        io.flush()
        os.execute("sleep " .. string.format("%.2f", delay))
        delay = delay + 0.02
    end
    io.write("\r" .. final_choice .. string.rep(" ", max_length - #final_choice) .. "\n")
end

local M = {}

M.randomize = function()
    if not lfs.attributes(CHOICES_DIR, "mode") then
        error("The directory '" .. CHOICES_DIR .. "' does not exist.")
    end

    local files = list_files(CHOICES_DIR)
    if #files == 0 then
        print("No files available in '" .. CHOICES_DIR .. "'.")
        return
    end

    print "Available files:"
    for i, file in ipairs(files) do
        print(i .. ". " .. file)
    end

    io.write "Select a file by number: "
    local choice = tonumber(io.read())
    if not choice or choice < 1 or choice > #files then
        print "Invalid choice."
        return
    end

    local selected_file = files[choice]
    local filepath = CHOICES_DIR .. "/" .. selected_file
    local lines = read_file(filepath)

    if #lines == 0 then
        print "The file is empty."
        return
    end

    math.randomseed(os.time())
    local final_choice = random_select(lines)
    animate_selection(lines, final_choice)
end

M.randomize()
