/***************************************************
Student Name: 龔意文 施雅青
Student ID: group19_0816030_0816050
***************************************************/

   `timescale 1ns/1ps

   module Adder(
       input  [31:0] src1_i,
       input  [31:0] src2_i,
       output [31:0] sum_o
   );

   assign sum_o = src1_i + src2_i;


   endmodule
