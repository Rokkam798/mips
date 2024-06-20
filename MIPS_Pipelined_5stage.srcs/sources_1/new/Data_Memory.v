`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.04.2024 17:43:01
// Design Name: 
// Module Name: Data_Memory
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


module Data_Memory(input clk,input reset,input EXMEM_MemWrite, input EXMEM_MemRead, input EXMEM_MemtoReg,
input[31:0] EXMEM_ALU_result, input[31:0] EXMEM_rt_reg,input [1:0] forward_B, input [31:0] Write_Data,output reg [31:0] Read_Data);
reg [31:0] Data_Mem[100:0];
initial begin
    Data_Mem[6] =32'h0000000d;
    Data_Mem[8] =32'h000000A9;
end
always@(*)
begin
    if(EXMEM_MemRead == 1)begin
        Read_Data <= Data_Mem[EXMEM_ALU_result];
    end
end
always@(*)
begin
    if(EXMEM_MemWrite == 1)begin
        if(forward_B == 1)
        Data_Mem[EXMEM_ALU_result] <= Write_Data;
        else Data_Mem[EXMEM_ALU_result] <= EXMEM_rt_reg;
    end
end
endmodule
