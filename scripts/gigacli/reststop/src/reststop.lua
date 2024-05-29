#!/usr/bin/env lua

local catalog = require "catalog"
local my_package = require "my_package"
local second_package = require "my_package.second"

catalog.main()
my_package.my_function()
second_package.my_function()
