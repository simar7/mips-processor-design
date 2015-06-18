module F_D_M_tb;

// R-Type FUNC Codes
parameter ADD 	= 6'b100000; //ADD;
parameter ADDU 	= 6'b100001; //ADDU;
parameter SUB	= 6'b100010; //SUB;
parameter SUBU	= 6'b100011; //SUBU;
parameter MULT	= 6'b011000; //MULT;
parameter MULTU = 6'b011001; //MULTU;
parameter DIV	= 6'b011010; //DIV;
parameter DIVU 	= 6'b011011; //DIVU;
parameter MFHI	= 6'b010000; //MFHI;
parameter MFLO 	= 6'b010010; //MFLO;
parameter SLT	= 6'b101010; //SLT;
parameter SLTU	= 6'b101011; //SLTU;
parameter SLL	= 6'b000000; //SLL;
parameter SLLV	= 6'b000100; //SLLV;
parameter SRL	= 6'b000010; //SRL;
parameter SRLV	= 6'b000110; //SRLV;
parameter SRA	= 6'b000011; //SRA;
parameter SRAV	= 6'b000111; //SRAV;
parameter AND	= 6'b100100; //AND;
parameter OR	= 6'b100101; //OR;
parameter XOR	= 6'b100110; //XOR;
parameter NOR	= 6'b100111; //NOR
parameter JALR	= 6'b001001; //JALR;
parameter JR	= 6'b001000; //JR;

// MUL R-TYPE INSN
parameter MUL_OP = 6'b011100; //MUL OPCODE
parameter MUL_FUNC = 6'b000010;  //MUL FUNCTION CODE

// I-Type Opcodes
parameter ADDI  = 6'b001000; //ADDI (Used for pseudoinstruction : LI)
parameter ADDIU = 6'b001001; //ADDIU
parameter SLTI  = 6'b001010; //SLTI
parameter SLTIU = 6'b001011; //SLTIU
parameter ORI	= 6'b001101; //ORI
parameter XORI  = 6'b001110; //XORI
parameter LW	= 6'b100011; //LW
parameter SW	= 6'b101011; //SW
parameter LB	= 6'b100000; //LB
parameter LUI   = 6'b001111; //LUI
parameter SB	= 6'b101000; //SB
parameter LBU	= 6'b100100; //LBU
parameter BEQ	= 6'b000100; //BEQ
parameter BNE	= 6'b000101; //BNE
parameter BGTZ	= 6'b000111; //BGTZ

// J-Type Opcodes
parameter J     = 6'b000010;
parameter JAL	= 6'b000011;

parameter NOP   = 6'b000000;

parameter RTYPE = 6'b000000; //R-Type INSN


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
reg [31:0] pc_decode, insn;
reg [31:0] pc_execute, insn_execute, rsData_execute, rtData_execute, imm_execute;
reg [5:0] ALUOp;
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
wire [31:0] insn_out;
wire [31:0] rsOut_regfile;
wire [31:0] rtOut_regfile;
wire rw_fetch;
wire [31:0] access_size_fetch;
wire [31:0] dataOut_execute;

// fileIO stuff
integer fd;
integer scan_fd;
integer status_read, status_write;
integer sscanf_ret;
integer words_read;
integer words_written;
integer words_fetched;
integer words_decoded;
integer words_executed;
integer words_processed;
integer fetch_not_enabled;
integer decode_not_enabled;
integer execute_not_enabled;

reg [31:0] line;

reg [5:0] opcode_out_tb;
reg [4:0] rs_out_tb;
reg [4:0] rt_out_tb;
reg [4:0] rd_out_tb;
reg [4:0] sa_out_tb;
reg [5:0] func_out_tb;
reg [25:0] imm_out_tb;
reg [31:0] pc_out_tb;
reg [31:0] insn_out_tb;
reg [31:0] pc_from_fetch_temp;
reg [31:0] rsOut_regfile_tb;
reg [31:0] rtOut_regfile_tb;

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
	.insn_out (insn_out),
	.enable_decode (enable_decode),
	.rsOut_regfile (rsOut_regfile), 
	.rtOut_regfile (rtOut_regfile), 
	.dVal_regfile  (dVal_regfile),
	.we_regfile    (we_regfile)
);

