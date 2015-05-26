module decode(clock, insn, pc);

// Input ports
input clock;
input [31:0] insn;
input [31:0] pc;

// Registers
reg [31:0] pc_reg;

// Output
output reg [31:0] decode_out;

output reg [5:0] opcode_out;
output reg [4:0] rs_out;
output reg [4:0] rt_out;
output reg [4:0] rd_out;
output reg [4:0] sa_out;
output reg [5:0] func_out;
output reg [15:0] imm_out;
output reg [25:0] target_out;

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

	if (insn[31:26] == 6'b000000) begin
		// Instruction is R-type
		// Further need to clasify function (add, sub, etc..)
		case (insn[5:0])
			6'b100000: //ADD;
			6'b100001: //ADDU;
			6'b100010: //SUB;
			6'b100011: //SUBU;
			6'b011000: //MULT;
			6'b011001: //MULTU;
			6'b011010: //DIV;
			6'b011011: //DIVU;
			6'b010000: //MFHI;
			6'b010010: //MFLO;
			6'b101010: //SLT;
			6'b101011: //SLTU;
			6'b000000: //SLL;
			6'b000100: //SLLV;
			6'b000010: //SRL;
			6'b000110: //SRLV;
			6'b000011: //SRA;
			6'b000111: //SRAV;
			6'b100100: //AND;
			6'b100101: //OR;
			6'b100110: //XOR;
			6'b100111: //NOR
			6'b001001: //JALR;
			6'b001000: //JR;
		endcase
	
	end else if (insn[31:26] != 6'b000000 || insn[31:27] != 5'b00001 || insn[31:28] != 4'b0100) begin
		// Instruction is I-Type
		case(insn[31:26])
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
		endcase
		
	end else if (insn[31:27] == 5'b00001) begin
		// Instruction is J-Type
		case(insn[26])
			0: //J;
			1: //JAL;
		endcase

	end else if (insn[31:0] == 32'h00000000) begin
		// NOP
	end
end

endmodule
