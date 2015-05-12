// ECE 429
module pd1_memory(clock, data_in, access_size, rw, busy, data_output);

input clock;
input data_in[31:0];
input access_size[1:0];
input rw;
input busy;
output data_out[31:0];

parameter depth = 1000000;

