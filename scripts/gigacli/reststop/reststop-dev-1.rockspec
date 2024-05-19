package = "reststop"
version = "dev-1"
source = {
    url = "git+ssh://git@github.com/dupe-codes/dotfiles-redux.git",
}
description = {
    summary = "a command line utility for interacting with REST apis",
    detailed = "a command line utility for interacting with REST apis",
}
dependencies = {
    "lua ~> 5.4",
    "inspect >= 3.1",
    "ltui = 2.7",
}
build = {
    type = "builtin",
    modules = {
        reststop = "src/reststop.lua",
    },
}
