module alu(clock, pc, insn, rsData, rtData, ALUOp, imm, dataOut);
	
input clock;
input [31:0] pc, insn, rsData, rtData, imm;
input [5:0] ALUOp;
output reg [31:0] dataOut;

// TODO: Add all the other insns
parameter ADD 6'b000001;
parameter ADDU    6'b000010;
parameter SUB 6'b000011;
parameter SUBU    6'b000100;
parameter MULT    6'b000101;
parameter MULTU   6'b000110;
parameter DIV 6'b000111;
parameter DIVU    6'b001000;
parameter MFHI    6'b001001;
parameter MFLO    6'b001010;
parameter SLT 6'b001011;
parameter SLTU    6'b001100;
parameter SLL 6'b001101;
parameter SLLV    6'b001110;
parameter SRL 6'b001111;
parameter SRLV    6'b010000;
parameter SRA 6'b010001;
parameter SRAV    6'b010010;
parameter AND 6'b010011;
parameter OR  6'b010100;
parameter XOR 6'b010101;
parameter NOR 6'b010110;
parameter JALR    6'b010111;
parameter JR  6'b011000; 
parameter MUL     6'b011001;

// I-Type
parameter ADDI    6'b011010;
parameter ADDIU   6'b011011;
parameter SLTI    6'b011100;
parameter SLTIU   6'b011101;
parameter ORI 6'b011110;
parameter XORI    6'b011111;
parameter LW  6'b100000;
parameter SW  6'b100001;
parameter LB  6'b100010;
parameter LUI 6'b100011;
parameter SB  6'b100100;
parameter LBU 6'b100101; 
parameter BEQ 6'b100110; 
parameter BNE 6'b100111; 
parameter BGTZ    6'b101000; 

// J-Type
parameter J   6'b101001;
parameter JAL 6'b101010;

parameter MUL_OP   6'b011100;  //MUL OPCODE
parameter MUL_FUNC 6'b000010;  //MUL FUNCTION CODE

parameter NOP 6'b101011;

parameter RTYPE = 6'b000000; //R-Type INSN

always @(posedge clock)
begin : EXECUTE
	if(insn[31:26] == RTYPE) begin
		case (ALUOp[5:0])
			ADD: begin
				dataOut = rsData + rtData;
			end
		endcase
	end
end
	
endmodule
