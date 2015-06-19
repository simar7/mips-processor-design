module alu(clock, pc, insn, rsData, rtData, saData, immSXData, ALUOp, dataOut, branch_taken, enable_execute);

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
parameter NOP   = 32'h000000;
parameter RTYPE = 6'b000000;
/******************************************/

input clock;
input [31:0] pc, insn, rsData, rtData;
input [4:0]  saData;
input [31:0] immSXData;
input [5:0]  ALUOp;
input wire enable_execute;

reg [63:0] temp;
reg [31:0] hi;
reg [31:0] lo;

output reg [31:0] dataOut;
output reg branch_taken;

always @(ALUOp, rsData, rtData)
begin : EXECUTE
	branch_taken = 0;
//if (enable_execute) begin
	if(insn[31:26] == RTYPE) begin
		case (ALUOp)
			ADD: begin
				dataOut = rsData + rtData;
			end
			
			ADDU: begin
				dataOut = rsData + rtData;
			end

			SUB: begin
				dataOut = rsData - rtData;
			end

			SUBU: begin
				dataOut = rsData - rtData;
			end

			MUL_FUNC: begin
				temp = rsData * rtData;
				dataOut = temp[31:0];
			end

			DIV: begin
				temp = rsData / rtData;
				hi = temp[63:32];	// remainder
				lo = temp[31:0];	// quotient
			end

			DIVU: begin
				temp = rsData / rtData;
				hi = temp[63:32];	// remainder
				lo = temp[31:0];	// quotient
			end

			MFHI: begin
				dataOut = hi;
			end

			MFLO: begin
				dataOut = lo;
			end

			SLT: begin
				if (rsData < rtData) begin
					dataOut = 32'h00000001;
				end else begin
					dataOut = 32'h00000000;
				end
			end

			SLTU: begin
				if (rsData < rtData) begin
					dataOut = 32'h00000001;
				end else begin
					dataOut = 32'h00000000;
				end
			end

			SLL: begin
				dataOut = rtData << saData;
			end

			SLLV: begin
				dataOut = rtData << rsData;
			end

			SRL: begin
				dataOut = rtData >> saData;
			end

			SRLV: begin
				dataOut = rtData >> rsData;
			end

			SRA: begin
				dataOut = rtData >>> saData;
			end

			SRAV: begin
				dataOut = rtData >>> rsData;
			end

			AND: begin
				dataOut = rsData & rtData;
			end

			OR: begin
				dataOut = rsData | rtData;
			end

			XOR: begin
				dataOut = rsData ^ rtData;
			end

			NOR: begin
				dataOut = ~(rsData | rtData);
			end
			
			JR: begin
				dataOut = rsData;
				branch_taken = 1;
			end

			JALR: begin
				dataOut = (pc + 8);
				//pc_out_execute = rsData
				branch_taken = 1;
			end
		endcase
	end else if (insn[31:26] != 6'b000000 && insn[31:27] != 5'b00001 && insn[31:26] != 6'b000001) begin
		case (ALUOp)
			ADDI: begin
				dataOut = rsData + immSXData[15:0];
			end

			ADDIU: begin
				dataOut = rsData + immSXData[15:0];

			end

			SLTI: begin
				if (rsData < immSXData[15:0]) begin
					dataOut = 32'h00000001;
				end else begin
					dataOut = 32'h00000000;
				end
			end

			SLTIU: begin
				if (rsData < immSXData[15:0]) begin
					dataOut = 32'h00000001;
				end else begin
					dataOut = 32'h00000000;
				end	
			end

			ORI: begin
				dataOut = rsData | immSXData[15:0];
			end

			XORI: begin
				dataOut = rsData ^ immSXData[15:0];
			end

			LW: begin
				dataOut = rsData + immSXData[15:0];
			end

			SW: begin
				dataOut = rsData + immSXData[15:0];
			end

			LB: begin
				dataOut = rsData + immSXData[15:0];
			end
		
			LUI: begin
				//dataOut = immSXData[15:0] << 16;
				dataOut = {immSXData[15:0], 16'd0};
			end

			SB: begin
				dataOut = rsData + immSXData[15:0];
			end
			
			LBU: begin
				dataOut = rsData + immSXData[15:0];
			end

			BEQ: begin
		        	if (rsData == rtData) begin
		        		dataOut = pc + (immSXData[15:0] << 2);
					branch_taken = 1;
				end else begin
					branch_taken = 0;
				end
			end

			BNE: begin
				if (rsData != rtData) begin
					dataOut = pc + (immSXData[15:0] << 2);
					branch_taken = 1;
				end else begin
					branch_taken = 0;
				end
			end

			BGTZ: begin
				if (rsData > 0) begin
					dataOut = pc + (immSXData[15:0] << 2);
					branch_taken = 1;
				end else begin
					branch_taken = 0;
				end
			end

			BLEZ: begin
				if (rsData <= 0) begin
					dataOut = pc + (immSXData[15:0] << 2);
					branch_taken = 1;
				end else begin
					branch_taken = 0;
				end
			end
		endcase
	end else if (insn[31:26] == 6'b000001) begin
		// REGIMM
		case(ALUOp)
			BLTZ: begin
				if (rsData < 0) begin
					dataOut = pc + (immSXData[15:0] << 2);
					branch_taken = 1;
				end else begin
					branch_taken = 0;
				end
			end

			BGEZ: begin
				if (rsData >= 0) begin
			        	dataOut = pc + (immSXData[15:0] << 2);
					branch_taken = 1;
				end else begin
					branch_taken = 0;
				end
			end
		endcase
	end else if (insn[31:27] == 5'b00001) begin
		// J-Type
		case (ALUOp)
			J: begin
				// 
				dataOut[31:28] = pc[31:28];
				dataOut[27:0] = immSXData[25:0] << 2;
				branch_taken = 1;
			end

			JAL: begin
				dataOut = pc + 8;
				branch_taken = 1;
			end
		endcase
	end else if (insn == NOP) begin
		dataOut = dataOut;
	end
end
//end
	
endmodule
