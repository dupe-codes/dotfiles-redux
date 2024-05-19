#!/usr/bin/env lua

local inspect = require "inspect"

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
