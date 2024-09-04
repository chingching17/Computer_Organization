/***************************************************
Student Name: 龔意文 施雅青
Student ID: group19_0816030_0816050
***************************************************/
`timescale 1ns/1ps

   module Decoder(
       input   [7-1:0]     instr_i,
       output              RegWrite,
       output              Branch,
       output              Jump,
       output              WriteBack1,
       output              WriteBack0,
       output              MemRead,
       output              MemWrite,
       output              ALUSrcA,
       output              ALUSrcB,
       output  [2-1:0]     ALUOp
   );
   /* Write your code HERE */

 assign RegWrite = (instr_i == 7'b0100011 || instr_i==7'b1100011)? 0 : 1;
   assign Branch = (instr_i ==7'b1100011) ? 1:0;
   assign Jump = (instr_i ==7'b1101111 || instr_i ==7'b1100111)? 1:0;
   assign WriteBack0 = (instr_i ==7'b0000011) ? 1:0;
   assign WriteBack1 = (instr_i ==7'b0100011 || instr_i ==7'b1100011 || instr_i ==7'b1101111 || instr_i ==7'b1100111)? 1:0;
   assign MemRead = ( instr_i ==7'b0000011) ? 1:0;
   assign MemWrite = (instr_i ==7'b0100011)? 1:0;
   assign ALUSrcA = (instr_i ==7'b1100111)? 1:0;
   assign ALUSrcB = (instr_i ==7'b0010011 || instr_i ==7'b0000011 || instr_i ==7'b0100011 || instr_i ==7'b1101111 || instr_i ==7'b1100111)? 1:0;
   assign ALUOp = (instr_i == 7'b0110011 || instr_i == 7'b0010011)? 2'b10 : ((instr_i == 7'b0000011 || instr_i == 7'b0100011)? 2'b00 : ((instr_i == 7'b1100011)? 2'b01 : 2'b11));

 /*
7'b0110011:begin	//add, slt
7'b0010011:begin	//addi
7'b0000011:begin	//lw
7'b0100011:begin	//sw
7'b1100011:begin	//beq
7'b1101111:begin	//jal
7'b1100111:begin	//jalr
*/
 
   endmodule
