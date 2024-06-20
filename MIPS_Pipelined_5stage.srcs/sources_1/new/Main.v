`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.04.2024 12:22:42
// Design Name: 
// Module Name: Main
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Main(
    input clk,
    input reset
);
wire [31:0] fetched_instruction,fetched_IDEX_ins,fetched_EXMEM_ins,fetched_MEMWB_ins;
wire [31:0] fetched_IFID_ins;
wire [31:0] PC, IFID_PC, IDEX_PC;
wire Branch,IDEX_Branch,EXMEM_Branch,MEMWB_Branch;
wire Jmp,IDEX_Jmp;
wire zero,EXMEM_zero,MEMWB_zero;
wire [31:0] Badd,EXMEM_Badd,MEMWB_Badd,Jmp_add;
wire RegDst,IDEX_RegDst;
wire RegWrite, IDEX_RegWrite,EXMEM_RegWrite,MEMWB_RegWrite;
wire [31:0] Read_Data,MEMWB_Read_Data;
wire [31:0]rsreg,IDEX_rs_reg;
wire [31:0]rtreg,IDEX_rt_reg,EXMEM_rt_reg;
wire [31:0]rdreg;
wire MemRead,IDEX_MemRead,EXMEM_MemRead;
wire IDEX_flush,IFID_flush,IDEX_IDEX_flush,IDEX_IFID_flush;
wire MemtoReg,IDEX_MemtoReg,EXMEM_MemtoReg,MEMWB_MemtoReg;
wire [1:0] ALUOP,IDEX_ALUOP;
wire MemWrite,IDEX_MemWrite,EXMEM_MemWrite;
wire ALUSrc,IDEX_ALUSrc,stall,IFID_stall,stall_B,IFID_stall_B;
wire [1:0] forward,forward_B,EXMEM_forward_B;
wire [31:0] IDEX_sgnext,sgn_shlf;
wire [31:0] ALU_result,EXMEM_ALU_result,MEMWB_ALU_result;
wire [31:0] ALUOut,sgn_ext,IDEX_sign_extnd;
wire [31:0] Write_Data;
wire [4:0] Write_addr,EXMEM_Write_addr,MEMWB_Write_addr;


Instruction_memory in_mem(
    .clk(clk),
    .reset(reset),
    .PCSrc(IDEX_Branch&zero),
    .IDEX_Jmp(IDEX_Jmp),
    .stall(stall),
    .IFID_stall_B(IFID_stall_B),
    .Badd(Badd),
    .Jmp_add(Jmp_add),
    .IFID_flush(IFID_flush),
    .instruction(fetched_instruction),
    .PC(PC)
);

IFID_reg IFID(
    .clk(clk),
    .reset(reset),
    .stall(stall),
    .stall_B(stall_B),
    .instruction(fetched_instruction),
    .PC(PC),
    .IFID_flush(IFID_flush&zero || IFID_flush&Jmp),
    .zero(zero),
    .Jmp(Jmp),
    .IFID_ins(fetched_IFID_ins),
    .IFID_PC(IFID_PC),
    .IFID_stall(IFID_stall),
    .IFID_stall_B(IFID_stall_B),
    .IFID_IFID_flush(IFID_IFID_flush)
);

Reg_File rf(
    .clk(clk),
    .reset(reset),
    .IFID_ins(fetched_IFID_ins),
    .RegWrite(MEMWB_RegWrite),
    .Write_addr(MEMWB_Write_addr),
    .Writedata(Write_Data),
    .rs_reg(rsreg),
    .rt_reg(rtreg),
    .rd_reg(rdreg),
    .sgn_ext(sgn_ext),
    .sgn_shlf(sgn_shlf)
);

Control_unit cu(
    .opcode(fetched_IFID_ins[31:26]),
    .stall(stall),
    .RegDst(RegDst),
    .Branch(Branch),
    .Jmp(Jmp),
    .MemRead(MemRead),
    .MemtoReg(MemtoReg),
    .ALUOP(ALUOP),
    .MemWrite(MemWrite),
    .ALUSrc(ALUSrc),
    .RegWrite(RegWrite),
    .IFID_flush(IFID_flush),
    .IDEX_flush(IDEX_flush)
);
    
IDEX_reg IDEX(
    .clk(clk),
    .reset(reset),
    .IFID_ins(fetched_IFID_ins),
    .RegDst(RegDst),
    .ALUOP(ALUOP),
    .IFID_PC(IFID_PC),
    .ALUSrc(ALUSrc),
    .Branch(Branch),
    .Jmp(Jmp),
    .MemRead(MemRead),
    .MemWrite(MemWrite),
    .RegWrite(RegWrite),
    .MemtoReg(MemtoReg),
    .IDEX_flush(IDEX_flush),
    .IFID_flush(IFID_flush),
    .sgn_ext(sgn_ext),
    .rt_reg(rtreg),
    .rs_reg(rsreg),
    .IDEX_ins(fetched_IDEX_ins),
    .IDEX_RegDst(IDEX_RegDst),
    .IDEX_ALUOP(IDEX_ALUOP),
    .IDEX_PC(IDEX_PC),
    .IDEX_ALUSrc(IDEX_ALUSrc),
    .IDEX_Branch(IDEX_Branch),
    .IDEX_Jmp(IDEX_Jmp),
    .IDEX_MemRead(IDEX_MemRead),
    .IDEX_MemWrite(IDEX_MemWrite),
    .IDEX_RegWrite(IDEX_RegWrite),
    .IDEX_MemtoReg(IDEX_MemtoReg),
    .IDEX_sign_extnd(IDEX_sign_extnd),
    .IDEX_rt_reg(IDEX_rt_reg),
    .IDEX_rs_reg(IDEX_rs_reg),
    .IDEX_IFID_flush(IDEX_IFID_flush),
    .IDEX_IDEX_flush(IDEX_IDEX_flush)
);
Hazard_Detection_Unit hd(
    .IDEX_RegWrite(IDEX_RegWrite),
    .IDEX_MemRead(IDEX_MemRead),
    .IDEX_MemWrite(IDEX_MemWrite),
    .MemRead(MemRead),
    .MemWrite(MemWrite),
    .IDEX_ins(fetched_IDEX_ins),
    .IFID_ins(fetched_IFID_ins),
    .stall(stall),
    .stall_B(stall_B)
    ); 
    
Forwarding_unit fu(
    .EXMEM_RegWrite(EXMEM_RegWrite),
    .IDEX_RegWrite(IDEX_RegWrite),
    .MEMWB_RegWrite(MEMWB_RegWrite),
    .EXMEM_MemWrite(EXMEM_MemWrite),
    .IFID_ins(fetched_IFID_ins),
    .EXMEM_ins(fetched_EXMEM_ins),
    .IDEX_ins(fetched_IDEX_ins),
    .MEMWB_ins(fetched_MEMWB_ins),
    .forward(forward),
    .forward_B(forward_B)
);
   
alu_top alu_inst (
    .clk(clk),
    .reset(reset),
    .forward(forward),
    .fwd_val(MEMWB_Read_Data),
    .fwd_val_2(EXMEM_ALU_result),
    .IDEX_ALUSrc(IDEX_ALUSrc),
    .IDEX_ALUOP(IDEX_ALUOP),
    .IDEX_ins(fetched_IDEX_ins),
    .IDEX_RegDst(IDEX_RegDst),
    .IDEX_PC(IDEX_PC),
    .IDEX_rs_reg(IDEX_rs_reg),
    .IDEX_rt_reg(IDEX_rt_reg),
    .IDEX_sign_extnd(IDEX_sign_extnd),
    .Badd(Badd),
    .Jmp_add(Jmp_add),
    .zero(zero),
    .ALU_result(ALU_result),
    .ALUOut(ALUOut),
    .Write_addr(Write_addr)
);

EXMEM_reg EXMEM (
    .clk(clk),
    .reset(reset),
    .Badd(Badd),
    .zero(zero),
    .ALU_result(ALU_result),
    .Write_addr(Write_addr),
    .IDEX_ins(fetched_IDEX_ins),
    .IDEX_rt_reg(IDEX_rt_reg),
    .IDEX_Branch(IDEX_Branch),
    .IDEX_MemWrite(IDEX_MemWrite),
    .IDEX_MemRead(IDEX_MemRead),
    .IDEX_MemtoReg(IDEX_MemtoReg),
    .IDEX_RegWrite(IDEX_RegWrite),
    .forward_B(forward_B),
    .EXMEM_Badd(EXMEM_Badd),
    .EXMEM_zero(EXMEM_zero),
    .EXMEM_ALU_result(EXMEM_ALU_result),
    .EXMEM_Write_addr(EXMEM_Write_addr),
    .EXMEM_ins(fetched_EXMEM_ins),
    .EXMEM_rt_reg(EXMEM_rt_reg),
    .EXMEM_Branch(EXMEM_Branch),
    .EXMEM_MemWrite(EXMEM_MemWrite),
    .EXMEM_MemRead(EXMEM_MemRead),
    .EXMEM_MemtoReg(EXMEM_MemtoReg),
    .EXMEM_RegWrite(EXMEM_RegWrite),
    .EXMEM_forward_B(EXMEM_forward_B)
);

Data_Memory dm(
    .clk(clk),
    .reset(reset),
    .EXMEM_MemWrite(EXMEM_MemWrite),
    .EXMEM_MemRead(EXMEM_MemRead),
    .EXMEM_MemtoReg(EXMEM_MemtoReg),
    .EXMEM_ALU_result(EXMEM_ALU_result),
    .EXMEM_rt_reg(EXMEM_rt_reg),
    .forward_B(forward_B),
    .Write_Data(Write_Data),
    .Read_Data(Read_Data)
);

MEMWB_reg MEMWB (
    .clk(clk),
    .reset(reset),
    .Read_Data(Read_Data),
    .EXMEM_ins(fetched_EXMEM_ins),
    .EXMEM_MemtoReg(EXMEM_MemtoReg),
    .EXMEM_RegWrite(EXMEM_RegWrite),
    .EXMEM_ALU_result(EXMEM_ALU_result),
    .EXMEM_Write_addr(EXMEM_Write_addr),
    .EXMEM_Badd(EXMEM_Badd),
    .EXMEM_zero(EXMEM_zero),
    .EXMEM_Branch(EXMEM_Branch),
    .MEMWB_Badd(MEMWB_Badd),
    .MEMWB_zero(MEMWB_zero),
    .MEMWB_Branch(MEMWB_Branch),
    .MEMWB_Read_Data(MEMWB_Read_Data),
    .MEMWB_ins(fetched_MEMWB_ins),
    .MEMWB_MemtoReg(MEMWB_MemtoReg),
    .MEMWB_RegWrite(MEMWB_RegWrite),
    .MEMWB_ALU_result(MEMWB_ALU_result),
    .MEMWB_Write_addr(MEMWB_Write_addr)
);

Write_Back write_back_inst (
    .clk(clk),
    .reset(reset),
    .MEMWB_MemtoReg(MEMWB_MemtoReg),
    .MEMWB_Read_Data(MEMWB_Read_Data),
    .MEMWB_ALU_Result(MEMWB_ALU_result),
    .Write_Data(Write_Data)
);

endmodule
