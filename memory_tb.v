module memory_tb;

// Constants
parameter data_width = 32;
parameter address_width = 32;
parameter depth = 1048576;
parameter bytes_in_word = 4-1;	// -1 for 0 based indexed
parameter bits_in_bytes = 8-1;	// -1 for 0 based indexed
parameter BYTE = 8;
parameter start_addr = 32'h80020000;

// Input Ports
reg clock;
reg [address_width-1:0] address;
reg [data_width-1:0] data_in;
reg [1:0] access_size;
reg rw;
reg enable;

// Output Ports
wire busy;
wire [data_width-1:0] data_out;

// fileIO stuff
integer fd;
integer scan_fd;
integer status_read, status_write;
integer sscanf_ret;
reg [31:0] line;
reg [31:0] data_read;

// Instantiate the memory
memory M0 (
	.clock (clock),
	.address (address),
	.data_in (data_in),
	.access_size (access_size),
	.rw (rw),
	.enable (enable),
	.busy (busy),
	.data_out (data_out)
);

initial begin

	fd = $fopen("SumArray.x", "r");
	if (!fd)
		$display("Could not open");

	clock = 0;
	address = 0;
	data_in = 0;
	access_size = 0;
	enable = 1;
	
	// WRITE
	rw = 0;

//	// READ
//	rw = 1;
//	address = 0;
//	@(posedge clock)
//		data_read = data_out;
//		$display("data_read = %x", data_read);
//
//	$fclose(fd);
end

always
	// Read the data from file, stored in local regs.
	while (!$feof(fd)) begin
		scan_fd = $fscanf(fd, "%x", line);
		$display("line = %x", line);
		@ (posedge clock);
		data_in = line;
		address = address + 4;
	end

always
	#1 clock = ! clock;

endmodule 