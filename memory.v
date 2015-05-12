// ECE 429
module memory(clock, address, data_in, access_size, rw, busy, data_output);

input clock;
input address[31:0];
input data_in[31:0];
input access_size[1:0];
input rw;
input busy;
output data_out[31:0];

parameter depth = 1000000;

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

	