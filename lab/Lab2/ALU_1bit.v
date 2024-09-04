/***************************************************
Student Name: 施雅青
Student ID: 0816050
***************************************************/
`timescale 1ns/1ps

module ALU_1bit(
	input				src1,       //1 bit source 1  (input)
	input				src2,       //1 bit source 2  (input)
	input 				Ainvert,    //1 bit A_invert  (input)
	input				Binvert,    //1 bit B_invert  (input)
	input 				Cin,        //1 bit carry in  (input)
	input 	    [2-1:0] operation,  //2 bit operation (input)
	output reg          result,     //1 bit result    (output)
	output reg          cout        //1 bit carry out (output)
	);

/* Write your code HERE */


reg s1, s2;

reg done;

always@( * )begin

done =0 ;

if(done == 0)begin
	if(Ainvert) s1 = ~src1;	else s1 = src1;
	if(Binvert) s2 = ~src2;	else s2 = src2;
	
	case(operation)
		2'b00:begin//and
			result = s1 & s2;
			cout = 0;end
			
		2'b01:begin//Or
			result = s1 | s2;
			cout = 0;end
		
		2'b10:begin//add
			result = s1 ^ s2 ^ Cin;
			cout = (s1&s2) + (s1&Cin) + (s2&Cin); 
			end
		
		2'b11:begin//slt
			result = s1 ^ s2 ^ Cin;
			cout = (s1&s2) + (s1&Cin) + (s2&Cin);
			end
	endcase
	
	done = 1;
	
end
else begin
	result = result;
	cout = cout;
end
	
end

endmodule
