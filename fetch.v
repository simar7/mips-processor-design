module fetch (clock, pc_out, rw_out, stall_input, access_size_out);

// Input Ports
input clock;
input stall_input;

input rw;

// Output Ports
output [31:0] pc_out;
output rw_out;
output [31:0] access_size_out;
output enable_out;			// Goes to enable signal of the memory

// Parameters
parameter start_addr = 32'h80020000;
parameter word_size = 2'b11;		// 11 = 4 bytes = 1 word

// Registers
reg [31:0] pc;

initial begin
	pc = start_addr;
end

always @(posedge clock)
begin: FETCH

	if (rw && !stall_input) begin

		pc = pc + 4;
		
		pc_out 		<= pc;
		rw_out 		<= 1;		// Always set to 1 for Fetch Stage
		access_size_out <= word_size	// Always set to 1 word for Fetch Stage
		enable_out	<= 1;


	end else if (rw && stall_input) begin
	
		pc_out 		<= pc;
		rw_out		<= 1;		// Always set to 1 for Fetch Stage
		access_size_out	<= word_size	// Always set to 1 word for Fetch Stage
		enable_out	<= 0;

	end
end
	
		
	

