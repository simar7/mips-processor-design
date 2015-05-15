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
integer status_read, status_write;
integer sscanf_ret;
reg [31:0] fd_in;
reg [31:0] str;

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
	
	clock = 0;
	address = 0;
	data_in = 0;
	access_size = 0;
	rw = 0;
	enable = 1;

	// FIXME: WTF (read: -2147483641) is fd when doing fopen?!
	// FIXME: Find the right location where SumArray.x resides.
	fd = $fopen("/home/simar/SumArray.x", "r");
	if (!fd)
		$display("Could not open");
	
	// Read the data from file, stored in local regs.
	while (!$feof(fd)) begin
	$display("fd_in = %x", fd_in);
		@(posedge clock);
			status_read = $fscanf(fd, "%h\n", fd_in[31:16], fd_in[15:0]);
			sscanf_ret = $sscanf(str, "%x", fd_in);
	end
	$fclose(fd);

end

always
	clock = !clock;

endmodule