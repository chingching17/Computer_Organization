/***************************************************
Student Name: 施雅青 龔意文
Student ID: 0816050 0816030
***************************************************/

`timescale 1ns/1ps

module Decoder(
	input [32-1:0] 	instr_i,
	output wire			ALUSrc,		//I-type.S-type:1 else:0 看ALUOp
	output wire			RegWrite,	//R-type.I-type:1 else:0 看ALUOp
	output wire			Branch,	//ALUOp = 01
	output wire [2-1:0]	ALUOp //derived from opcode
	);
	
//Internal Signals
//wire	[7-1:0]		opcode;		//ch4-I-26 instr[6:0] 7 bit 
//wire 	[3-1:0]		funct3;		//instr[14:12]
//wire	[3-1:0]		Instr_field;
//wire	[9-1:0]		Ctrl_o;
/*
always@(*)begin
	RegWrite = 1'b1;
	Branch = 1'b1;
	ALUOp = 2'b10;
end*/
assign ALUSrc = 1'b0;
assign RegWrite = 1'b1;
assign Branch = 1'b1;
assign ALUOp = 2'b10;

endmodule


// 因為這次所做到的功能無需特別做判斷，都給那些數字即可


                    
                    