module decode(clock, insn, pc, opcode_out, rs_out, rt_out, rd_out,
	sa_out, func_out, imm_out, enable_decode, pc_out,
	insn_out, ALUOp, rsOut_regfile, rtOut_regfile, dVal_regfile, we_regfile, imm_out_sx, rdIn);

/****************OPCODES******************/
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

// MUL R-TYPE Opcode
parameter MUL_OP = 6'b011100; 	//MUL OPCODE
parameter MUL_FUNC = 6'b000010; //MUL FUNCTION CODE

// I-Type Opcodes
parameter ADDI  = 6'b001000; //ADDI (LI)
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
parameter BLEZ	= 6'b000110; //BLEZ

// REGIMM Opcodes
parameter BLTZ = 5'b00000; // BLTZ
parameter BGEZ = 5'b00001; // BGEZ 

// J-Type Opcodes
parameter J     = 6'b000010;
parameter JAL	= 6'b000011;

// Other 
parameter NOP   = 6'b000000;
parameter RTYPE = 6'b000000;
/******************************************/

// Control Registers
output reg [5:0] ALUOp;

// Input ports
input wire clock;
input wire [31:0] insn;
input wire [31:0] pc;
input wire enable_decode;
input wire [4:0] rdIn;

// Registers
reg [31:0] pc_reg;

// Output
output reg [5:0] opcode_out;
output reg [4:0] rs_out;
output reg [4:0] rt_out;
output reg [4:0] rd_out;
output reg [4:0] sa_out;
output reg [5:0] func_out;
output reg [25:0] imm_out;
output reg [31:0] pc_out;
output reg [31:0] insn_out;
output reg [31:0] imm_out_sx;

// Register File Logic
parameter NUM_REGS = 32;
parameter WIDTH = 32;
parameter REG_WIDTH = 5;

reg [REG_WIDTH - 1:0] rsIn_regfile, rtIn_regfile, rdIn_regfile;
input [WIDTH - 1:0] dVal_regfile;
input we_regfile;

output [WIDTH - 1:0] rsOut_regfile, rtOut_regfile;

reg [WIDTH - 1:0] REGFILE [NUM_REGS - 1:0];

integer i_regfile;	

// Combinationally write to rsOut and rtOut
assign rsOut_regfile = REGFILE[rsIn_regfile];
assign rtOut_regfile = REGFILE[rtIn_regfile];


// Used for initializing REGFILE with values
initial
begin
	for (i_regfile = 0; i_regfile < NUM_REGS; i_regfile = i_regfile + 1) begin
		REGFILE[i_regfile] = i_regfile;
	end
	REGFILE[29] = 32'h80120000;     // stack pointer
end

