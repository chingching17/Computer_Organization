/***************************************************
Student Name: 施雅青 龔意文
Student ID: 0816050 0816030
***************************************************/
`timescale 1ns/1ps

module alu(
	input                   rst_n,         // negative reset            (input)
	input	signed    [32-1:0]	src1,          // 32 bits source 1          (input)
	input	signed     [32-1:0]	src2,          // 32 bits source 2          (input)
	input 	     [ 4-1:0] 	ALU_control,   // 4 bits ALU control input  (input)
	output reg   [32-1:0]	result,        // 32 bits result            (output)
	output reg              zero,          // 1 bit when the output is 0, zero must be set (output)
	output reg              cout,          // 1 bit carry out           (output)
	output reg              overflow       // 1 bit overflow            (output)
	);

/* Write your code HERE */
wire [31:0] re;
always@(*) begin
	if(rst_n == 1)begin
		case(ALU_control)
			4'b0000: result = src1 & src2;	// and
			4'b0001: result = src1 | src2;	//or
			4'b0010: result = src1 + src2;	//add
			4'b0110: result = src1 - src2;	//sub
			4'b1000: result = src1 ^ src2;	//xor
			4'b0111: //slt
			begin
				if(src1 < src2) result = 1;
				else result = 0;
			end
			4'b1001: result = src1 << src2;	//shift left logical
			4'b1011: result = src1 >>> src2;	//shift right arimetic
			default: result = 32'b0;
		endcase	
			
		zero <= 0;
		cout <= 0;
		overflow <= 0;
			
		
	end
	
end
			

endmodule
