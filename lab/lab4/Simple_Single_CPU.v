/***************************************************
Student Name: 龔意文 施雅青
Student ID: group19_0816030_0816050
***************************************************/
   `timescale 1ns/1ps
   module Simple_Single_CPU(
       input clk_i,
       input rst_i
   );

   //Internal Signales
   //Control Signales
   wire RegWrite;
   wire Branch;
   wire Jump;
   wire WriteBack1;
   wire WriteBack0;
   wire MemRead;
   wire MemWrite;
   wire ALUSrcA;
   wire ALUSrcB;
   wire [2-1:0] ALUOp;
   wire PCSrc;

   //ALU Flag
   wire Zero;

   //Datapath
   wire [32-1:0] pc_i;
   wire [32-1:0] pc_o;
   wire [32-1:0] instr;
   wire [32-1:0] RegWriteData;
   wire [32-1:0] Imm_Gen_o;
   wire [32-1:0] Imm_4 = 4;
   wire [4-1:0] ALUControlOut;
   wire [4-1:0] ALUControlIn;
   assign ALUControlIn[3] = instr[30];
   assign ALUControlIn[2:0] = instr[14:12];
   assign PCSrc = (Branch & Zero) | Jump;

   wire [32-1:0] PCPlus4_o;   

   wire [32-1:0] rs1; 
   wire [32-1:0] rs2; 
   wire [32-1:0] src2;
   wire [32-1:0] alu_o;
   wire [32-1:0] MUX_A_o;
   wire [32-1:0] add_pcReg_o;
   wire [32-1:0] WriteBack0_o;
   wire [32-1:0] data_o; //data memory output


   ProgramCounter PC(
       .clk_i(clk_i),
       .rst_i(rst_i),
       .pc_i(pc_i),
       .pc_o(pc_o)
   );

 
   Adder Adder_PCPlus4(
       .src1_i(pc_o),
       .src2_i(Imm_4),
       .sum_o(PCPlus4_o)
   );

  
   Instr_Memory IM(
       .addr_i(pc_o),
       .instr_o(instr)
   );

   Reg_File RF(
       .clk_i(clk_i),
       .rst_i(rst_i),
       .RSaddr_i(instr[19:15]),
       .RTaddr_i(instr[24:20]),
       .RDaddr_i(instr[11:7]),
       .RDdata_i(RegWriteData),
       .RegWrite_i(RegWrite),
       .RSdata_o(rs1),
       .RTdata_o(rs2)
   );


   Decoder Decoder(
       .instr_i(instr[6:0]),
       .RegWrite(RegWrite), 
       .Branch(Branch),
       .Jump(Jump),
       .WriteBack1(WriteBack1),
       .WriteBack0(WriteBack0),
       .MemRead(MemRead),
       .MemWrite(MemWrite),
       .ALUSrcA(ALUSrcA),
       .ALUSrcB(ALUSrcB),
       .ALUOp(ALUOp)
   );

   Imm_Gen ImmGen(
       .instr_i(instr),
       .Imm_Gen_o(Imm_Gen_o)
   );


   ALU_Ctrl ALU_Ctrl(
       .instr(ALUControlIn),
    	 .ALUOp(ALUOp),
    	 .ALU_Ctrl_o(ALUControlOut)
   );

   MUX_2to1 MUX_ALUSrcA(
       .data0_i(pc_o),
       .data1_i(rs1),
       .select_i(ALUSrcA),
       .data_o(MUX_A_o)
   );

   Adder Adder_PCReg(
       .src1_i(MUX_A_o),
       .src2_i(Imm_Gen_o),
       .sum_o(add_pcReg_o)
   );

   MUX_2to1 MUX_PCSrc(
       .data0_i(PCPlus4_o),
       .data1_i(add_pcReg_o),
       .select_i(PCSrc),
       .data_o(pc_i)
   );

   MUX_2to1 MUX_ALUSrcB(
       .data0_i(rs2),
       .data1_i(Imm_Gen_o),
       .select_i(ALUSrcB),
       .data_o(src2)
   );

   alu alu(
       .rst_n(rst_i),
       .src1(rs1),
       .src2(src2),
       .ALU_control(ALUControlOut),
       .Zero(Zero),
       .result(alu_o)
   );

   Data_Memory Data_Memory(
       .clk_i(clk_i),
       .addr_i(alu_o),
       .data_i(rs2),
       .MemRead_i(MemRead),
       .MemWrite_i(MemWrite),
       .data_o(data_o)
   );

   MUX_2to1 MUX_WriteBack0(
       .data0_i(alu_o),
       .data1_i(data_o),
       .select_i(WriteBack0),
       .data_o(WriteBack0_o)
   );

   MUX_2to1 MUX_WriteBack1(
       .data0_i(WriteBack0_o),
       .data1_i(PCPlus4_o),
       .select_i(WriteBack1),
       .data_o(RegWriteData)
   );

   endmodule