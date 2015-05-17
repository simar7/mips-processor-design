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
integer words_read;
integer words_written;
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
	address = start_addr;
	data_in = 0;
	access_size = 0;
	enable = 1;
	rw = 0;		// Start writing first.
	words_read = 0;
	words_written = 0;
	
	// WRITE
	//rw = 0;

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
	if (!$feof(fd) && rw == 0) begin
		enable = 1;
		rw = 0;
		scan_fd = $fscanf(fd, "%x", line);
		$display("line = %x", line);
		data_in = line;
		@(posedge clock);
		address = address + 4;
		words_written = words_written + 1;
	end
	else if ($feof(fd) && (words_read < words_written)) begin
		// done writing, now read...
		rw = 1;
		enable = 1;
		if (words_read == 0) begin
			address = 32'h80020000;
		end
		@(posedge clock);
		data_read = data_out;
		$display("data_read = %x", data_read);
		address = address + 4;
		words_read = words_read + 1;
		
	end
	else if (rw == 0 || (words_read >= words_written)) begin
		// TODO: Add logic to end simulation.
		enable = 0;
		rw = 0;	// can write now.
		@(posedge clock);
	end
	
	/* old logic.
	// WRITE
	if (!$feof(fd) && rw == 0) begin : MEM_WRITE
		scan_fd = $fscanf(fd, "%x", line);
		$display("line = %x", line);
		data_in = line;
		@ (posedge clock);
		address = address + 4;
	end
	else begin : MEM_READ
		// done writing, now read...
		rw = 1;
		data_read = data_out;
		$display("data_read = %x", data_read);
		address = address + 1;
		@ (posedge clock);
	end
	*/

always
	#1 clock = ! clock;

endmodule 