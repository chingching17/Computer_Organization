/***************************************************
Student Name: 龔意文 施雅青
Student ID: 0816030 0816050
***************************************************/

`timescale 1ns/1ps

module ALU_Ctrl(
	input		[4-1:0]	instr,
	input		[2-1:0]	ALUOp,
	output wire	[4-1:0] ALU_Ctrl_o
	);

/* Write your code HERE */
assign ALU_Ctrl_o = (ALUOp == 2'b00)? 4'b0010:(				// Load, Store, Jump: lw, sw, JAL		--> add
					(ALUOp == 2'b01)? 4'b0110:( 			// Branch								--> sub
					(ALUOp == 2'b10 && instr == 4'b0000)? 4'b0010:(				// R-type: add		--> add
					(ALUOp == 2'b10 && instr == 4'b1000)? 4'b0110:(				// R-type: sub	 	--> sub
					(ALUOp == 2'b10 && instr[2:0] == 3'b111) ? 4'b0000:(		// R-type: and		--> and
					(ALUOp == 2'b10 && instr[2:0] == 3'b110) ? 4'b0001:(		// R-type: or		--> or
					(ALUOp == 2'b10 && instr[2:0] == 3'b100) ? 4'b1000:(		// R-type: xor		--> xor
					(ALUOp == 2'b10 && instr[2:0] == 3'b010) ? 4'b0111:(		// R-type: slt		--> slt
					(ALUOp == 2'b11 && instr[2:0] == 3'b000) ? 4'b0010:(		// I-type: addi		--> add
					(ALUOp == 2'b11 && instr[2:0] == 3'b010) ? 4'b0111:(		// I-type: slti		--> slt
					(ALUOp == 2'b11 && instr[2:0] == 3'b001) ? 4'b1100:(		// I-type: slli		--> sll
														  4'b1111)))))))))));	// default

endmodule
