module fetch_decode_tb;

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

reg enable_fetch;
reg enable_decode;
reg [31:0] insn;
reg [31:0] pc_decode;
reg stall;


// Output Ports
wire busy;
wire [data_width-1:0] data_out;

wire [31:0] pc_fetch;
wire [5:0] opcode_out;
wire [4:0] rs_out;
wire [4:0] rt_out;
wire [4:0] rd_out;
wire [4:0] sa_out;
wire [5:0] func_out;
wire [25:0] imm_out;
wire [31:0] pc_out;
wire rw_fetch;
wire [31:0] access_size_fetch;

// fileIO stuff
integer fd;
integer scan_fd;
integer status_read, status_write;
integer sscanf_ret;
integer words_read;
integer words_written;
integer words_fetched;
integer words_decoded;
integer words_processed;
integer fetch_not_enabled;
integer decode_not_enabled;

reg [31:0] line;

reg [5:0] opcode_out_tb;
reg [4:0] rs_out_tb;
reg [4:0] rt_out_tb;
reg [4:0] rd_out_tb;
reg [4:0] sa_out_tb;
reg [5:0] func_out_tb;
reg [25:0] imm_out_tb;
reg [31:0] pc_out_tb;
reg [31:0] pc_from_fetch_temp;

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
	.pc (pc_fetch),
	.rw (rw_fetch),
	.stall (stall),
	.access_size (access_size_fetch),
	.enable_fetch (enable_fetch)
);

// Instantiate the decode module.
decode D0 (
	.clock (clock),
	.insn (insn),
	.pc (pc_decode),
	.opcode_out (opcode_out),
	.rs_out (rs_out),
	.rt_out (rt_out),
	.rd_out (rd_out),
	.sa_out (sa_out),
	.imm_out (imm_out),
	.func_out (func_out),
	.pc_out (pc_out),
	.enable_decode (enable_decode)
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
	words_fetched = 0;
	words_decoded = 0;
	words_processed = 0;
	fetch_not_enabled = 1;
	decode_not_enabled = 1;

	stall = 0;
end

always 	@(posedge clock) begin: POPULATE
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
		else begin: ENDWRITE
			rw <= 1;
			address <= 32'h80020000;
			//enable_fetch <= 1;
			stall = 0;
		end
	end
	
	
	if (rw == 1 && fetch_not_enabled == 1) begin: ENABLEFETCH
		//address <= 32'h80020000;
		//pc_decode <= pc_fetch;
		enable_fetch <= 1;
		fetch_not_enabled = 0;
	end
	

	if (enable_fetch && (words_fetched <= words_written)) begin : FETCHSTAGE
		address = pc_fetch;
		insn <= data_out;
		pc_from_fetch_temp <= pc_fetch;
		pc_decode = pc_from_fetch_temp;
		words_fetched <= words_fetched + 1;
		//enable_decode <= 1;
	end

	
	if ((rw_fetch == 1) && (decode_not_enabled == 1)) begin: ENABLEDECODE
		//address <= 32'h80020000;
		enable_decode <= 1;
		decode_not_enabled = 0;
	end
	

	if (enable_decode && (words_decoded <= words_written)) begin : DECODESTAGE
		//pc_decode <= pc_fetch;
		//pc_decode = pc_from_fetch_temp;
		opcode_out_tb = opcode_out;
		rs_out_tb = rs_out;
		rt_out_tb = rt_out;
		rd_out_tb = rd_out;
		sa_out_tb = sa_out;
		func_out_tb = func_out;
		imm_out_tb = imm_out;
		pc_out_tb = pc_out;
		words_decoded <= words_decoded + 1;
	end

	if((words_decoded > 0) && (words_fetched > 0) && enable_fetch && enable_decode && (words_processed < words_written)) begin : PRINT
		words_processed = words_processed + 1;
		$display("PC=%x OPCODE=%b RS/BASE=%b RT=%b RD=%b SA/OFFSET=%b IMM=%b FUNC=%b", pc_out_tb, opcode_out_tb, rs_out_tb, rt_out_tb, rd_out_tb, sa_out_tb, imm_out_tb, func_out_tb);
	end	
end

always
	#5 clock = ! clock;

endmodule 