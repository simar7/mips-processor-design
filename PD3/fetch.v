module fetch (clock, pc, rw, stall, access_size, enable_fetch, mem_enable, pc_backup);

// Input Ports
input clock;
input stall;
input enable_fetch;

// Output Ports
output reg [31:0] pc;
output reg rw;
output reg [31:0] access_size;
output reg mem_enable;
			
// Parameters
parameter start_addr = 32'h80020000;
parameter word_size = 4;

output reg [31:0] pc_backup;

initial begin
	pc = start_addr;
	pc_backup = start_addr;
end

always @(posedge clock)
begin: FETCH

	if (enable_fetch && !stall) begin
		
		pc 		<= pc_backup + 4;
		pc_backup	<= pc + 4;
		rw 		<= 1;		// Always set to 1 for Fetch Stage
		access_size 	<= word_size;	// Always set to 1 word for Fetch Stage

	end else if (enable_fetch && stall) begin
	
		pc_backup	<= pc_backup;
		pc 		<= 32'h00000000;
		rw		<= 1;		// Always set to 1 for Fetch Stage
		access_size	<= word_size;	// Always set to 1 word for Fetch Stage

	end
end

always @(stall) begin
	if (stall == 0) begin
		mem_enable = 0;
	end else begin
		mem_enable = 1;
	end
	
end

endmodule