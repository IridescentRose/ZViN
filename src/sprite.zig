const c = @cImport({
    @cInclude("SDL_image.h");
    @cInclude("SDL_mixer.h");
});
const std = @import("std");
const window = @import("window.zig");

pub const Sprite = struct {
    image: ?*c.SDL_Surface,
    texture: ?*c.SDL_Texture,
    rect: c.SDL_Rect,
    isShown: bool,

    pub fn init(file: []const u8) Sprite {

        var result = Sprite {
            .image = c.IMG_Load(file.ptr),
            .texture = null,
            .rect = undefined,
            .isShown = false
        };

        if(result.image == null){
            std.debug.print("ERROR: Could not load image for {s}!\n", .{file});
            c.exit(-1);
        }

        result.texture = c.SDL_CreateTextureFromSurface(@ptrCast(?*c.SDL_Renderer, window.renderer), result.image);
        result.rect.x = 0;
        result.rect.y = 0;
        result.rect.w = result.image.?.w;
        result.rect.h = result.image.?.h;
        
        if(result.texture == null){
            std.debug.print("ERROR: Could not load texture for {s}!\n", .{file});
            c.exit(-1);
        }
        
        return result;
    }

    pub fn render(self: Sprite) void{
        _ = c.SDL_RenderCopy(@ptrCast(?*c.SDL_Renderer, window.renderer), self.texture, null, &self.rect);
    }

    pub fn deinit(self: Sprite) void{
        c.SDL_DestroyTexture(self.texture);
        c.SDL_FreeSurface(self.image);
    }
};