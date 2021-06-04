const tokenizer = @import("tokenizer.zig");

pub const VarType = enum {
    Character,
    Sprite,
    Music,
    Sound
};

pub const Variable = struct {
    vtype: VarType,
    name: []u8,
    data: *c_void
};

pub const StatementType = enum {
    Exit,
    Show,
    Play,
    Say,
    Stop,
    Hide
};

pub const Statement = struct {
    stype: StatementType,
    data: *c_void
};

pub const Program = struct {
    vars: []Variable,
    body: []StatementType,

    pub fn parse(array: tokenizer.TokenArray) Program {
        var res : Program = undefined;

        return res;
    }
};
