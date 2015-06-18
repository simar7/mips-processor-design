module decode(clock, insn, pc, opcode_out, rs_out, rt_out, rd_out,
	sa_out, func_out, imm_out, enable_decode, pc_out,
	insn_out, ALUOp, rsOut_regfile, rtOut_regfile, dVal_regfile, we_regfile);

// Control Registers
output reg [5:0] ALUOp;

// Input ports
input wire clock;
input wire [31:0] insn;
input wire [31:0] pc;
input wire enable_decode;

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
					imm_out = 26'bxxxxxxxxxxxxxxxxxxxxxxxxxx;
					func_out = insn[5:0];
					ALUOp = func_out;
					rsIn_regfile = rs_out;
					rtIn_regfile = rt_out;
					rdIn_regfile = rd_out;					
				end

				ADDU: begin
					rs_out = insn[25:21];
					rt_out = insn[20:16];
					rd_out = insn[15:11];
					sa_out = insn[10:6];
					imm_out = 26'bxxxxxxxxxxxxxxxxxxxxxxxxxx;
					func_out = insn[5:0];	
					ALUOp = func_out;
				end

				SUB: begin
					rs_out = insn[25:21];
					rt_out = insn[20:16];
					rd_out = insn[15:11];
					sa_out = insn[10:6];
					imm_out = 26'bxxxxxxxxxxxxxxxxxxxxxxxxxx;
					func_out = insn[5:0];
					ALUOp = func_out;
				end

				SUBU: begin
					rs_out = insn[25:21];
					rt_out = insn[20:16];
					rd_out = insn[15:11];
					sa_out = insn[10:6];
					imm_out = 26'bxxxxxxxxxxxxxxxxxxxxxxxxxx;
					func_out = insn[5:0];
					ALUOp = func_out;
				end

				MUL_FUNC: begin
					opcode_out = MUL_OP;
					rs_out = insn[25:21];
					rt_out = insn[20:16];
					rd_out = insn[15:11];
					sa_out = 00000;
					imm_out = 26'bxxxxxxxxxxxxxxxxxxxxxxxxxx;
					func_out = insn[5:0];
					ALUOp = func_out;
				end	

				MULT: begin
					rs_out = insn[25:21];
					rt_out = insn[20:16];
					rd_out = 00000;
					sa_out = 00000;
					imm_out = 26'bxxxxxxxxxxxxxxxxxxxxxxxxxx;
					func_out = insn[5:0];
					ALUOp = func_out;
				end

				MULTU: begin
					rs_out = insn[25:21];
					rt_out = insn[20:16];
					rd_out = 00000;
					sa_out = 00000;
					imm_out = 26'bxxxxxxxxxxxxxxxxxxxxxxxxxx;
					func_out = insn[5:0];
					ALUOp = func_out;
				end

				DIV: begin
					rs_out = insn[25:21];
					rt_out = insn[20:16];
					rd_out = 00000;
					sa_out = 00000;
					imm_out = 26'bxxxxxxxxxxxxxxxxxxxxxxxxxx;
					func_out = insn[5:0];
					ALUOp = func_out;
				end

				DIVU: begin
					rs_out = insn[25:21];
					rt_out = insn[20:16];
					rd_out = 00000;
					sa_out = 00000;
					imm_out = 26'bxxxxxxxxxxxxxxxxxxxxxxxxxx;
					func_out = insn[5:0];
					ALUOp = func_out;
				end

				MFHI: begin
					rs_out = 00000;
					rt_out = 00000;
					rd_out = insn[15:11];
					sa_out = 00000;
					imm_out = 26'bxxxxxxxxxxxxxxxxxxxxxxxxxx;
					func_out = insn[5:0];
					ALUOp = func_out;
				end

				MFLO: begin
					rs_out = 00000;
					rt_out = 00000;
					rd_out = insn[15:11];
					sa_out = 00000;
					imm_out = 26'bxxxxxxxxxxxxxxxxxxxxxxxxxx;
					func_out = insn[5:0];
					ALUOp = func_out;
				end

				SLT: begin
					rs_out = insn[25:21];
					rt_out = insn[20:16];
					rd_out = insn[15:11];
					sa_out = 00000;
					imm_out = 26'bxxxxxxxxxxxxxxxxxxxxxxxxxx;
					func_out = insn[5:0];
					ALUOp = func_out;
				end

				SLTU: begin
					rs_out = insn[25:21];
					rt_out = insn[20:16];
					rd_out = insn[15:11];
					sa_out = 00000;
					imm_out = 26'bxxxxxxxxxxxxxxxxxxxxxxxxxx;
					func_out = insn[5:0];
					ALUOp = func_out;
				end

				SLL: begin
					rs_out = 00000;
					rt_out = insn[20:16];
					rd_out = insn[15:11];
					sa_out = insn[15:6];
					imm_out = 26'bxxxxxxxxxxxxxxxxxxxxxxxxxx;
					func_out = insn[5:0];
					ALUOp = func_out;
				end

				SLLV: begin
					rs_out = insn[25:21];
					rt_out = insn[20:16];
					rd_out = insn[15:11];
					sa_out = 00000;
					imm_out = 26'bxxxxxxxxxxxxxxxxxxxxxxxxxx;
					func_out = insn[5:0];
					ALUOp = func_out;
				end

				SRL: begin
					rs_out = 00000;
					rt_out = insn[20:16];
					rd_out = insn[15:11];
					sa_out = insn[10:6];
					func_out = insn[5:0];
					ALUOp = func_out;
				end

				SRLV: begin
					rs_out = insn[25:21];
					rt_out = insn[20:16];
					rd_out = insn[15:11];
					sa_out = 00000;
					imm_out = 26'bxxxxxxxxxxxxxxxxxxxxxxxxxx;
					func_out = insn[5:0];
					ALUOp = func_out;
				end

				SRA: begin
					rs_out = 00000;
					rt_out = insn[20:16];
					rd_out = insn[15:11];
					sa_out = insn[10:6];
					imm_out = 26'bxxxxxxxxxxxxxxxxxxxxxxxxxx;
					func_out = insn[5:0];
					ALUOp = func_out;
				end

				SRAV: begin
					rs_out = insn[25:21];
					rt_out = insn[20:16];
					rd_out = insn[15:11];
					sa_out = 00000;
					imm_out = 26'bxxxxxxxxxxxxxxxxxxxxxxxxxx;
					func_out = insn[5:0];
					ALUOp = func_out;
				end

				AND: begin
					rs_out = insn[25:21];
					rt_out = insn[20:16];
					rd_out = insn[15:11];
					sa_out = 00000;
					imm_out = 26'bxxxxxxxxxxxxxxxxxxxxxxxxxx;
					func_out = insn[5:0];
					ALUOp = func_out;
				end

				OR: begin
					rs_out = insn[25:21];
					rt_out = insn[20:16];
					rd_out = insn[15:11];
					sa_out = 00000;
					imm_out = 26'bxxxxxxxxxxxxxxxxxxxxxxxxxx;
					func_out = insn[5:0];
					ALUOp = func_out;
				end

				NOR: begin
					rs_out = insn[25:21];
					rt_out = insn[20:16];
					rd_out = insn[15:11];
					sa_out = 00000;
					imm_out = 26'bxxxxxxxxxxxxxxxxxxxxxxxxxx;
					func_out = insn[5:0];
					ALUOp = func_out;
				end

				JALR: begin
					rs_out = insn[25:21];
					rt_out = insn[20:16];
					rd_out = insn[15:11];
					sa_out = 00000;
					imm_out = 26'bxxxxxxxxxxxxxxxxxxxxxxxxxx;
					func_out = insn[5:0];
					ALUOp = func_out;
				end

				JR: begin
					rs_out = insn[25:21];
					rt_out = 00000;
					rd_out = 00000;
					sa_out = 00000;
					imm_out = 26'bxxxxxxxxxxxxxxxxxxxxxxxxxx;
					func_out = insn[5:0];
					ALUOp = func_out;
				end
			endcase
		end else if (insn[31:26] != 6'b000000 && insn[31:27] != 5'b00001) begin
			// Instruction is I-Type
			// Further need to classify function (addiu, diviu, etc...)
			case (insn[31:26])
				ADDI: begin
					opcode_out = ADDI;		
					rs_out = insn[25:21];
					rt_out = insn[20:16];
					rd_out = 5'bxxxxx;
					sa_out = 5'bxxxxx;
					imm_out[25:10] = insn[15:0];
					func_out = 6'bxxxx;
					ALUOp = opcode_out;
					rsIn_regfile = rs_out;
					rdIn_regfile = rt_out;
				end

				ADDIU: begin
					opcode_out = ADDIU;
					rs_out = insn[25:21];
					rt_out = insn[20:16];
					rd_out = 5'bxxxxx;
					sa_out = 5'bxxxxx;
					imm_out[25:10] = insn[15:0]; // Most significant 16-bits are immediate target
					func_out = 6'bxxxxx;
					ALUOp = opcode_out;
					rsIn_regfile = rs_out;
					rdIn_regfile = rt_out;
				end

				SLTI: begin
					opcode_out = SLTI;
					rs_out = insn[25:21];
					rt_out = insn[20:16];
					rd_out = 5'bxxxxx;
					sa_out = 5'bxxxxx;
					imm_out[25:10] = insn[15:0]; // Most significant 16-bits are immediate target
					func_out = 6'bxxxxx;
					ALUOp = opcode_out;
					rsIn_regfile = rs_out;
					rdIn_regfile = rt_out;
				end


				SLTIU: begin
					opcode_out = SLTIU;
					rs_out = insn[25:21];
					rt_out = insn[20:16];
					rd_out = 5'bxxxxx;
					sa_out = 5'bxxxxx;
					imm_out[25:10] = insn[15:0]; // Most significant 16-bits are immediate target
					func_out = 6'bxxxxx;
					ALUOp = opcode_out;
					rsIn_regfile = rs_out;
					rdIn_regfile = rt_out;
				end

				ORI: begin
					opcode_out = ORI;
					rs_out = insn[25:21];
					rt_out = insn[20:16];
					rd_out = 5'bxxxxx;
					sa_out = 5'bxxxxx;
					imm_out[25:10] = insn[15:0]; // Most significant 16-bits are immediate target
					func_out = 6'bxxxxx;
					ALUOp = opcode_out;
					rsIn_regfile = rs_out;
					rdIn_regfile = rt_out;
				end

				XORI: begin
					opcode_out = XORI;
					rs_out = insn[25:21];		
					rt_out = insn[20:16];	
					rd_out = 5'bxxxxx;	
					sa_out = 5'bxxxxx;
					imm_out[25:10] = insn[15:0];   // Most significant 16-bits are immediate target
					func_out = 6'bxxxxx;
					ALUOp = opcode_out;
					rsIn_regfile = rs_out;
					rdIn_regfile = rt_out;
				end

				LW: begin
					opcode_out = LW;
					rs_out = insn[25:21];		// BASE
					rt_out = insn[20:16];		// RT
					rd_out = 5'bxxxxx;
					sa_out = 5'bxxxxx;
					imm_out[25:10] = insn[15:0];    // OFFSET
					func_out = 6'bxxxxx;
					ALUOp = opcode_out;
					rsIn_regfile = rs_out;
					rdIn_regfile = rt_out;
				end

				SW: begin
					opcode_out = SW;
					rs_out = insn[25:21];		// BASE
					rt_out = insn[20:16];		// RT
					rd_out = 5'bxxxxx;
					sa_out = 5'bxxxxx;
					imm_out[25:10] = insn[15:0];    // OFFSET
					func_out = 6'bxxxxx;
					ALUOp = opcode_out;
					rsIn_regfile = rs_out;
					rdIn_regfile = rt_out;
				end

				LB: begin
					opcode_out = LB;
					rs_out = insn[25:21];		
					rt_out = insn[20:16];	
					rd_out = 5'bxxxxx;
					sa_out = 5'bxxxxx;	
					imm_out[25:10] = insn[15:0]; 
					func_out = 6'bxxxxxx;
					ALUOp = opcode_out;
					rsIn_regfile = rs_out;
					rdIn_regfile = rt_out;
				end

				LUI: begin
					opcode_out = LUI;
					rs_out = 5'b00000;		
					rt_out = insn[20:16];	
					rd_out = 5'bxxxxx;
					sa_out = 5'bxxxxx;	
					imm_out[25:10] = insn[15:0]; 
					func_out = 6'bxxxxxx;
					ALUOp = opcode_out;
					rsIn_regfile = rs_out;
					rdIn_regfile = rt_out;
				end

				SB: begin
					opcode_out = SB;
					rs_out = insn[25:21];		
					rt_out = insn[20:16];	
					rd_out = 5'bxxxxx;
					sa_out = 5'bxxxxx;	
					imm_out[25:10] = insn[15:0]; 
					func_out = 6'bxxxxxx;
					ALUOp = opcode_out;
					rsIn_regfile = rs_out;
					rdIn_regfile = rt_out;
				end

				LBU: begin
					opcode_out = LBU;
					rs_out = insn[25:21];		
					rt_out = insn[20:16];	
					rd_out = 5'bxxxxx;
					sa_out = 5'bxxxxx;	
					imm_out[25:10] = insn[15:0]; 
					func_out = 6'bxxxxxx;
					ALUOp = opcode_out;
					rsIn_regfile = rs_out;
					rdIn_regfile = rt_out;
				end

				BEQ: begin
					opcode_out = BEQ;
					rs_out = insn[25:21];		
					rt_out = insn[20:16];	
					rd_out = 5'bxxxxx;
					sa_out = 5'bxxxxx;	
					imm_out[25:10] = insn[15:0]; 
					func_out = 6'bxxxxxx;  
					ALUOp = opcode_out;
					rsIn_regfile = rs_out;
					rdIn_regfile = rt_out;
				end

				BNE: begin
					opcode_out = BNE;
					rs_out = insn[25:21];		
					rt_out = insn[20:16];	
					rd_out = 5'bxxxxx;
					sa_out = 5'bxxxxx;	
					imm_out[25:10] = insn[15:0]; 
					func_out = 6'bxxxxxx; 
					ALUOp = opcode_out;
					rsIn_regfile = rs_out;
					rdIn_regfile = rt_out;
				end

				BGTZ: begin
					opcode_out = BGTZ;
					rs_out = insn[25:21];		
					rt_out = insn[20:16];	
					rd_out = 5'bxxxxx;
					sa_out = 5'bxxxxx;	
					imm_out[25:10] = insn[15:0]; 
					func_out = 6'bxxxxxx;
					ALUOp = opcode_out;
					rsIn_regfile = rs_out;
					rdIn_regfile = rt_out;
				end
			endcase
		end else if (insn[31:27] == 5'b00001) begin
			// Instruction is J-Type
			case (insn[31:26])
				J: begin
					opcode_out = J;
					rs_out = 5'bxxxxx;
					rt_out = 5'bxxxxx;
					rd_out = 5'bxxxxx;
					sa_out = 5'bxxxxx;
					imm_out[25:0] = insn[25:0];
					func_out = 6'bxxxxxx;
					ALUOp = opcode_out;
					rsIn_regfile = imm_out;
					rtIn_regfile = rt_out;
					rdIn_regfile = rd_out;		
				end

				JAL: begin
					opcode_out = JAL;
					rs_out = 5'bxxxxx;
					rt_out = 5'bxxxxx;
					rd_out = 5'bxxxxx;
					sa_out = 5'bxxxxx;
					imm_out[25:0] = insn[25:0];
					func_out = 6'bxxxxxx;
					ALUOp = opcode_out;
					rsIn_regfile = imm_out;
					rtIn_regfile = rt_out;
					rdIn_regfile = rd_out;	
				end
			endcase
		end else if (insn[31:0] == 32'h00000000) begin
				opcode_out = 6'b000000;
				rs_out = 5'b00000;
				rt_out = 5'b00000;
				rd_out = 5'b00000;
				sa_out = 5'b00000;
				imm_out = 26'bxxxxxxxxxxxxxxxxxxxxxxxxxx;
				func_out = 6'b000000;
				ALUOp = NOP;
		end
	end
end

// Clocked write of writeback data
always @(posedge clock)
begin: REG_WRITE
	if (we_regfile) begin
		REGFILE [rdIn_regfile] = dVal_regfile;
	end
end 

endmodule
