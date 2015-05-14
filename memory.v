// ECE 429
module memory(clock, address, data_in, access_size, rw, busy, enable, data_output);

parameter data_width = 32;
parameter address_width = 32;
parameter depth = 1048576;

// -1 for 0 based indexed
parameter bytes_in_word = 4-1;
parameter bits_in_bytes = 8-1;
parameter BYTE = 8;

// Input Ports
input clock;
input address[address_width-1:0];
input data_in[data_width-1:0];
input access_size[1:0];
input rw;
input busy;
input enable;

// Output Ports
output data_out[data_width-1:0];

// Create a 1MB deep memory of 8-bits (1 byte) width
reg [7:0] mem[depth]; // should be [7:0] since its byte addressible memory
reg [7:0] data;
reg [7:0] byte[3:0];

always @(posedge clock)
begin : WRITE
	// rw = 1
	if (rw && !busy && enable) begin
		busy = 1;
		mem[address] <= data_in;
	end
	busy = 0;
end

/*
  00: 1 word   (4-bytes)
  01: 4 words  (16-bytes)
  10: 8 words  (32-bytes)
  11: 16 words (64-bytes)
*/

// Combine 4 bytes together to send out.
assign data_out = {byte[0], byte[1], byte[2], byte[3]};

always @(posedge clock)
begin : READ
	if (!rw && !busy && enable) begin
		busy = 1; 
		// 00: 1 word
        if (access_size == 2'b0_0 ) begin
            // read 4 bytes at max in 1 clock cycle.
			for (i = 0; i < 4; i = i+1) begin
				byte[i] <= mem[address+i];
			end
		end else if (access_size == 2'b0_1) begin
			for (i = 0; i < 4 && cyc_ctr < 4; i = i+1) begin
				byte[i] <= mem[global_cur_add+i];
		
		end else if (access_size == 2'b1_0) begin
		
		end else if (access_size == 2'b1_1) begin

		end 
        global_cur_addr = global_cur_addr + 4;
        cyc_ctr = cyc_ctr + 1;
	end
	busy = 0;
end

endmodule;



/* 
   // loop
   {
     if rw == 1:
	asrt busy -> 1
	// do read logic 
	// we get address
 	if address == 32 bits
		if access_size > 32 bits
			cycles - each 4 bytes wide
		else
			send 4 bytes of data on data bus
     else // rw = 0
	asrt busy -> 1
	// do write logic
	// we get address and data_in

     // at the end of the loop de-assrt busy
     asrt busy -> 0
   }
*/

	
