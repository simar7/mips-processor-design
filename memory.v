// ECE 429
module memory(clock, address, data_in, access_size, rw, busy, enable, data_out);

parameter data_width = 32;
parameter address_width = 32;
parameter depth = 1048576;

// -1 for 0 based indexed
parameter bytes_in_word = 4-1;
parameter bits_in_bytes = 8-1;
parameter BYTE = 8;
parameter start_addr = 32'h80020000;

// Input Ports
input clock;
input [address_width-1:0] address;
input [data_width-1:0] data_in;
input [1:0] access_size;
input rw;
input enable;

// Output Ports
output reg busy;
output reg [data_width-1:0] data_out;

// Create a 1MB deep memory of 8-bits (1 byte) width
reg [7:0] mem[0:depth]; // should be [7:0] since its byte addressible memory
reg [7:0] data;
reg [7:0] byte[3:0];
reg [31:0] global_cur_addr;
integer cyc_ctr = 0;
integer i = 0;

integer fd;
integer status_read, status_write;
integer blah;
reg [31:0] fd_in;
reg [31:0] str;

reg busy_r;

always @(posedge clock)
begin : WRITE
	// rw = 1
	if (!rw && enable) begin
		busy_r = 1'h1;
		assign busy = busy_r;
		mem[address-start_addr] <= data_in[7:0];
		mem[address-start_addr+1] <= data_in[15:8];
		mem[address-start_addr+2] <= data_in[23:16];
		mem[address-start_addr+3] <= data_in[31:24];	
	end
	busy_r = 1'h0;
	assign busy = busy_r;
end

/*
  00: 1 word   (4-bytes)
  01: 4 words  (16-bytes)
  10: 8 words  (32-bytes)
  11: 16 words (64-bytes)
*/

always @(posedge clock)
    if (!busy_r) begin
        global_cur_addr <= start_addr-address;
    end

always @(posedge clock)
begin : READ
	if (rw && enable) begin
		busy_r = 1'h1; 
		assign busy = busy_r;
	
		// 00: 1 word
        	if (access_size == 2'b0_0 ) begin
        		// read 4 bytes at max in 1 clock cycle.
			assign data_out = {mem[address-start_addr], mem[address-start_addr+1], mem[address-start_addr+2], mem[address-start_addr+3]};

       		// 01: 4 words
		end else if (access_size == 2'b0_1) begin
			if (cyc_ctr < 4) begin
				assign data_out = {mem[global_cur_addr], mem[global_cur_addr+1], mem[global_cur_addr+2], mem[global_cur_addr+3]};
			end
        	// 10: 8 words
		end else if (access_size == 2'b1_0) begin
			if (cyc_ctr < 4) begin
				assign data_out = {mem[global_cur_addr], mem[global_cur_addr+1], mem[global_cur_addr+2], mem[global_cur_addr+3]};
			end
        	// 11: 16 words
		end else if (access_size == 2'b1_1) begin
			if (cyc_ctr < 4) begin
				assign data_out = {mem[global_cur_addr], mem[global_cur_addr+1], mem[global_cur_addr+2], mem[global_cur_addr+3]};
			end
		end
        global_cur_addr = global_cur_addr + 4'h4;
        cyc_ctr = cyc_ctr + 1'h1;
        end 
	busy_r = 1'h0;
	assign busy = busy_r;
end

endmodule
	
