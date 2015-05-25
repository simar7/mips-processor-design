module decode(clock, insn, pc);

// Input ports
input clock;
input [31:0] insn;
input [31:0] pc;

// Registers
reg [31:0] pc_reg;


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

	

endmodule
