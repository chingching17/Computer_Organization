/***************************************************
Student Name: 龔意文 施雅青
Student ID: group19_0816030_0816050
***************************************************/
    `timescale 1ns/1ps

   module alu(
       input                   rst_n,         // negative reset            (input)
       input        [32-1:0]   src1,          // 32 bits source 1          (input)
       input        [32-1:0]   src2,          // 32 bits source 2          (input)
       input        [ 4-1:0]   ALU_control,   // 4 bits ALU control input  (input)
       output reg   [32-1:0]   result,        // 32 bits result            (output)
       output               Zero          // 1 bit when the output is 0, zero must be set (output)
   );

   /* Write your code HERE */
always@(*) begin
    if(rst_n == 1)begin
		case(ALU_control)
			4'b0010: result = $signed(src1) + $signed(src2);	//add
			4'b0110: result = $signed(src1) - $signed(src2);	//sub
			4'b0111: result = $signed(src1) < $signed(src2);  //slt
			default: result = result;
		endcase
	end
	else result = 0;
end

assign Zero = (result==0) ? 1 : 0;

   endmodule
