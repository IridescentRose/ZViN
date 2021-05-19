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

    var sprt: sprite.Sprite = sprite.Sprite.init("bg.jpg");
    sprt.rect.w = 1280;
    sprt.rect.h = 720;

    var clip: audio.AudioClip = audio.AudioClip.init("music.mp3", true);
    clip.play();

    while(running) {
        window.clear();
        _ = c.SDL_WaitEvent(&event);

        switch(event.type){
            c.SDL_QUIT => {running = false;},
            else => {}
        }
        sprt.render();
        window.refresh();
    }

    sprt.deinit();
    window.deinit();
}
