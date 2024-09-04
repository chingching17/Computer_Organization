/***************************************************
Student Name: 龔意文 施雅青
Student ID: group19_0816030_0816050
***************************************************/
`timescale 1ns/1ps

   module Imm_Gen(
       input  [31:0] instr_i,
       output reg[31:0] Imm_Gen_o
   );

   //Internal Signals
   wire    [7-1:0] opcode;
   wire    [2:0]   func3;
   wire    [3-1:0] Instr_field;

   assign opcode = instr_i[6:0];
   assign func3  = instr_i[14:12];

   /* Write your code HERE */
always@(*) begin
	case (instr_i[6:0])
	    7'b0010011: 
	        Imm_Gen_o = {{21{instr_i[31]}}  ,  instr_i[30:20]};
		7'b0000011: //i-type lw
			Imm_Gen_o={ {21{instr_i[31]}}	,	instr_i[30:20]	};
		7'b0100011: //S-type sw
			Imm_Gen_o={ {21{instr_i[31]}}, instr_i[30:25], instr_i[11:7] };
		7'b1100011: //sb-type beq bne blt bge
			Imm_Gen_o={ {20{instr_i[31]}}	,	instr_i[7]	,	instr_i[30:25]	,	instr_i[11:8], 1'b0};
		7'b1101111: //jal
			Imm_Gen_o={ {13{instr_i[31]}}, instr_i[19:12], instr_i[20], instr_i[30:21], 1'b0};
		default://i-type
			Imm_Gen_o={ {21{instr_i[31]}} ,	instr_i[30:20] }; //i-type addi sub addi xori slti
	endcase
	
end		

   endmodule
