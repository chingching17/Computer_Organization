/***************************************************
Student Name: 龔意文 施雅青
Student ID: group19_0816030_0816050
***************************************************/

   `timescale 1ns/1ps

   module MUX_2to1(
       input  [31:0] data0_i,
       input  [31:0] data1_i,
       input         select_i,
       output [31:0] data_o
   );

   assign data_o = (select_i==0)?data0_i:data1_i;

   endmodule
