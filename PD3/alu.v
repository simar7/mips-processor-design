module alu(clock, pc, insn, rsData, rtData, saData, immData, immSXData, ALUOp, dataOut);
	
input clock;
input [31:0] pc, insn;
input [4:0] rsData, rtData, saData;
input [25:0] immData;
input [31:0] immSXData;
input [5:0] ALUOp;

output reg [31:0] dataOut;

// R-Type FUNC Codes
parameter ADD 	= 6'b100000; //ADD;
parameter ADDU 	= 6'b100001; //ADDU;
parameter SUB	= 6'b100010; //SUB;
parameter SUBU	= 6'b100011; //SUBU;	
parameter MULT	= 6'b011000; //MULT;		--
parameter MULTU = 6'b011001; //MULTU;		--
parameter DIV	= 6'b011010; //DIV;		--
parameter DIVU 	= 6'b011011; //DIVU;		--
parameter MFHI	= 6'b010000; //MFHI;		--
parameter MFLO 	= 6'b010010; //MFLO;		--
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
parameter JALR	= 6'b001001; //JALR;		--
parameter JR	= 6'b001000; //JR;		--

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
parameter BLEZ	= 6'b000110; //BLEZ

parameter BLTZ = 6'bx; // TODO: implement this, uses some REGIMM opcode
parameter BGEZ = 6'bx; // TODO: 

// J-Type Opcodes
parameter J     = 6'b000010;
parameter JAL	= 6'b000011;

parameter NOP   = 6'b000000;

parameter RTYPE = 6'b000000; //R-Type INSN

always @(posedge clock)
begin : EXECUTE
	if(insn[31:26] == RTYPE) begin
		case (ALUOp[5:0])
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
		endcase
	end else if (insn[31:26] != 6'b000000 && insn[31:27] != 5'b00001) begin
		case (ALUOp[5:0])
			ADDI: begin
				dataOut = rsData + immData[25:10];
			end

			ADDIU: begin
				dataOut = rsData + immData[25:10];

			end

			SLTI: begin
				if (rsData < immData[25:10]) begin
					dataOut = 32'h00000001;
				end else begin
					dataOut = 32'h00000000;
				end
			end

			SLTIU: begin
				if (rsData < immData[25:10]) begin
					dataOut = 32'h00000001;
				end else begin
					dataOut = 32'h00000000;
				end	
			end

			ORI: begin
				dataOut = rsData | immData[25:10];
			end

			XORI: begin
				dataOut = rsData ^ immData[25:10];
			end

			LW: begin
				dataOut = rsData + immData[25:10];
			end

			SW: begin
				dataOut = rsData + immData[25:10];
			end

			LB: begin
				dataOut = rsData + immData[25:10];
			end
		
			LUI: begin
				dataOut = immData[25:10] << 16;
			end

			SB: begin
				dataOut = rsData + immData[25:10];
			end
			
			LBU: begin
				dataOut = rsData + immData[25:10];
			end

			BEQ: begin
		        	if (rsData == rtData) begin
		        		dataOut = $signed(pc) + $signed(immData[25:10] << 2);
				end
			end

			BNE: begin
				if (rsData != rtData) begin
					dataOut = $signed(pc) + $signed(immData[25:10] << 2);
				end
			end

			BGTZ: begin
				if (rsData > 0) begin
					dataOut = $signed(pc) + $signed(immData[25:10] << 2);
				end
			end

			BLEZ: begin
				if (rsData <= 0) begin
					dataOut = $signed(pc) + $signed(immData[25:10] << 2);
				end
			end
		endcase
	end			
end
	
endmodule
