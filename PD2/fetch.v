module fetch (clock, pc, rw, stall, access_size, enable_fetch);

// Input Ports
input clock;
input stall;
input enable_fetch;

// Output Ports
output reg [31:0] pc;
output reg rw;
output reg [31:0] access_size;
			
// Parameters
parameter start_addr = 32'h80020000;
parameter word_size = 4;


initial begin
	pc = start_addr;
end

always @(posedge clock)
begin: FETCH

	if (enable_fetch && !stall) begin
		
		pc 		<= pc + 4;
		rw 		<= 1;		// Always set to 1 for Fetch Stage
		access_size 	<= word_size;	// Always set to 1 word for Fetch Stage

	end else if (enable_fetch && stall) begin
	
		pc 		<= pc;
		rw		<= 1;		// Always set to 1 for Fetch Stage
		access_size	<= word_size;	// Always set to 1 word for Fetch Stage

	end
end

endmodule