always @(posedge clock)
begin : DECODE
	if (enable_decode) begin
		pc_out <= pc;
		insn_out <= insn;
		if (insn[31:26] == RTYPE || insn[31:26] == MUL_OP) begin
			// Instruction is R-type
			// Further need to clasify function (add, sub, etc..)
			opcode_out = RTYPE;

			case (insn[5:0])
				ADD: begin				// Used for MOVE pseudoinsn
					rs_out = insn[25:21];
					rt_out = insn[20:16];
					rd_out = insn[15:11];
					sa_out = insn[10:6];	
					imm_out = 26'hx;
					func_out = insn[5:0];
					ALUOp = ADD;
					rsIn_regfile = rs_out;
					rtIn_regfile = rt_out;
					rdIn_regfile = rd_out;		
					imm_out_sx[31:0] = 32'hx;		
				end

				ADDU: begin
					rs_out = insn[25:21];
					rt_out = insn[20:16];
					rd_out = insn[15:11];
					sa_out = insn[10:6];
					imm_out = 26'hx;
					func_out = insn[5:0];	
					ALUOp = ADDU;
					rsIn_regfile = rs_out;
					rtIn_regfile = rt_out;
					rdIn_regfile = rd_out;	
					imm_out_sx[31:0] = 32'hx;	
				end

				SUB: begin
					rs_out = insn[25:21];
					rt_out = insn[20:16];
					rd_out = insn[15:11];
					sa_out = insn[10:6];
					imm_out = 26'hx;
					func_out = insn[5:0];
					ALUOp = SUB;
					rsIn_regfile = rs_out;
					rtIn_regfile = rt_out;
					rdIn_regfile = rd_out;	
					imm_out_sx[31:0] = 32'hx;	
				end

				SUBU: begin
					rs_out = insn[25:21];
					rt_out = insn[20:16];
					rd_out = insn[15:11];
					sa_out = insn[10:6];
					imm_out = 26'hx;
					func_out = insn[5:0];
					ALUOp = SUBU;
					rsIn_regfile = rs_out;
					rtIn_regfile = rt_out;
					rdIn_regfile = rd_out;	
					imm_out_sx[31:0] = 32'hx;	
				end

				MUL_FUNC: begin
					opcode_out = MUL_OP;
					rs_out = insn[25:21];
					rt_out = insn[20:16];
					rd_out = insn[15:11];
					sa_out = 5'b0;
					imm_out = 26'hx;
					func_out = insn[5:0];
					ALUOp = MUL_FUNC;
					rsIn_regfile = rs_out;
					rtIn_regfile = rt_out;
					rdIn_regfile = rd_out;	
					imm_out_sx[31:0] = 32'hx;	
				end	

				MULT: begin
					rs_out = insn[25:21];
					rt_out = insn[20:16];
					rd_out = 5'b0;
					sa_out = 5'b0;
					imm_out = 26'hx;
					func_out = insn[5:0];
					ALUOp = MULT;
					rsIn_regfile = rs_out;
					rtIn_regfile = rt_out;
					rdIn_regfile = rd_out;	
					imm_out_sx[31:0] = 32'hx;	
				end

				MULTU: begin
					rs_out = insn[25:21];
					rt_out = insn[20:16];
					rd_out = 5'b0;
					sa_out = 5'b0;
					imm_out = 26'hx;
					func_out = insn[5:0];
					ALUOp = MULTU;
					rsIn_regfile = rs_out;
					rtIn_regfile = rt_out;
					rdIn_regfile = rd_out;	
					imm_out_sx[31:0] = 32'hx;	
				end

				DIV: begin
					rs_out = insn[25:21];
					rt_out = insn[20:16];
					rd_out = 5'b0;
					sa_out = 5'b0;
					imm_out = 26'hx;
					func_out = insn[5:0];
					ALUOp = DIV;
					rsIn_regfile = rs_out;
					rtIn_regfile = rt_out;
					rdIn_regfile = rd_out;	
					imm_out_sx[31:0] = 32'hx;	
				end

				DIVU: begin
					rs_out = insn[25:21];
					rt_out = insn[20:16];
					rd_out = 5'b0;
					sa_out = 5'b0;
					imm_out = 26'hx;
					func_out = insn[5:0];
					ALUOp = DIVU;
					rsIn_regfile = rs_out;
					rtIn_regfile = rt_out;
					rdIn_regfile = rd_out;	
					imm_out_sx[31:0] = 32'hx;	
				end

				MFHI: begin
					rs_out = 5'b0;
					rt_out = 5'b0;
					rd_out = insn[15:11];
					sa_out = 5'b0;
					imm_out = 26'hx;
					func_out = insn[5:0];
					ALUOp = MFHI;
					rsIn_regfile = rs_out;
					rtIn_regfile = rt_out;
					rdIn_regfile = rd_out;	
					imm_out_sx[31:0] = 32'hx;	
				end

				MFLO: begin
					rs_out = 5'b0;
					rt_out = 5'b0;
					rd_out = insn[15:11];
					sa_out = 5'b0;
					imm_out = 26'hx;
					func_out = insn[5:0];
					ALUOp = MFLO;
					rsIn_regfile = rs_out;
					rtIn_regfile = rt_out;
					rdIn_regfile = rd_out;	
					imm_out_sx[31:0] = 32'hx;	
				end

				SLT: begin
					rs_out = insn[25:21];
					rt_out = insn[20:16];
					rd_out = insn[15:11];
					sa_out = 5'b0;
					imm_out = 26'hx;
					func_out = insn[5:0];
					ALUOp = SLT;
					rsIn_regfile = rs_out;
					rtIn_regfile = rt_out;
					rdIn_regfile = rd_out;	
					imm_out_sx[31:0] = 32'hx;	
				end

				SLTU: begin
					rs_out = insn[25:21];
					rt_out = insn[20:16];
					rd_out = insn[15:11];
					sa_out = 5'b0;
					imm_out = 26'hx;
					func_out = insn[5:0];
					ALUOp = SLTU;
					rsIn_regfile = rs_out;
					rtIn_regfile = rt_out;
					rdIn_regfile = rd_out;	
					imm_out_sx[31:0] = 32'hx;	
				end

				SLL: begin
					rs_out = 5'b0;
					rt_out = insn[20:16];
					rd_out = insn[15:11];
					sa_out = insn[15:6];
					imm_out = 26'hx;
					func_out = insn[5:0];
					ALUOp = SLL;
					rsIn_regfile = rs_out;
					rtIn_regfile = rt_out;
					rdIn_regfile = rd_out;	
					imm_out_sx[31:0] = 32'hx;	
				end

				SLLV: begin
					rs_out = insn[25:21];
					rt_out = insn[20:16];
					rd_out = insn[15:11];
					sa_out = 5'b0;
					imm_out = 26'hx;
					func_out = insn[5:0];
					ALUOp = SLLV;
					rsIn_regfile = rs_out;
					rtIn_regfile = rt_out;
					rdIn_regfile = rd_out;	
					imm_out_sx[31:0] = 32'hx;	
				end

				SRL: begin
					rs_out = 5'b0;
					rt_out = insn[20:16];
					rd_out = insn[15:11];
					sa_out = insn[10:6];
					imm_out = 26'hx;
					func_out = insn[5:0];
					ALUOp = SRL;
					rsIn_regfile = rs_out;
					rtIn_regfile = rt_out;
					rdIn_regfile = rd_out;	
					imm_out_sx[31:0] = 32'hx;	
				end

				SRLV: begin
					rs_out = insn[25:21];
					rt_out = insn[20:16];
					rd_out = insn[15:11];
					sa_out = 5'b0;
					imm_out = 26'hx;
					func_out = insn[5:0];
					ALUOp = SRLV;
					rsIn_regfile = rs_out;
					rtIn_regfile = rt_out;
					rdIn_regfile = rd_out;	
					imm_out_sx[31:0] = 32'hx;	
				end

				SRA: begin
					rs_out = 5'b0;
					rt_out = insn[20:16];
					rd_out = insn[15:11];
					sa_out = insn[10:6];
					imm_out = 26'hx;
					func_out = insn[5:0];
					ALUOp = SRA;
					rsIn_regfile = rs_out;
					rtIn_regfile = rt_out;
					rdIn_regfile = rd_out;	
					imm_out_sx[31:0] = 32'hx;	
				end

				SRAV: begin
					rs_out = insn[25:21];
					rt_out = insn[20:16];
					rd_out = insn[15:11];
					sa_out = 5'b0;
					imm_out = 26'hx;
					func_out = insn[5:0];
					ALUOp = SRAV;
					rsIn_regfile = rs_out;
					rtIn_regfile = rt_out;
					rdIn_regfile = rd_out;	
					imm_out_sx[31:0] = 32'hx;	
				end

				AND: begin
					rs_out = insn[25:21];
					rt_out = insn[20:16];
					rd_out = insn[15:11];
					sa_out = 5'b0;
					imm_out = 26'hx;
					func_out = insn[5:0];
					ALUOp = AND;
					rsIn_regfile = rs_out;
					rtIn_regfile = rt_out;
					rdIn_regfile = rd_out;	
					imm_out_sx[31:0] = 32'hx;	
				end

				OR: begin
					rs_out = insn[25:21];
					rt_out = insn[20:16];
					rd_out = insn[15:11];
					sa_out = 5'b0;
					imm_out = 26'hx;
					func_out = insn[5:0];
					ALUOp = OR;
					rsIn_regfile = rs_out;
					rtIn_regfile = rt_out;
					rdIn_regfile = rd_out;	
					imm_out_sx[31:0] = 32'hx;	
				end

				NOR: begin
					rs_out = insn[25:21];
					rt_out = insn[20:16];
					rd_out = insn[15:11];
					sa_out = 5'b0;
					imm_out = 26'hx;
					func_out = insn[5:0];
					ALUOp = NOR;
					rsIn_regfile = rs_out;
					rtIn_regfile = rt_out;
					rdIn_regfile = rd_out;	
					imm_out_sx[31:0] = 32'hx;	
				end

				JALR: begin
					rs_out = insn[25:21];
					rt_out = insn[20:16];
					rd_out = insn[15:11];
					sa_out = 5'b0;
					imm_out = 26'hx;
					func_out = insn[5:0];
					ALUOp = JALR;
					rsIn_regfile = rs_out;
					rtIn_regfile = rt_out;
					rdIn_regfile = rd_out;	
					imm_out_sx[31:0] = 32'hx;	
				end

				JR: begin
					rs_out = insn[25:21];
					rt_out = 5'b0;
					rd_out = 5'b0;
					sa_out = 5'b0;
					imm_out = 26'hx;
					func_out = insn[5:0];
					ALUOp = JR;
					rsIn_regfile = rs_out;
					rtIn_regfile = rt_out;
					rdIn_regfile = rd_out;	
					imm_out_sx[31:0] = 32'hx;	
				end
			endcase
		end else if (insn[31:26] != 6'b000000 && insn[31:27] != 5'b00001 && insn[31:26] != 6'b000001) begin
			// Instruction is I-Type
			// Further need to classify function (addiu, diviu, etc...)
			case (insn[31:26])
				ADDI: begin
					opcode_out = ADDI;		
					rs_out = insn[25:21];
					rt_out = insn[20:16];
					rd_out = rt_out;
					sa_out = 5'hx;
					imm_out[25:10] = insn[15:0];
					func_out = 6'hx;
					ALUOp = ADDI;
					rsIn_regfile = rs_out;
					rdIn_regfile = rt_out;
					imm_out_sx[31:0] = { { 16{ insn[15] } }, insn[15:0] };
				end

				ADDIU: begin
					opcode_out = ADDIU;
					rs_out = insn[25:21];
					rt_out = insn[20:16];
					rd_out = rt_out;
					sa_out = 5'hx;
					imm_out[25:10] = insn[15:0]; // Most significant 16-bits are immediate target
					func_out = 6'hx;
					ALUOp = ADDIU;
					rsIn_regfile = rs_out;
					rdIn_regfile = rt_out;
					imm_out_sx[31:0] = { { 16{ insn[15] } }, insn[15:0] };
				end

				SLTI: begin
					opcode_out = SLTI;
					rs_out = insn[25:21];
					rt_out = insn[20:16];
					rd_out = 5'hx;
					sa_out = 5'hx;
					imm_out[25:10] = insn[15:0]; // Most significant 16-bits are immediate target
					func_out = 6'hx;
					ALUOp = SLTI;
					rsIn_regfile = rs_out;
					rdIn_regfile = rt_out;
					imm_out_sx[31:0] <= { { 16{ insn[15] } }, insn[15:0] };
				end


				SLTIU: begin
					opcode_out = SLTIU;
					rs_out = insn[25:21];
					rt_out = insn[20:16];
					rd_out = 5'hx;
					sa_out = 5'hx;
					imm_out[25:10] = insn[15:0]; // Most significant 16-bits are immediate target
					func_out = 6'hx;
					ALUOp = SLTIU;
					rsIn_regfile = rs_out;
					rdIn_regfile = rt_out;
					imm_out_sx[31:0] <= { { 16{ insn[15] } }, insn[15:0] };
				end

				ORI: begin
					opcode_out = ORI;
					rs_out = insn[25:21];
					rt_out = insn[20:16];
					rd_out = 5'hx;
					sa_out = 5'hx;
					imm_out[25:10] = insn[15:0]; // Most significant 16-bits are immediate target
					func_out = 6'hx;
					ALUOp = ORI;
					rsIn_regfile = rs_out;
					rdIn_regfile = rt_out;
					imm_out_sx[31:0] <= { { 16{ insn[15] } }, insn[15:0] };
				end

				XORI: begin
					opcode_out = XORI;
					rs_out = insn[25:21];		
					rt_out = insn[20:16];	
					rd_out = 5'hx;	
					sa_out = 5'hx;
					imm_out[25:10] = insn[15:0];   // Most significant 16-bits are immediate target
					func_out = 6'hx;
					ALUOp = XORI;
					rsIn_regfile = rs_out;
					rdIn_regfile = rt_out;
					imm_out_sx[31:0] <= { { 16{ insn[15] } }, insn[15:0] };
				end

				LW: begin
					opcode_out = LW;
					rs_out = insn[25:21];		// BASE
					rt_out = insn[20:16];		// RT
					rd_out = 5'hx;
					sa_out = 5'hx;
					imm_out[25:10] = insn[15:0];    // OFFSET
					func_out = 6'hx;
					ALUOp = LW;
					rsIn_regfile = rs_out;
					rdIn_regfile = rt_out;
					imm_out_sx[31:0] <= { { 16{ insn[15] } }, insn[15:0] };
				end

				SW: begin
					opcode_out = SW;
					rs_out = insn[25:21];		// BASE
					rt_out = insn[20:16];		// RT
					rd_out = 5'hx;
					sa_out = 5'hx;
					imm_out[25:10] = insn[15:0];    // OFFSET
					func_out = 6'hx;
					ALUOp = SW;
					rsIn_regfile = rs_out;
					rdIn_regfile = rt_out;
					imm_out_sx[31:0] <= { { 16{ insn[15] } }, insn[15:0] };
				end

				LB: begin
					opcode_out = LB;
					rs_out = insn[25:21];		
					rt_out = insn[20:16];	
					rd_out = 5'hx;
					sa_out = 5'hx;	
					imm_out[25:10] = insn[15:0]; 
					func_out = 6'hx;
					ALUOp = LB;
					rsIn_regfile = rs_out;
					rdIn_regfile = rt_out;
					imm_out_sx[31:0] <= { { 16{ insn[15] } }, insn[15:0] };
				end

				LUI: begin
					opcode_out = LUI;
					rs_out = 5'b00000;		
					rt_out = insn[20:16];	
					rd_out = 5'hx;
					sa_out = 5'hx;	
					imm_out[25:10] = insn[15:0]; 
					func_out = 6'hx;
					ALUOp = LUI;
					rsIn_regfile = rs_out;
					rdIn_regfile = rt_out;
					imm_out_sx[31:0] <= { { 16{ insn[15] } }, insn[15:0] };
				end

				SB: begin
					opcode_out = SB;
					rs_out = insn[25:21];		
					rt_out = insn[20:16];	
					rd_out = 5'hx;
					sa_out = 5'hx;	
					imm_out[25:10] = insn[15:0]; 
					func_out = 6'hx;
					ALUOp = SB;
					rsIn_regfile = rs_out;
					rdIn_regfile = rt_out;
					imm_out_sx[31:0] <= { { 16{ insn[15] } }, insn[15:0] };
				end

				LBU: begin
					opcode_out = LBU;
					rs_out = insn[25:21];		
					rt_out = insn[20:16];	
					rd_out = 5'hx;
					sa_out = 5'hx;	
					imm_out[25:10] = insn[15:0]; 
					func_out = 6'hx;
					ALUOp = LBU;
					rsIn_regfile = rs_out;
					rdIn_regfile = rt_out;
					imm_out_sx[31:0] <= { { 16{ insn[15] } }, insn[15:0] };
				end

				BEQ: begin
					opcode_out = BEQ;
					rs_out = insn[25:21];		
					rt_out = insn[20:16];	
					rd_out = 5'hx;
					sa_out = 5'hx;	
					imm_out[25:10] = insn[15:0]; 
					func_out = 6'hx;  
					ALUOp = BEQ;
					rsIn_regfile = rs_out;
					rdIn_regfile = rt_out;
					imm_out_sx[31:0] <= { { 16{ insn[15] } }, insn[15:0] };
				end

				BNE: begin
					opcode_out = BNE;
					rs_out = insn[25:21];		
					rt_out = insn[20:16];	
					rd_out = 5'hx;
					sa_out = 5'hx;	
					imm_out[25:10] = insn[15:0]; 
					func_out = 6'hx; 
					ALUOp = BNE;
					rsIn_regfile = rs_out;
					rdIn_regfile = rt_out;
					imm_out_sx[31:0] <= { { 16{ insn[15] } }, insn[15:0] };
				end

				BGTZ: begin
					opcode_out = BGTZ;
					rs_out = insn[25:21];		
					rt_out = insn[20:16];	
					rd_out = 5'hx;
					sa_out = 5'hx;	
					imm_out[25:10] = insn[15:0]; 
					func_out = 6'hx;
					ALUOp = BGTZ;
					rsIn_regfile = rs_out;
					rdIn_regfile = rt_out;
					imm_out_sx[31:0] <= { { 16{ insn[15] } }, insn[15:0] };
				end

				BLEZ: begin
					opcode_out = BLEZ;
					rs_out = insn[25:21];
					rt_out = insn[20:16];
					rd_out = 5'hx;
					sa_out = 5'hx;
					imm_out[25:10] = insn[15:0];
					func_out = 6'hx;
					ALUOp = BLEZ;
					rsIn_regfile = rs_out;
					rdIn_regfile = rt_out;
					imm_out_sx[31:0] <= { { 16{ insn[15] } }, insn[15:0] };
				end
	
			endcase
		end else if (insn[31:6] == 6'b000001) begin
			// REGIMM
			case (insn[20:16])
				BLTZ: begin
					opcode_out = BLTZ;
					rs_out = insn[25:21];
					rt_out = insn[20:16];
					rd_out = 5'hx;
					sa_out = 5'hx;
					imm_out[25:10] = insn[15:0];
					func_out = 6'hx;
					ALUOp = BLTZ;
					rsIn_regfile = rs_out;
					rdIn_regfile = rt_out;
					imm_out_sx[31:0] <= { { 16{ insn[15] } }, insn[15:0] };
				end

				BGEZ: begin
					opcode_out = BGEZ;
					rs_out = insn[25:21];
					rt_out = insn[20:16];
					rd_out = 5'hx;
					sa_out = 5'hx;
					imm_out[25:10] = insn[15:0];
					func_out = 6'hx;
					ALUOp = BGEZ;
					rsIn_regfile = rs_out;
					rdIn_regfile = rt_out;
					imm_out_sx[31:0] <= { { 16{ insn[15] } }, insn[15:0] };
				end
			endcase
		end else if (insn[31:27] == 5'b00001) begin
			// Instruction is J-Type
			case (insn[31:26])
				J: begin
					opcode_out = J;
					rs_out = 5'hx;
					rt_out = 5'hx;
					rd_out = 5'hx;
					sa_out = 5'hx;
					imm_out[25:0] = insn[25:0];
					func_out = 6'hx;
					ALUOp = J;
					rsIn_regfile = imm_out;
					rtIn_regfile = rt_out;
					rdIn_regfile = rd_out;
					imm_out_sx[31:0] <= { {6{1'b0}}, insn[25:0] };		
				end

				JAL: begin
					opcode_out = JAL;
					rs_out = 5'hx;
					rt_out = 5'hx;
					rd_out = 5'hx;
					sa_out = 5'hx;
					imm_out[25:0] = insn[25:0];
					func_out = 6'hx;
					ALUOp = JAL;
					rsIn_regfile = imm_out;
					rtIn_regfile = rt_out;
					rdIn_regfile = rd_out;
					imm_out_sx[31:0] <= { {6{1'b0}}, insn[25:0] };	
				end
			endcase
		end else if (insn[31:0] == 32'h00000000) begin
				opcode_out = NOP;
				rs_out = 5'b00000;
				rt_out = 5'b00000;
				rd_out = 5'b00000;
				sa_out = 5'b00000;
				imm_out = 26'hx;
				func_out = 6'b000000;
				ALUOp = NOP;
		end
	end
end

// Clocked write of writeback data
always @(posedge clock)
begin: REG_WRITE
	if (we_regfile == 1) begin
		REGFILE [rdIn] = dVal_regfile;
	end
end 

endmodule
