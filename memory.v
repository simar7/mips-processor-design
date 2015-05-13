// ECE 429
module memory(clock, address, data_in, access_size, rw, busy, enable, data_output);

input clock;
input address[31:0];
input data_in[31:0];
input access_size[1:0];
input rw;
input busy;
input enable;
output data_out[31:0];

parameter depth = 1048576;
// -1 for 0 based indexed
parameter bytes_in_word = 4-1;
parameter bits_in_bytes = 8-1;
parameter BYTE = 8;

// Create a 1MB deep memory of 8-bits (1 byte) width
reg [31:0] mem[depth];
reg [31:0] data;

reg [bits_in_bytes:0] byte[bytes_in_word:0];

always @(posedge clock)
begin : WRITE
	// rw = 1
	if (rw && !busy && enable) begin
		busy = 1;
		// Write data to memory[address]
		mem[address] <= data_in;

	end
end

/*
  00: 1 word   (4-bytes)
  01: 4 words  (16-bytes)
  10: 8 words  (32-bytes)
  11: 16 words (64-bytes)
*/
always @(posedge clock)
begin : READ
	if (!rw && !busy && enable) begin
		busy = 1; 
		if (access_size == 2'b0_0 ) begin
			// read 4 bytes at max in 1 clock cycle.
			for (i = 0; i < access_size/8; i = i+1 ) begin
				byte[i] <= mem[BYTE*i +: BYTE];
			end
		end else begin
			// send data onto data bus in consecutive cycles
			


				
		end
	end
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

	