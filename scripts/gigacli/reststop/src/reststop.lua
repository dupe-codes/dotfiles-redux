#!/usr/bin/env lua

local inspect = require "inspect"
local test = require "src.test"

local output = {
    hero = {
        name = "Superman",
        age = 100,
    },
    villain = {
        name = "Lex Luthor",
        age = 50,
    },
}

print(inspect(output))
print(test.hello "world")

local command = "http GET https://jsonplaceholder.typicode.com/posts/1 | jq ."
local handle = io.popen(command)
if not handle then
    error("Failed to execute command: " .. command)
end
local result = handle:read "*a"
handle:close()

print(result)

local ltui = require "ltui"
local application = ltui.application
local rect = ltui.rect
local window = ltui.window
local demo = application()
local inputdialog = ltui.inputdialog

function demo:init()
    application.init(self, "demo")
    self:background_set "blue"
    self:insert(
        window:new(
            "window.main",
            rect { 1, 1, self:width() - 1, self:height() - 1 },
            "main window",
            true
        )
    )

    local dialog_input = inputdialog:new("dialog.input", rect { 0, 0, 50, 8 })
    dialog_input:text():text_set "please input text:"
    dialog_input:button_add("no", "< No >", function(v)
        dialog_input:quit()
    end)
    dialog_input:button_add("yes", "< Yes >", function(v)
        dialog_input:quit()
    end)
    self:insert(dialog_input, { centerx = true, centery = true })
end

--demo:run()
