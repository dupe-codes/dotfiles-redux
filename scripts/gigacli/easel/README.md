# Easel

a TUI command pallete

# Plans

1. read simple configured cli tools/commands from commands.yml
2. read more complex operations from scripts dir containing lua files
    - execute via Zig Lua C wrapper: [ziglua](https://github.com/natecraddock/ziglua)
    - example of using Lua c binding: [lua c bindings](https://www.oreilly.com/library/view/creating-solid-apis/9781491986301/ch01.html)
3. also support general mode that reads available commands from specified paths
4. expose as a tui with either:
    - [libvaxis](https://github.com/rockorager/libvaxis)
    - [tuile](https://github.com/akarpovskii/tuile)
    - [zig-spoon](https://sr.ht/~leon_plickat/zig-spoon/)
5. support stylization via rofi inspired config files
