# RestStop

a command line utility for interacting with REST apis

written in lua

## tools

- httpie for launching requests
- jo for formatting input data
- jq for parsing output json data
- tidy for parsing output html data

## ideas/plans

- read available endpoints from a config file
    - either in cwd or specified as flag
    - e.g. endpoints.rs.yml (rs := RestStop)
    - can pre-populate headers and inputs
- and/or read endpoints from open-api spec
- simple TUI for selecting available endpoints and configuring
  requests
- store history of commands and executions in a sqlite db, location configured
  in config.toml file from XDG_CONFIG dir

## inspo

- [reddit thread](https://www.reddit.com/r/commandline/comments/ev0ukt/comment/ffysbng/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button)
- https://github.com/whiteinge/dotfiles/blob/master/bin/c

## resources

- https://leafo.net/guides/customizing-the-luarocks-tree.html
- https://martin-fieber.de/blog/lua-project-setup-with-luarocks/
- https://github.com/tboox/ltui
- https://github.com/mpeterv/argparse
