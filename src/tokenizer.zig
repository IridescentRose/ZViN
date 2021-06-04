const std = @import("std");

pub const TokenArray = struct {
    ptr: [][]u8,
    len: usize,
    pos: u32,

    pub fn tokenize(path: []const u8, allocator: *std.mem.Allocator) !TokenArray {
        var res: TokenArray = undefined;
        res.pos = 0;

        var file = try std.fs.cwd().openFile(path, .{.read=true});
        var reader = file.reader();

        var tokArray : [4096][]u8 = undefined;
        var tokLen: usize = 0;

        var line = try reader.readUntilDelimiterOrEofAlloc(allocator, '\n', 256);
        while(line != null){

            var slice = line.?;

            if(slice.len > 2 and slice[0] != '/' and slice[1] != '/' and slice[0] != '\n'){
                var bufStream = std.io.fixedBufferStream(slice);
                var bufReader = bufStream.reader();

                var token = try bufReader.readUntilDelimiterOrEofAlloc(allocator, ' ', 256);
                while(token != null) {
                    var tkSlice = token.?;

                    tokArray[tokLen] = tkSlice;
                    tokLen += 1;

                    token = try bufReader.readUntilDelimiterOrEofAlloc(allocator, ' ', 256);
                }
            }

            allocator.free(line.?);
            line = try reader.readUntilDelimiterOrEofAlloc(allocator, '\n', 256);
        }
        

        res.len = tokLen;
        res.ptr = try allocator.alloc([]u8, tokLen);

        var i: usize = 0;
        while(i < res.len) {
            res.ptr[i] = tokArray[i];
            i += 1;
        }
        
        return res;
    }

    pub fn next(self: *TokenArray) void {
        self.pos += 1;
    }

    pub fn get(self: *TokenArray) []u8 {
        return self.ptr[self.pos];
    }
};