/***************************************************
Student Name: 龔意文 施雅青
Student ID: 0816030 0816050
***************************************************/

`timescale 1ns/1ps

module Adder(
    input  [32-1:0] src1_i,
	input  [32-1:0] src2_i,
	output [32-1:0] sum_o
	);
    
/* Write your code HERE */
assign sum_o = src1_i + src2_i;

endmodule