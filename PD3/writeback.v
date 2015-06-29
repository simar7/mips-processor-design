module writeback(clock, data_in_mem, data_in_alu, rw_d, data_out);

parameter data_width = 32;

// Input Ports
input clock;
input [data_width-1:0] data_in_mem;
input [data_width-1:0] data_in_alu;
input rw_d;	// works opposite to rw for regfile.

// Output Ports
output reg [data_width-1:0] data_out;

always @(posedge clock)
begin

	if (rw_d == 0) begin
		data_out = data_in_alu;
	end
	else begin
		data_out = data_in_mem;
	end
end
endmodule