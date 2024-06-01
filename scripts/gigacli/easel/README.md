# Easel

a TUI command pallete

# Plans

1. read simple configured cli tools/commands from commands.yml
2. read more complex operations from scripts dir containing lua files
    - execute via Zig Lua C wrapper: [ziglua](https://github.com/natecraddock/ziglua)
3. also support general more that reads available commands from specified paths
4. expose as a tui with https://github.com/rockorager/libvaxis
