/***************************************************
Student Name: 龔意文 施雅青
Student ID: 0816030 0816050
***************************************************/

`timescale 1ns/1ps

module MUX_2to1(
	input   	[32-1:0] data0_i,       
	input   	[32-1:0] data1_i,
	input       	     select_i,
	output wire [32-1:0] data_o
               );			   
/* Write your code HERE */
assign data_o =(select_i == 0)? data0_i : data1_i;
endmodule      
          