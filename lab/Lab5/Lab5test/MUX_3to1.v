/***************************************************
Student Name: 龔意文 施雅青
Student ID: 0816030 0816050
***************************************************/

`timescale 1ns/1ps

module MUX_3to1(
	input   	[32-1:0] data0_i,       
	input   	[32-1:0] data1_i,
	input   	[32-1:0] data2_i,
	input       [ 2-1:0] select_i,
	output wire [32-1:0] data_o
               );			   

/* Write your code HERE */
assign data_o =(select_i == 2'b00)? data0_i : (
               (select_i == 2'b01)? data1_i : (
               data2_i));
endmodule      
          