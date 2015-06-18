`ifndef _decode_opcode_vh
`define _decode_opcode_vh

// ALUOp Codes
// R-Type
`define ADD	6'b000001;
`define ADDU	6'b000010;
`define SUB	6'b000011;
`define SUBU	6'b000100;
`define MULT	6'b000101;
`define MULTU	6'b000110;
`define DIV	6'b000111;
`define DIVU	6'b001000;
`define MFHI	6'b001001;
`define MFLO 	6'b001010;
`define SLT	6'b001011;
`define SLTU	6'b001100;
`define SLL	6'b001101;
`define SLLV	6'b001110;
`define SRL	6'b001111;
`define SRLV	6'b010000;
`define SRA	6'b010001;
`define SRAV	6'b010010;
`define AND	6'b010011;
`define OR	6'b010100;
`define XOR	6'b010101;
`define NOR	6'b010110;
`define JALR	6'b010111;
`define JR	6'b011000; 
`define MUL 	6'b011001;

// I-Type
`define ADDI	6'b011010;
`define ADDIU	6'b011011;
`define SLTI	6'b011100;
`define SLTIU	6'b011101;
`define ORI	6'b011110;
`define XORI	6'b011111;
`define LW	6'b100000;
`define SW	6'b100001;
`define LB	6'b100010;
`define LUI	6'b100011;
`define SB	6'b100100;
`define LBU	6'b100101; 
`define BEQ	6'b100110; 
`define BNE	6'b100111; 
`define BGTZ	6'b101000; 

// J-Type
`define J	6'b101001;
`define JAL	6'b101010;

`define MUL_OP   6'b011100;  //MUL OPCODE
`define MUL_FUNC 6'b000010;  //MUL FUNCTION CODE

`define NOP	6'b101011;

`endif