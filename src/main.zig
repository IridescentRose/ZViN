const window = @import("window.zig");
const sprite = @import("sprite.zig");
const audio = @import("audio.zig");

const c = @cImport({
    @cInclude("SDL.h");
});

pub fn main() !void {
    window.init("ZViN", 1280, 720);

    var running: bool = true;
    var event: c.SDL_Event = undefined;

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
