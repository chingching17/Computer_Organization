/***************************************************
Student Name: 施雅青
Student ID: 0816050
***************************************************/
`timescale 1ns/1ps

module alu(
	input                   rst_n,         // negative reset            (input)
	input	     [32-1:0]	src1,          // 32 bits source 1          (input)
	input	     [32-1:0]	src2,          // 32 bits source 2          (input)
	input 	     [ 4-1:0] 	ALU_control,   // 4 bits ALU control input  (input)
	output reg   [32-1:0]	result,        // 32 bits result            (output)
	output reg              zero,          // 1 bit when the output is 0, zero must be set (output)
	output reg              cout,          // 1 bit carry out           (output)
	output reg              overflow       // 1 bit overflow            (output)
	);

/* Write your code HERE */
//wire zero;
//wire cout;
//wire overflow;


reg [1:0] oper;
wire [32:0] carry;
reg a_in;
reg b_in;
wire [31:0] re;


assign carry[0] = (ALU_control==4'b0110)? 1: (ALU_control==4'b0111)? 1: 0; //sub slt: cin =1
//assign zero = (result == 0) ? 1 : 0;
/*assign overflow = ( (ALU_control==4'b0000) & src1[31] & src2[31] & ~result[31]) ? 1 
					  :( (ALU_control==4'b0000) & ~src1[31] & ~src2[31] & result[31]) ? 1 
					  :( (ALU_control==4'b0110) & src1[31] & ~src2[31] & ~(result[31])) ? 1 
					  :( (ALU_control==4'b0110) & ~src1[31] & src2[31] & result[31]) ? 1 
					  : 0;*/
/*
always@(*)begin
	if(ALU_control==4'b0110) carry[0] <= 1;
	else if(ALU_control==4'b0111)  carry[0] <= 1;
	else  carry[0] <= 0;
end
*/

/*
always@(result)begin
	if(!result) zero <= 1;
	else zero <= 0;
end*/



always@(*)begin
	if((ALU_control==4'b0010) & src1[31] & src2[31] & ~result[31]) overflow <= 1;
	else if( (ALU_control==4'b0010) & ~src1[31] & ~src2[31] & result[31]) overflow <= 1;
	else if( (ALU_control==4'b0110) & src1[31] & ~src2[31] & ~(result[31])) overflow <= 1;
	else if( (ALU_control==4'b0110) & ~src1[31] & src2[31] & result[31]) overflow <= 1;
	else overflow <= 0;
end

always@(*) begin
	if(rst_n == 1)begin
		case(ALU_control)
			4'b0000:begin //and
				a_in <= 0;
				b_in <= 0;
				oper <= 2'b00;
				end
			4'b0001:begin //or
				a_in <= 0;
				b_in <= 0;
				oper <= 2'b01;
				end
			4'b0010:begin //add
				a_in <= 0;
				b_in <= 0;
				oper <= 2'b10;
				end
			4'b0110:begin //sub
				a_in <= 0;
				b_in <= 1;
				oper <= 2'b10;
				end
			4'b0111:begin //slt
				a_in <= 0;
				b_in <= 1;
				oper <= 2'b11;
				end
			4'b1100:begin //nor
				a_in <= 1;
				b_in <= 1;
				oper <= 2'b00;
				end
			4'b1101:begin //nand
				a_in <= 1;
				b_in <= 1;
				oper <= 2'b01;
				end
			default: ;
		endcase
		
		result <= (ALU_control!=4'b0111)? re : (re[31])? 1 : 0;
		cout <= (ALU_control==4'b0111)? 0 : carry[32];
			
		
		//zero
		if(result == 0)
			zero <= 1;
		else
			zero <= 0;
		
	end
	else begin
		zero = 0;
		cout = 0;
		overflow = 0;
		result = 0;
	end
	
  
	
end

ALU_1bit alu0(.src1(src1[0]), .src2(src2[0]), .Ainvert(a_in), .Binvert(b_in)
			, .Cin(carry[0]), .operation(oper), .result(re[0]), .cout(carry[1]));

ALU_1bit alu1(.src1(src1[1]), .src2(src2[1]), .Ainvert(a_in), .Binvert(b_in)
      , .Cin(carry[1]), .operation(oper), .result(re[1]), .cout(carry[2]));

ALU_1bit alu2(.src1(src1[2]), .src2(src2[2]), .Ainvert(a_in), .Binvert(b_in)
      , .Cin(carry[2]), .operation(oper), .result(re[2]), .cout(carry[3]));

ALU_1bit alu3(.src1(src1[3]), .src2(src2[3]), .Ainvert(a_in), .Binvert(b_in)
      , .Cin(carry[3]), .operation(oper), .result(re[3]), .cout(carry[4]));

ALU_1bit alu4(.src1(src1[4]), .src2(src2[4]), .Ainvert(a_in), .Binvert(b_in)
      , .Cin(carry[4]), .operation(oper), .result(re[4]), .cout(carry[5]));

ALU_1bit alu5(.src1(src1[5]), .src2(src2[5]), .Ainvert(a_in), .Binvert(b_in)
      , .Cin(carry[5]), .operation(oper), .result(re[5]), .cout(carry[6]));

ALU_1bit alu6(.src1(src1[6]), .src2(src2[6]), .Ainvert(a_in), .Binvert(b_in)
      , .Cin(carry[6]), .operation(oper), .result(re[6]), .cout(carry[7]));

ALU_1bit alu7(.src1(src1[7]), .src2(src2[7]), .Ainvert(a_in), .Binvert(b_in)
      , .Cin(carry[7]), .operation(oper), .result(re[7]), .cout(carry[8]));

ALU_1bit alu8(.src1(src1[8]), .src2(src2[8]), .Ainvert(a_in), .Binvert(b_in)
      , .Cin(carry[8]), .operation(oper), .result(re[8]), .cout(carry[9]));

ALU_1bit alu9(.src1(src1[9]), .src2(src2[9]), .Ainvert(a_in), .Binvert(b_in)
      , .Cin(carry[9]), .operation(oper), .result(re[9]), .cout(carry[10]));

ALU_1bit alu10(.src1(src1[10]), .src2(src2[10]), .Ainvert(a_in), .Binvert(b_in)
      , .Cin(carry[10]), .operation(oper), .result(re[10]), .cout(carry[11]));

ALU_1bit alu11(.src1(src1[11]), .src2(src2[11]), .Ainvert(a_in), .Binvert(b_in)
      , .Cin(carry[11]), .operation(oper), .result(re[11]), .cout(carry[12]));

ALU_1bit alu12(.src1(src1[12]), .src2(src2[12]), .Ainvert(a_in), .Binvert(b_in)
      , .Cin(carry[12]), .operation(oper), .result(re[12]), .cout(carry[13]));

ALU_1bit alu13(.src1(src1[13]), .src2(src2[13]), .Ainvert(a_in), .Binvert(b_in)
      , .Cin(carry[13]), .operation(oper), .result(re[13]), .cout(carry[14]));

ALU_1bit alu14(.src1(src1[14]), .src2(src2[14]), .Ainvert(a_in), .Binvert(b_in)
      , .Cin(carry[14]), .operation(oper), .result(re[14]), .cout(carry[15]));

ALU_1bit alu15(.src1(src1[15]), .src2(src2[15]), .Ainvert(a_in), .Binvert(b_in)
      , .Cin(carry[15]), .operation(oper), .result(re[15]), .cout(carry[16]));

ALU_1bit alu16(.src1(src1[16]), .src2(src2[16]), .Ainvert(a_in), .Binvert(b_in)
      , .Cin(carry[16]), .operation(oper), .result(re[16]), .cout(carry[17]));

ALU_1bit alu17(.src1(src1[17]), .src2(src2[17]), .Ainvert(a_in), .Binvert(b_in)
      , .Cin(carry[17]), .operation(oper), .result(re[17]), .cout(carry[18]));

ALU_1bit alu18(.src1(src1[18]), .src2(src2[18]), .Ainvert(a_in), .Binvert(b_in)
      , .Cin(carry[18]), .operation(oper), .result(re[18]), .cout(carry[19]));

ALU_1bit alu19(.src1(src1[19]), .src2(src2[19]), .Ainvert(a_in), .Binvert(b_in)
      , .Cin(carry[19]), .operation(oper), .result(re[19]), .cout(carry[20]));

ALU_1bit alu20(.src1(src1[20]), .src2(src2[20]), .Ainvert(a_in), .Binvert(b_in)
      , .Cin(carry[20]), .operation(oper), .result(re[20]), .cout(carry[21]));
    
ALU_1bit alu21(.src1(src1[21]), .src2(src2[21]), .Ainvert(a_in), .Binvert(b_in)
      , .Cin(carry[21]), .operation(oper), .result(re[21]), .cout(carry[22]));

ALU_1bit alu22(.src1(src1[22]), .src2(src2[22]), .Ainvert(a_in), .Binvert(b_in)
      , .Cin(carry[22]), .operation(oper), .result(re[22]), .cout(carry[23]));

ALU_1bit alu23(.src1(src1[23]), .src2(src2[23]), .Ainvert(a_in), .Binvert(b_in)
      , .Cin(carry[23]), .operation(oper), .result(re[23]), .cout(carry[24]));

ALU_1bit alu24(.src1(src1[24]), .src2(src2[24]), .Ainvert(a_in), .Binvert(b_in)
      , .Cin(carry[24]), .operation(oper), .result(re[24]), .cout(carry[25]));

ALU_1bit alu25(.src1(src1[25]), .src2(src2[25]), .Ainvert(a_in), .Binvert(b_in)
      , .Cin(carry[25]), .operation(oper), .result(re[25]), .cout(carry[26]));

ALU_1bit alu26(.src1(src1[26]), .src2(src2[26]), .Ainvert(a_in), .Binvert(b_in)
      , .Cin(carry[26]), .operation(oper), .result(re[26]), .cout(carry[27]));

ALU_1bit alu27(.src1(src1[27]), .src2(src2[27]), .Ainvert(a_in), .Binvert(b_in)
      , .Cin(carry[27]), .operation(oper), .result(re[27]), .cout(carry[28]));

ALU_1bit alu28(.src1(src1[28]), .src2(src2[28]), .Ainvert(a_in), .Binvert(b_in)
      , .Cin(carry[28]), .operation(oper), .result(re[28]), .cout(carry[29]));

ALU_1bit alu29(.src1(src1[29]), .src2(src2[29]), .Ainvert(a_in), .Binvert(b_in)
      , .Cin(carry[29]), .operation(oper), .result(re[29]), .cout(carry[30]));

ALU_1bit alu30(.src1(src1[30]), .src2(src2[30]), .Ainvert(a_in), .Binvert(b_in)
      , .Cin(carry[30]), .operation(oper), .result(re[30]), .cout(carry[31]));

ALU_1bit alu31(.src1(src1[31]), .src2(src2[31]), .Ainvert(a_in), .Binvert(b_in)
      , .Cin(carry[31]), .operation(oper), .result(re[31]), .cout(carry[32]));

endmodule
