module register_file(clock, we, rsIn, rtIn, rdIn, rsOut, rtOut, dVal, pc, insn);

parameter NUM_REGS = 32;
parameter WIDTH = 32;
parameter REG_WIDTH = 5;

input [REG_WIDTH - 1:0] rsIn, rtIn, rdIn;
input [WIDTH - 1:0] dVal;
input we, clock;

output [WIDTH - 1:0] rsOut, rtOut, pc, insn;

reg [WIDTH - 1:0] REGFILE [NUM_REGS - 1:0];

integer i;	

// Used for initializing REGFILE with values
initial
begin
	for (i = 0; i < NUM_REGS; i = i + 1) begin
		REGFILE[i] = i;
	end
end

// Combinationally write to rsOut and rtOut
assign rsOut = REGFILE[rsIn];
assign rtOut = REGFILE[rtIn];

// Clocked write of writeback data
always @(posedge clock)
begin: REG_WRITE
	if (we) begin
		REGFILE [rdIn] = dVal;
	end
end 

endmodule 