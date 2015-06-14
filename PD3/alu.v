module alu(clock, pc, insn, rsData, rtData, ALUOp, imm, dataOut);
	
input clock;
input [31:0] pc, insn, rsData, rtData, imm;
input [5:0] ALUOp;
output reg [31:0] dataOut;

// TODO: Add all the other insns
parameter ADD 	= 6'b000001; //ADD;
parameter ADDU 	= 6'b000010; //ADDU;

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