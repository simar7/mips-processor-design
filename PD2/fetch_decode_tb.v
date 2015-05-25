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


// Instantiate the memory module.
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

// Instantiate the fetch module.
fetch F0 (
	.clock (clock),
	.pc (pc),
	.rw (rw),
	.stall (stall),
	.access_size (access_size)
);

// Instantiate the decode module.
decode D0 (
	.clock (clock),
	.insn (insn),
	.pc (pc)
);


/*
  Mapping for access size:
  00: 1 word   (4-bytes)
  01: 4 words  (16-bytes)
  10: 8 words  (32-bytes)
  11: 16 words (64-bytes)
*/
initial begin

	fd = $fopen("SumArray.x", "r");
	if (!fd)
		$display("Could not open");

	clock = 0;
	address = start_addr;
	scan_fd = $fscanf(fd, "%x", data_in);
	//data_in = 0;
	access_size = 2'b0_0;
	enable = 1;
	rw = 0;		// Start writing first.
	words_read = 0;
	words_written = 1;
end

always 	@(posedge clock) begin
	if (rw == 0) begin
		enable = 1;
		//rw = 0;
		scan_fd = $fscanf(fd, "%x", line);
		if (!$feof(fd)) begin
			data_in = line;
			$display("line = %x", data_in);
			address = address + 4;
			words_written = words_written + 1;	
		end
		else begin
			rw = 1;
			address = 32'h80020000;
		end

	end
	else if ($feof(fd) && (words_read < words_written)) begin
		// done writing, now read...
		rw = 1;
		enable = 1;
		data_read = data_out;
		$display("data_read = %x", data_read);
		address = address + 4;
		words_read = words_read + 1;
		
	end
	else if (words_read >= words_written) begin
		// TODO: Add logic to end simulation.
	end

end

always
	#5 clock = ! clock;

endmodule 