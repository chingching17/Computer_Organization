module ForwardingUnit (EXE_instr19_15, EXE_instr24_20, MEM_instr11_7, MEM_WBControl, WB_instr11_7, WB_Control, src1_sel_o, src2_sel_o);

	input [5-1:0] EXE_instr19_15, EXE_instr24_20, MEM_instr11_7, WB_instr11_7;
	input  MEM_WBControl, WB_Control;
	output wire [2-1:0] src1_sel_o, src2_sel_o;

/* Write your code HERE */
assign src1_sel_o = (MEM_WBControl && (MEM_instr11_7 != 0) && (MEM_instr11_7 == EXE_instr19_15))? 2'b10:(	// rs1 = MEM's rd
					(WB_Control && (WB_instr11_7 != 0) && (WB_instr11_7 == EXE_instr19_15))? 2'b01:(		// rs1 = WB's rd
																							 2'b00));		// rs1 = rs1
																							
assign src2_sel_o = (MEM_WBControl && (MEM_instr11_7 != 0) && (MEM_instr11_7 == EXE_instr24_20))? 2'b10:(	// rs2 = MEM's rd
					(WB_Control && (WB_instr11_7 != 0) && (WB_instr11_7 == EXE_instr24_20))? 2'b01:(		// rs2 = WB's rd
																							 2'b00));		// rs2 = rs2

endmodule

 
