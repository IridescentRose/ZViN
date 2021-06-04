const window = @import("window.zig");
const sprite = @import("sprite.zig");
const audio = @import("audio.zig");
const tokenizer = @import("tokenizer.zig");
const std = @import("std");

const c = @cImport({
    @cInclude("SDL.h");
});

pub fn main() !void {
    window.init("ZViN", 1280, 720);

    var running: bool = true;
    var event: c.SDL_Event = undefined;

    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    
    var tokens = try tokenizer.TokenArray.tokenize("game/game.zvin", &gpa.allocator);

    for(tokens.ptr) |token| {
        std.debug.print("{s} ", .{token});
    }

    while(running) {
        window.clear();
        _ = c.SDL_WaitEvent(&event);

        switch(event.type){
            c.SDL_QUIT => {running = false;},
            else => {}
        }
        
        window.refresh();
    }

    window.deinit();
}
