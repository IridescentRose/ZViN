const prog = @import("program.zig");

const Self = @This();

program: *prog.Program,
instructionPointer: usize,
hasExecutedCurrent: bool,

pub fn execute(self: Self) void {

}

pub fn draw(self: Self) void {

}

pub fn step(self: Self) void {
    self.hasExecutedCurrent = false;
    self.instructionPointer += 1;
}