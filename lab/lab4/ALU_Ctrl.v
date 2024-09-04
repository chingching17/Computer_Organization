/***************************************************
Student Name: 龔意文 施雅青
Student ID: group19_0816030_0816050
***************************************************/

    `timescale 1ns/1ps
   /*instr[30,14:12]*/
   module ALU_Ctrl(
       input       [4-1:0] instr,
       input       [2-1:0] ALUOp,
       output      [4-1:0] ALU_Ctrl_o
   );
   wire [2:0] func3;
   assign func3 = instr[2:0];
   /* Write your code HERE */

   assign ALU_Ctrl_o = (ALUOp == 2'b00)                   ? 4'b0010:(            // Load, Store      --> add
                       (ALUOp == 2'b01)                   ? 4'b0110:(            // beq				 --> sub
                       (ALUOp == 2'b10 && func3 == 3'b000)? 4'b0010:(            // add, addi        --> add
                       (ALUOp == 2'b10 && func3 == 3'b010)? 4'b0111:(            // slt              --> slt
                                                            4'b1111))));         // else             --> default

   endmodule




