module decode(clock, insn, pc, opcode_out, rs_out, rt_out, rd_out, sa_out, func_out, enable_decode);

// Input ports
input clock;
input [31:0] insn;
input [31:0] pc;

input enable_decode;

// Registers
reg [31:0] pc_reg;

// Output
output reg [5:0] opcode_out;
output reg [4:0] rs_out;
output reg [4:0] rt_out;
output reg [4:0] rd_out;
output reg [4:0] sa_out;
output reg [5:0] func_out;
//output reg [15:0] imm_out;
//output reg [25:0] target_out;

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

parameter ADDIU = 6'b001001; //ADDIU
parameter SLTI  = 6'b001010; //SLTI
parameter SLTIU = 6'b001011; //SLTIU
parameter ORI	= 6'b001101; //ORI
parameter XORI  = 6'b001110; //XORI
parameter LW	= 6'b100011; //LW
parameter SW	= 6'b101011; //SW
parameter LB	= 6'b100000; //LB
parameter SB	= 6'b101000; //SB
parameter LBU	= 6'b100100; //LBU
parameter BEQ	= 6'b000100; //BEQ
parameter BNE	= 6'b000101; //BNE
parameter BGTZ	= 6'b000111; //BGTZ

parameter RTYPE = 000000; //R-Type INSN

/*
  Instructions to support
 
1) add, addiu, addu, sub, subu
2) mult, multu, div, divu, mfhi, mflo
3) slt, slti, sltu, sltiu
4) sll, sllv, srl, srlv, sra, srav, and, or, ori, xor, xori, nor
5) lw, sw, li (ori, lui), lb, sb, lbu, move
6) j, jal, jalr, jr, beq, beqz, bne, bnez, bgez, bgtz, blez, bltz
7) nop

R-type insn: 
add, sub, addu, subu, mult, multu, div, divu, mfhi,
mflo, slt, sltu, sll, sllv, srl, srlv, sra, srav,
and, or, xor, nor, jalr, jr, nop

I-type insn:
addiu, slti, slti, sltiu, ori, xori

J-type insn:
j, jal, beq, beqz, bne, bnez, bgez, bgtz, blez, bltz

https://www.student.cs.uwaterloo.ca/~isg/res/mips/opcodes

*/

always @(posedge clock)
begin : DECODE

	if (enable_decode) begin
		if (insn[31:26] == RTYPE) begin
			// Instruction is R-type
			// Further need to clasify function (add, sub, etc..)
			case (insn[5:0])
				ADDU: begin
					opcode_out = RTYPE;
					rs_out = insn[25:21];
					rt_out = insn[20:16];
					rd_out = insn[15:11];
					sa_out = insn[10:6];
					func_out = insn[5:0];
				end

				ADDU: begin
					opcode_out = RTYPE;
					rs_out = insn[25:21];
					rt_out = insn[20:16];
					rd_out = insn[15:11];
					sa_out = insn[10:6];
					func_out = insn[5:0];
				end

				SUB: begin
					opcode_out = RTYPE;
					rs_out = insn[25:21];
					rt_out = insn[20:16];
					rd_out = insn[15:11];
					sa_out = insn[10:6];
					func_out = insn[5:0];
				end

				SUBU: begin
					opcode_out = RTYPE;
					rs_out = insn[25:21];
					rt_out = insn[20:16];
					rd_out = insn[15:11];
					sa_out = insn[10:6];
					func_out = insn[5:0];
				end
	
				MULT: begin
					opcode_out = RTYPE;
					rs_out = insn[25:21];
					rt_out = insn[20:16];
					rd_out = 00000;
					sa_out = 00000;
					func_out = insn[5:0];
				end

				MULTU: begin
					opcode_out = RTYPE;
					rs_out = insn[25:21];
					rt_out = insn[20:16];
					rd_out = 00000;
					sa_out = 00000;
					func_out = insn[5:0];
				end

				DIV: begin
					opcode_out = RTYPE;
					rs_out = insn[25:21];
					rt_out = insn[20:16];
					rd_out = 00000;
					sa_out = 00000;
					func_out = insn[5:0];
				end

				DIVU: begin
					opcode_out = RTYPE;
					rs_out = insn[25:21];
					rt_out = insn[20:16];
					rd_out = 00000;
					sa_out = 00000;
					func_out = insn[5:0];
				end

				MFHI: begin
					opcode_out = RTYPE;
					rs_out = 00000;
					rt_out = 00000;
					rd_out = insn[15:11];
					sa_out = 00000;
					func_out = insn[5:0];
				end

				MFLO: begin
					opcode_out = RTYPE;
					rs_out = 00000;
					rt_out = 00000;
					rd_out = insn[15:11];
					sa_out = 00000;
					func_out = insn[5:0];
				end

				SLT: begin
					opcode_out = RTYPE;
					rs_out = insn[25:21];
					rt_out = insn[20:16];
					rd_out = insn[15:11];
					sa_out = 00000;
					func_out = insn[5:0];
				end

				SLTU: begin
					opcode_out = RTYPE;
					rs_out = insn[25:21];
					rt_out = insn[20:16];
					rd_out = insn[15:11];
					sa_out = 00000;
					func_out = insn[5:0];
				end

				SLL: begin
					opcode_out = RTYPE;
					rs_out = 00000;
					rt_out = insn[20:16];
					rd_out = insn[15:11];
					sa_out = insn[15:6];
					func_out = insn[5:0];
				end

				SLLV: begin
					opcode_out = RTYPE;
					rs_out = insn[25:21];
					rt_out = insn[20:16];
					rd_out = insn[15:11];
					sa_out = 00000;
					func_out = insn[5:0];
				end

				SRL: begin
					opcode_out = RTYPE;
					rs_out = 00000;
					rt_out = insn[20:16];
					rd_out = insn[15:11];
					sa_out = insn[10:6];
					func_out = insn[5:0];
				end

				SRLV: begin
					opcode_out = RTYPE;
					rs_out = insn[25:21];
					rt_out = insn[20:16];
					rd_out = insn[15:11];
					sa_out = 00000;
					func_out = insn[5:0];
				end

				SRA: begin
					opcode_out = RTYPE;
					rs_out = 00000;
					rt_out = insn[20:16];
					rd_out = insn[15:11];
					sa_out = insn[10:6];
					func_out = insn[5:0];
				end

				SRAV: begin
					opcode_out = RTYPE;
					rs_out = insn[25:21];
					rt_out = insn[20:16];
					rd_out = insn[15:11];
					sa_out = 00000;
					func_out = insn[5:0];
				end

				AND: begin
					opcode_out = RTYPE;
					rs_out = insn[25:21];
					rt_out = insn[20:16];
					rd_out = insn[15:11];
					sa_out = 00000;
					func_out = insn[5:0];
				end

				OR: begin
					opcode_out = RTYPE;
					rs_out = insn[25:21];
					rt_out = insn[20:16];
					rd_out = insn[15:11];
					sa_out = 00000;
					func_out = insn[5:0];
				end

				NOR: begin
					opcode_out = RTYPE;
					rs_out = insn[25:21];
					rt_out = insn[20:16];
					rd_out = insn[15:11];
					sa_out = 00000;
					func_out = insn[5:0];
				end

				JALR: begin
					opcode_out = RTYPE;
					rs_out = insn[25:21];
					rt_out = insn[20:16];
					rd_out = insn[15:11];
					sa_out = 00000;
					func_out = insn[5:0];
				end
			endcase
		end
	end
end

endmodule
