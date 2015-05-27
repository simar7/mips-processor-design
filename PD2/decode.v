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

parameter ADD 	= 100000; //ADD;
parameter ADDU 	= 6'b100001; //ADDU;
parameter SUB	= 100010; //SUB;
parameter SUBU	= 100011; //SUBU;
parameter MULT	= 011000; //MULT;
parameter MULTU = 011001; //MULTU;
parameter DIV	= 011010; //DIV;
parameter DIVU 	= 011011; //DIVU;
parameter MFHI	= 010000; //MFHI;
parameter MFLO 	= 010010; //MFLO;
parameter SLT	= 101010; //SLT;
parameter SLTU	= 101011; //SLTU;
parameter SLL	= 000000; //SLL;
parameter SLLV	= 000100; //SLLV;
parameter SRL	= 000010; //SRL;
parameter SRLV	= 000110; //SRLV;
parameter SRA	= 000011; //SRA;
parameter SRAV	= 000111; //SRAV;
parameter AND	= 100100; //AND;
parameter OR	= 100101; //OR;
parameter XOR	= 100110; //XOR;
parameter NOR	= 100111; //NOR
parameter JALR	= 001001; //JALR;
parameter JR	= 001000; //JR;

/*

			6'b001001: //ADDIU
			6'b001010: //SLTI
			6'b001011: //SLTIU
			6'b001101: //ORI
			6'b001110: //XORI
			6'b100011: //LW
			6'b101011: //SW
			6'b100000: //LB
			6'b101000: //SB
			6'b100100: //LBU
			6'b000100: //BEQ
			6'b000101: //BNE
			6'b000111: //BGTZ
*/

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
	
				MULT: begin
					opcode_out = RTYPE;
					rs_out = insn[25:21];
					rt_out = insn[20:16];
					rd_out = 00000;
					sa_out = 00000;
					func_out = insn[5:0];
				end
			endcase
		end
	end
end

endmodule
