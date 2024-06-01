const std = @import("std");
const tuile = @import("tuile");

pub fn main() !void {
    var tui = try tuile.Tuile.init(.{});
    defer tui.deinit();

    try tui.add(
        tuile.block(
            .{
                .border = tuile.Border.all(),
                .border_type = .rounded,
                .layout = .{ .flex = 1 },
            },
            tuile.label(.{ .text = "Hello World!" }),
        ),
    );

    try tui.run();
}

test "simple test" {
    var list = std.ArrayList(i32).init(std.testing.allocator);
    defer list.deinit(); // try commenting this out and see if zig detects the memory leak!
    try list.append(42);
    try std.testing.expectEqual(@as(i32, 42), list.pop());
}
