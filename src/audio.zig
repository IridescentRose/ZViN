const c = @cImport({
    @cInclude("SDL_mixer.h");
    @cInclude("SDL.h");
});

pub const AudioClip = struct {
    music: ?*c.Mix_Music,
    chunk: ?*c.Mix_Chunk,
    isMusic: bool,

    pub fn init(file: []const u8, music: bool) AudioClip{

        var res: AudioClip = undefined;
        res.isMusic = music;

        if(music) {
            res.music = c.Mix_LoadMUS(file.ptr);
        } else {
            res.chunk = c.Mix_LoadWAV(file.ptr);
        }

        return res;
    }

    pub fn play(self: AudioClip) void {
        if(self.isMusic) {
            _ = c.Mix_FadeOutMusic(200);
            c.SDL_Delay(200);
            _ = c.Mix_FadeInMusic(self.music, 0, 200);
        }else{
            _ = c.Mix_PlayChannel(-1, self.chunk, 0);
        }
    }
    pub fn stop(self: AudioClip) void {
        if(self.isMusic){
            _ = c.Mix_FadeOutMusic(200);
            c.SDL_Delay(200);
        }else{
            _ = c.Mix_Pause(-1);
        }
    }

    pub fn deinit(self: AudioClip) void {
        if(self.music){
            Mix_FreeMusic(self.music);
        }else{
            Mix_FreeChunk(self.chunk);
        }
    }
};

