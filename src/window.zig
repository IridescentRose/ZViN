const c = @cImport({
    @cInclude("SDL_image.h");
    @cInclude("SDL_mixer.h");
});

pub const Color = struct {
    r: u8,
    g: u8,
    b: u8,
    a: u8
};

var window: ?*c.SDL_Window = null;
pub var renderer: ?*c_void = null;

pub fn init(title: []const u8, width: u16, height: u16) void {
    _ = c.SDL_Init(c.SDL_INIT_VIDEO | c.SDL_INIT_AUDIO);
    _ = c.Mix_Init(c.MIX_INIT_FLAC | c.MIX_INIT_MID | c.MIX_INIT_MOD | c.MIX_INIT_MP3 | c.MIX_INIT_OGG | c.MIX_INIT_OPUS);
    _ = c.Mix_OpenAudio(44100, c.AUDIO_S16SYS, 2, 512);
    _ = c.Mix_AllocateChannels(64);

    _ = c.IMG_Init(c.IMG_INIT_JPG | c.IMG_INIT_PNG | c.IMG_INIT_TIF | c.IMG_INIT_WEBP);
    window = c.SDL_CreateWindow(title.ptr, c.SDL_WINDOWPOS_UNDEFINED, c.SDL_WINDOWPOS_UNDEFINED, width, height, 0);
    renderer = c.SDL_CreateRenderer(window, -1, 0);
}

pub fn deinit() void {
    c.SDL_DestroyRenderer(@ptrCast(?*c.SDL_Renderer, renderer));
    c.SDL_DestroyWindow(window);
    c.IMG_Quit();
    c.Mix_CloseAudio();
    c.SDL_Quit();
}

pub fn clear() void {
    _ = c.SDL_RenderClear(@ptrCast(?*c.SDL_Renderer, renderer));
}

pub fn refresh() void {
    c.SDL_RenderPresent(@ptrCast(?*c.SDL_Renderer, renderer));
}

pub fn bgColor(col: Color) void {
    c.SDL_SetRenderDrawColor(@ptrCast(?*c.SDL_Renderer, renderer), c.r, c.g, c.b, c.a);
}
