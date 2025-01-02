package = "randomizer"
version = "dev-1"
source = {
    url = "git+ssh://git@github.com/dupe-codes/dotfiles-redux.git",
}
description = {
    homepage = "*** please enter a project homepage ***",
    license = "*** please specify a license ***",
}
dependencies = {
    "debugger = scm-1",
    "ldoc = 1.5.0-1",
    "ltui = 2.7",
    "inspect >= 3.1",
    "lua ~> 5.4",
    "luafilesystem = 1.8.0",
}
build = {
    type = "builtin",
    modules = {
        main = "src/randomizer.lua",
        setup = "src/setup.lua",
        randomizer = "src/randomizer.lua",
    },
    install = {
        bin = {
            ["randomizer"] = "src/randomizer.lua",
        },
    },
}
