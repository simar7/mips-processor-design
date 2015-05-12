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

parameter depth = 1000000;

// Create a 1MB deep memory of 8-bits (1 byte) width
reg [7:0] mem[depth];
reg [7:0] data;

always @(posedge clock)
begin : WRITE
	if (rw && !busy && enable) begin
		busy = 1;
		// Write data to memory[address]

	end
end

always @(posedge clock)
begin : READ
	if (!rw && !busy && enable) begin
		busy = 1; 
		if (access_size > 32) begin
			// send data onto data bus in consecutive cycles
		end else begin
			// send data onto data bus
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

	