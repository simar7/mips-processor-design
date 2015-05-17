// ECE 429
//FIXME: include output port busy
module memory(clock, address, data_in, access_size, rw, enable, data_out);

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
//FIXME: change to output port.
reg busy;
output reg [data_width-1:0] data_out;

// Create a 1MB deep memory of 8-bits (1 byte) width
reg [7:0] mem[0:depth]; // should be [7:0] since its byte addressible memory
reg [7:0] data;
reg [7:0] byte[3:0];
reg [31:0] global_cur_addr;
reg [31:0] global_cur_addr_write;
integer cyc_ctr = 0;
integer cyc_ctr_write = 0;
integer i = 0;
integer words_written = 0;
integer words_read = 0;
integer total_words = 0;

integer fd;
integer status_read, status_write;
integer blah;
reg [31:0] fd_in;
reg [31:0] str;

always @(posedge clock, data_in, rw)
begin : WRITE
	// rw = 1
	if ((!rw && enable)) begin
		if(total_words > 1) begin
			busy = 1;
		end
		else begin
			busy = 0;
		end
		// 00: 1 word
        	if (access_size == 2'b0_0 ) begin
			mem[address-start_addr+3] <= data_in[7:0];
			mem[address-start_addr+2] <= data_in[15:8];
			mem[address-start_addr+1] <= data_in[23:16];
			mem[address-start_addr] <= data_in[31:24];	
		end
		// 01: 4 words
		else if (access_size == 2'b0_1) begin
			total_words = 4;
			global_cur_addr_write = address-start_addr;
			// state when no cycles or current burst.
			/*if (words_written == 0 && busy == 0) begin
				global_cur_addr_write = address-start_addr;
			end
			else if (words_written < total_words) begin
				global_cur_addr_write = address-start_addr;
			end
			*/
			if (words_written < 4) begin
				busy = 1;
				mem[global_cur_addr_write+3] <= data_in[7:0];
				mem[global_cur_addr_write+2] <= data_in[15:8];
				mem[global_cur_addr_write+1] <= data_in[23:16];
				mem[global_cur_addr_write] <= data_in[31:24];
				words_written <= words_written + 1;
			end
			else begin
				busy = 0;
				words_written <= 0;
			end
		end
	end
end

/*
  00: 1 word   (4-bytes)
  01: 4 words  (16-bytes)
  10: 8 words  (32-bytes)
  11: 16 words (64-bytes)
*/

always @(posedge clock, address, rw)
begin : READ
	if ((rw && enable)) begin 
		// 00: 1 word
        	if (access_size == 2'b0_0 ) begin
        		// read 4 bytes at max in 1 clock cycle.
			//assign data_out = {mem[address-start_addr], mem[address-start_addr+1], mem[address-start_addr+2], mem[address-start_addr+3]};
			data_out[7:0] <= mem[address-start_addr+3];
			data_out[15:8] <= mem[address-start_addr+2];
			data_out[23:16] <= mem[address-start_addr+1];
			data_out[31:24] <= mem[address-start_addr];

       		// 01: 4 words
		end else if (access_size == 2'b0_1) begin
			if (cyc_ctr < 4) begin
				//assign data_out = {mem[global_cur_addr], mem[global_cur_addr+1], mem[global_cur_addr+2], mem[global_cur_addr+3]};
				busy <= 1;
				data_out[7:0] <= mem[global_cur_addr+3];
				data_out[15:8] <= mem[global_cur_addr+2];
				data_out[23:16] <= mem[global_cur_addr+1];
				data_out[31:24] <= mem[global_cur_addr];
			end
        	// 10: 8 words
		end else if (access_size == 2'b1_0) begin
			if (cyc_ctr < 4) begin
				//assign data_out = {mem[global_cur_addr], mem[global_cur_addr+1], mem[global_cur_addr+2], mem[global_cur_addr+3]};
			end
        	// 11: 16 words
		end else if (access_size == 2'b1_1) begin
			if (cyc_ctr < 4) begin
				//assign data_out = {mem[global_cur_addr], mem[global_cur_addr+1], mem[global_cur_addr+2], mem[global_cur_addr+3]};
			end
		end
        global_cur_addr = global_cur_addr + 4;
        cyc_ctr = cyc_ctr + 1;
        end 
end

endmodule
	
