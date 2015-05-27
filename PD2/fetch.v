module fetch (clock, pc, rw, stall, access_size, enable);

// Input Ports
input clock;
input stall;

// Output Ports
output reg [31:0] pc;
output reg rw;
output reg [31:0] access_size;
output reg enable;			// Goes to enable signal of the memory

// Parameters
parameter start_addr = 32'h80020000;
parameter word_size = 4;

// Registers
reg [31:0] pc_reg;

initial begin
	pc = start_addr;
end

always @(posedge clock)
begin: FETCH

	if (!stall) begin

		pc_reg	 	= pc_reg + 4;
		
		pc 		<= pc_reg;
		rw 		<= 1;		// Always set to 1 for Fetch Stage
		access_size 	<= word_size;	// Always set to 1 word for Fetch Stage
		enable		<= 1;


	end else if (stall) begin
	
		pc 		<= pc_reg;
		rw		<= 1;		// Always set to 1 for Fetch Stage
		access_size	<= word_size;	// Always set to 1 word for Fetch Stage
		enable		<= 0;

	end
end

endmodule