// Instantiate the execute module.
execute X0 (
	.clock (clock),
	.pc (pc_execute),
	.insn (insn_execute),
	.rsData (rsData_execute),
	.rtData (rtData_execute),
	.ALUOp (ALUOp),
	.imm (imm_execute),
	.dataOut (dataOut_execute)
);
	
initial begin

	fd = $fopen("SimpleAdd.x", "r");
	if (!fd)
		$display("Could not open");

	clock = 0;
	address = start_addr;
	scan_fd = $fscanf(fd, "%x", data_in);
	access_size = 2'b0_0;
	enable = 1;
	rw = 0;		// Start writing first.
	words_read = 0;
	words_written = 1;
	words_fetched = 0;
	words_decoded = 0;
	words_executed = 0;
	words_processed = 0;
	fetch_not_enabled = 1;
	decode_not_enabled = 1;
	execute_not_enabled = 1;

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
	
	
	if (rw == 1 && fetch_not_enabled == 1) begin : ENABLEFETCH
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

	
	if ((rw_fetch == 1) && (decode_not_enabled == 1)) begin : ENABLEDECODE
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
		insn_out_tb = insn_out;
		rsOut_regfile_tb = rsOut_regfile;
		rtOut_regfile_tb = rtOut_regfile;

		words_decoded <= words_decoded + 1;

		if (opcode_out_tb == 6'b000000 && rs_out_tb == 5'b00000 && rt_out_tb == 5'b00000 && rd_out_tb == 5'b00000 && sa_out_tb == 5'b00000 && func_out_tb == 6'b000000) begin
			$display("%x:\t%x\tNOP", pc_out_tb, insn_out_tb);
		end else if (opcode_out_tb == RTYPE || opcode_out_tb == MUL_OP) begin	
			// INSN is R-TYPE (including MUL, which has a non-zer0 opcode)
			case (func_out_tb)
				ADD: begin
					if((words_decoded > 0) && (words_fetched > 0) && enable_fetch && enable_decode && (words_processed < words_written)) begin
						words_processed = words_processed + 1;
						$display("%x:\t%x\tADD RS=%b RT=%b RD=%b SA=%b rsOut_regfile=%b rtOut_regfile=%b", pc_out_tb, insn_out_tb, rs_out_tb, rt_out_tb, rd_out_tb, sa_out_tb, rsOut_regfile_tb, rtOut_regfile_tb);
					end
				end
	
				ADDU: begin
					if((words_decoded > 0) && (words_fetched > 0) && enable_fetch && enable_decode && (words_processed < words_written)) begin
						words_processed = words_processed + 1;
						$display("%x:\t%x\tADDU RS=%b RT=%b RD=%b SA=%b rsOut_regfile=%b rtOut_regfile=%b", pc_out_tb, insn_out_tb, rs_out_tb, rt_out_tb, rd_out_tb, sa_out_tb, rsOut_regfile_tb, rtOut_regfile_tb);
					end
				end
	
				SUB: begin
					if((words_decoded > 0) && (words_fetched > 0) && enable_fetch && enable_decode && (words_processed < words_written)) begin
						words_processed = words_processed + 1;
						$display("%x:\t%x\tSUB RS=%b RT=%b RD=%b SA=%b", pc_out_tb, insn_out_tb, rs_out_tb, rt_out_tb, rd_out_tb, sa_out_tb);
					end
				end
	
				SUBU: begin
					if((words_decoded > 0) && (words_fetched > 0) && enable_fetch && enable_decode && (words_processed < words_written)) begin
						words_processed = words_processed + 1;
						$display("%x:\t%x\tSUBU RS=%b RT=%b RD=%b SA=%b", pc_out_tb, insn_out_tb, rs_out_tb, rt_out_tb, rd_out_tb, sa_out_tb);
					end
				end
	
				MUL_FUNC: begin
					if((words_decoded > 0) && (words_fetched > 0) && enable_fetch && enable_decode && (words_processed < words_written)) begin 
						words_processed = words_processed + 1;
						$display("%x:\t%x\tMUL RS=%b RT=%b RD=%b SA=%b", pc_out_tb, insn_out_tb, rs_out_tb, rt_out_tb, rd_out_tb, sa_out_tb);
					end
				end
			
				MULT: begin
					if((words_decoded > 0) && (words_fetched > 0) && enable_fetch && enable_decode && (words_processed < words_written)) begin
						words_processed = words_processed + 1;
						$display("%x:\t%x\tMULT RS=%b RT=%b RD=%b SA=%b", pc_out_tb, insn_out_tb, rs_out_tb, rt_out_tb, rd_out_tb, sa_out_tb);
					end
				end
	
				MULTU: begin
					if((words_decoded > 0) && (words_fetched > 0) && enable_fetch && enable_decode && (words_processed < words_written)) begin
						words_processed = words_processed + 1;
						$display("%x:\t%x\tMULTU RS=%b RT=%b RD=%b SA=%b", pc_out_tb, insn_out_tb, rs_out_tb, rt_out_tb, rd_out_tb, sa_out_tb);
					end
				end
	
				DIV: begin
					if((words_decoded > 0) && (words_fetched > 0) && enable_fetch && enable_decode && (words_processed < words_written)) begin
						words_processed = words_processed + 1;
						$display("%x:\t%x\tDIV RS=%b RT=%b RD=%b SA=%b", pc_out_tb, insn_out_tb, rs_out_tb, rt_out_tb, rd_out_tb, sa_out_tb);
					end
				end
	
				DIVU: begin
					if((words_decoded > 0) && (words_fetched > 0) && enable_fetch && enable_decode && (words_processed < words_written)) begin 
						words_processed = words_processed + 1;
						$display("%x:\t%x\tDIV RS=%b RT=%b RD=%b SA=%b", pc_out_tb, insn_out_tb, rs_out_tb, rt_out_tb, rd_out_tb, sa_out_tb);
					end
				end
	
				MFHI: begin
					if((words_decoded > 0) && (words_fetched > 0) && enable_fetch && enable_decode && (words_processed < words_written)) begin
						words_processed = words_processed + 1;
						$display("%x:\t%x\tMFHI RS=%b RT=%b RD=%b SA=%b", pc_out_tb, insn_out_tb, rs_out_tb, rt_out_tb, rd_out_tb, sa_out_tb);
					end
				end
	
				MFLO: begin
					if((words_decoded > 0) && (words_fetched > 0) && enable_fetch && enable_decode && (words_processed < words_written)) begin 
						words_processed = words_processed + 1;
						$display("%x:\t%x\tMFLO RS=%b RT=%b RD=%b SA=%b", pc_out_tb, insn_out_tb, rs_out_tb, rt_out_tb, rd_out_tb, sa_out_tb);
					end
				end
	
				SLT: begin
					if((words_decoded > 0) && (words_fetched > 0) && enable_fetch && enable_decode && (words_processed < words_written)) begin 
						words_processed = words_processed + 1;
						$display("%x:\t%x\tSLT RS=%b RT=%b RD=%b SA=%b", pc_out_tb, insn_out_tb, rs_out_tb, rt_out_tb, rd_out_tb, sa_out_tb);
					end
				end
	
				SLTU: begin
					if((words_decoded > 0) && (words_fetched > 0) && enable_fetch && enable_decode && (words_processed < words_written)) begin
						words_processed = words_processed + 1;
						$display("%x:\t%x\tSLTU RS=%b RT=%b RD=%b SA=%b", pc_out_tb, insn_out_tb, rs_out_tb, rt_out_tb, rd_out_tb, sa_out_tb);
					end
				end
	
				SLL: begin
					if((words_decoded > 0) && (words_fetched > 0) && enable_fetch && enable_decode && (words_processed < words_written)) begin
						words_processed = words_processed + 1;
						$display("%x:\t%x\tSLL RS=%b RT=%b RD=%b SA=%b", pc_out_tb, insn_out_tb, rs_out_tb, rt_out_tb, rd_out_tb, sa_out_tb);
					end
				end
	
				SLLV: begin
					if((words_decoded > 0) && (words_fetched > 0) && enable_fetch && enable_decode && (words_processed < words_written)) begin
						words_processed = words_processed + 1;
						$display("%x:\t%x\tSLLV RS=%b RT=%b RD=%b SA=%b", pc_out_tb, insn_out_tb, rs_out_tb, rt_out_tb, rd_out_tb, sa_out_tb);
					end
				end
	
				SRL: begin
					if((words_decoded > 0) && (words_fetched > 0) && enable_fetch && enable_decode && (words_processed < words_written)) begin
						words_processed = words_processed + 1;
						$display("%x:\t%x\tSRL RS=%b RT=%b RD=%b SA=%b", pc_out_tb, insn_out_tb, rs_out_tb, rt_out_tb, rd_out_tb, sa_out_tb);
					end
				end
	
				SRLV: begin
					if((words_decoded > 0) && (words_fetched > 0) && enable_fetch && enable_decode && (words_processed < words_written)) begin
						words_processed = words_processed + 1;
						$display("%x:\t%x\tSRLV RS=%b RT=%b RD=%b SA=%b", pc_out_tb, insn_out_tb, rs_out_tb, rt_out_tb, rd_out_tb, sa_out_tb);
					end
				end
	
				SRA: begin
					if((words_decoded > 0) && (words_fetched > 0) && enable_fetch && enable_decode && (words_processed < words_written)) begin
						words_processed = words_processed + 1;
						$display("%x:\t%x\tSRA RS=%b RT=%b RD=%b SA=%b", pc_out_tb, insn_out_tb, rs_out_tb, rt_out_tb, rd_out_tb, sa_out_tb);
					end
				end
	
				SRAV: begin
					if((words_decoded > 0) && (words_fetched > 0) && enable_fetch && enable_decode && (words_processed < words_written)) begin
						words_processed = words_processed + 1;
						$display("%x:\t%x\tSRAV RS=%b RT=%b RD=%b SA=%b", pc_out_tb, insn_out_tb, rs_out_tb, rt_out_tb, rd_out_tb, sa_out_tb);
					end
				end
	
				AND: begin
					if((words_decoded > 0) && (words_fetched > 0) && enable_fetch && enable_decode && (words_processed < words_written)) begin
						words_processed = words_processed + 1;
						$display("%x:\t%x\tAND RS=%b RT=%b RD=%b SA=%b", pc_out_tb, insn_out_tb, rs_out_tb, rt_out_tb, rd_out_tb, sa_out_tb);
					end
				end
	
				OR: begin
					if((words_decoded > 0) && (words_fetched > 0) && enable_fetch && enable_decode && (words_processed < words_written)) begin
						words_processed = words_processed + 1;
						$display("%x:\t%x\tOR RS=%b RT=%b RD=%b SA=%b", pc_out_tb, insn_out_tb, rs_out_tb, rt_out_tb, rd_out_tb, sa_out_tb);
					end
				end
	
				XOR: begin
					if((words_decoded > 0) && (words_fetched > 0) && enable_fetch && enable_decode && (words_processed < words_written)) begin
						words_processed = words_processed + 1;
						$display("%x:\t%x\tXOR RS=%b RT=%b RD=%b SA=%b", pc_out_tb, insn_out_tb, rs_out_tb, rt_out_tb, rd_out_tb, sa_out_tb);
					end
				end
	
				NOR: begin
					if((words_decoded > 0) && (words_fetched > 0) && enable_fetch && enable_decode && (words_processed < words_written)) begin
						words_processed = words_processed + 1;
						$display("%x:\t%x\tNOR RS=%b RT=%b RD=%b SA=%b", pc_out_tb, insn_out_tb, rs_out_tb, rt_out_tb, rd_out_tb, sa_out_tb);
					end
				end
	
				JALR: begin
					if((words_decoded > 0) && (words_fetched > 0) && enable_fetch && enable_decode && (words_processed < words_written)) begin
						words_processed = words_processed + 1;
						$display("%x:\t%x\tJALR RS=%b RT=%b RD=%b SA=%b", pc_out_tb, insn_out_tb, rs_out_tb, rt_out_tb, rd_out_tb, sa_out_tb);
					end
				end
	
				JR: begin
					if((words_decoded > 0) && (words_fetched > 0) && enable_fetch && enable_decode && (words_processed < words_written)) begin
						words_processed = words_processed + 1;
						$display("%x:\t%x\tJR RS=%b RT=%b RD=%b SA=%b", pc_out_tb, insn_out_tb, rs_out_tb, rt_out_tb, rd_out_tb, sa_out_tb);
					end
				end
			endcase
		end else if (opcode_out_tb != 6'b000000 && opcode_out_tb[5:1] != 5'b00001) begin
			// INSN is I-TYPE
			case (opcode_out_tb)
				ADDI: begin
					if((words_decoded > 0) && (words_fetched > 0) && enable_fetch && enable_decode && (words_processed < words_written)) begin
						words_processed = words_processed + 1;
						$display("%x:\t%x\tADDI RS=%b RT=%b IMM=%b", pc_out_tb, insn_out, rs_out_tb, rt_out_tb, imm_out_tb[25:10]);
					end
				end

				ADDIU: begin
					if((words_decoded > 0) && (words_fetched > 0) && enable_fetch && enable_decode && (words_processed < words_written)) begin
						words_processed = words_processed + 1;
						$display("%x:\t%x\tADDIU RS=%b RT=%b IMM=%b", pc_out_tb, insn_out, rs_out_tb, rt_out_tb, imm_out_tb[25:10]);
					end
				end

				SLTI: begin
					if((words_decoded > 0) && (words_fetched > 0) && enable_fetch && enable_decode && (words_processed < words_written)) begin
						words_processed = words_processed + 1;
						$display("%x:\t%x\tSLTI RS=%b RT=%b IMM=%b", pc_out_tb, insn_out, rs_out_tb, rt_out_tb, imm_out_tb[25:10]);
					end
				end

				SLTIU: begin
					if((words_decoded > 0) && (words_fetched > 0) && enable_fetch && enable_decode && (words_processed < words_written)) begin
						words_processed = words_processed + 1;
						$display("%x:\t%x\tSLTIU RS=%b RT=%b IMM=%b", pc_out_tb, insn_out, rs_out_tb, rt_out_tb, imm_out_tb[25:10]);
					end
				end

				ORI: begin
					if((words_decoded > 0) && (words_fetched > 0) && enable_fetch && enable_decode && (words_processed < words_written)) begin
						words_processed = words_processed + 1;
						$display("%x:\t%x\tORI RS=%b RT=%b IMM=%b", pc_out_tb, insn_out, rs_out_tb, rt_out_tb, imm_out_tb[25:10]);
					end
				end

				XORI: begin
					if((words_decoded > 0) && (words_fetched > 0) && enable_fetch && enable_decode && (words_processed < words_written)) begin
						words_processed = words_processed + 1;
						$display("%x:\t%x\tXORI RS=%b RT=%b IMM=%b", pc_out_tb, insn_out, rs_out_tb, rt_out_tb, imm_out_tb[25:10]);
					end
				end

				LW: begin
					if((words_decoded > 0) && (words_fetched > 0) && enable_fetch && enable_decode && (words_processed < words_written)) begin
						words_processed = words_processed + 1;
						$display("%x:\t%x\tLW RS=%b RT=%b IMM=%b", pc_out_tb, insn_out, rs_out_tb, rt_out_tb, imm_out_tb[25:10]);
					end
				end

				SW: begin
					if((words_decoded > 0) && (words_fetched > 0) && enable_fetch && enable_decode && (words_processed < words_written)) begin
						words_processed = words_processed + 1;
						$display("%x:\t%x\tSW RS=%b RT=%b IMM=%b", pc_out_tb, insn_out, rs_out_tb, rt_out_tb, imm_out_tb[25:10]);
					end
				end

				LB: begin
					if((words_decoded > 0) && (words_fetched > 0) && enable_fetch && enable_decode && (words_processed < words_written)) begin
						words_processed = words_processed + 1;
						$display("%x:\t%x\tLB RS=%b RT=%b IMM=%b", pc_out_tb, insn_out, rs_out_tb, rt_out_tb, imm_out_tb[25:10]);
					end
				end

				LUI: begin
					if((words_decoded > 0) && (words_fetched > 0) && enable_fetch && enable_decode && (words_processed < words_written)) begin
						words_processed = words_processed + 1;
						$display("%x:\t%x\tLUI RT=%b IMM=%b", pc_out_tb, insn_out_tb, rt_out_tb, imm_out_tb[25:10]);
					end
				end

				SB: begin
					if((words_decoded > 0) && (words_fetched > 0) && enable_fetch && enable_decode && (words_processed < words_written)) begin
						words_processed = words_processed + 1;
						$display("%x:\t%x\tSB RS=%b RT=%b IMM=%b", pc_out_tb, insn_out, rs_out_tb, rt_out_tb, imm_out_tb[25:10]);
					end
				end

				LBU: begin
					if((words_decoded > 0) && (words_fetched > 0) && enable_fetch && enable_decode && (words_processed < words_written)) begin
						words_processed = words_processed + 1;
						$display("%x:\t%x\tLBU RS=%b RT=%b IMM=%b", pc_out_tb, insn_out, rs_out_tb, rt_out_tb, imm_out_tb[25:10]);
					end
				end

				BEQ: begin
					if((words_decoded > 0) && (words_fetched > 0) && enable_fetch && enable_decode && (words_processed < words_written)) begin
						words_processed = words_processed + 1;
						$display("%x:\t%x\tBEQ RS=%b RT=%b IMM=%b", pc_out_tb, insn_out, rs_out_tb, rt_out_tb, imm_out_tb[25:10]);
					end 
				end

				BNE: begin
					if((words_decoded > 0) && (words_fetched > 0) && enable_fetch && enable_decode && (words_processed < words_written)) begin
						words_processed = words_processed + 1;
						$display("%x:\t%x\tBNE RS=%b RT=%b IMM=%b", pc_out_tb, insn_out, rs_out_tb, rt_out_tb, imm_out_tb[25:10]);
					end 
				end

				BGTZ: begin
  					if((words_decoded > 0) && (words_fetched > 0) && enable_fetch && enable_decode && (words_processed < words_written)) begin
						words_processed = words_processed + 1;
						$display("%x:\t%x\tBGTZ RS=%b RT=%b IMM=%b", pc_out_tb, insn_out, rs_out_tb, rt_out_tb, imm_out_tb[25:10]);
					end  
				end
			endcase
		end else if (opcode_out_tb[5:1] == 5'b00001) begin
			// INSN is J-Type
			case (opcode_out_tb)
				J: begin
  					if((words_decoded > 0) && (words_fetched > 0) && enable_fetch && enable_decode && (words_processed < words_written)) begin
						words_processed = words_processed + 1;
						$display("%x:\t%x\tJ IMM=%b", pc_out_tb, insn_out_tb, imm_out_tb);
					end  
				end

				JAL: begin
  					if((words_decoded > 0) && (words_fetched > 0) && enable_fetch && enable_decode && (words_processed < words_written)) begin
						words_processed = words_processed + 1;
						$display("%x:\t%x\tJAL IMM=%b", pc_out_tb, insn_out_tb, imm_out_tb);
					end  
				end
			endcase
		end else
			if((words_decoded > 0) && (words_fetched > 0) && enable_fetch && enable_decode && (words_processed < words_written)) begin
				words_processed = words_processed + 1;
				$display("PC=%x INSN=%x OPCODE=%b RS/BASE=%b RT=%b RD=%b SA/OFFSET=%b IMM=%b FUNC=%b", pc_out_tb, insn_out_tb, opcode_out_tb, rs_out_tb, rt_out_tb, rd_out_tb, sa_out_tb, imm_out_tb, func_out_tb);
			end
		end	

	
	if (execute_not_enabled == 1) begin : ENABLEEXECUTE
		execute_not_enabled = 0;
	end

	if (execute_not_enabled == 0 && words_executed <= words_written) begin : EXECUTESTAGE
		// TODO: TB Logic for Execute stage
	end
end

always
	#5 clock = ! clock;

endmodule 