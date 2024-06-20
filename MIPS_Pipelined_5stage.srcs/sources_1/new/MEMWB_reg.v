`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.04.2024 18:33:43
// Design Name: 
// Module Name: MEMWB_reg
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


module MEMWB_reg(
input clk,
input reset,
input [31:0]Read_Data,
input[31:0] EXMEM_ins,
input EXMEM_MemtoReg, 
input EXMEM_RegWrite, 
input[31:0] EXMEM_ALU_result,
input [4:0] EXMEM_Write_addr,
input [31:0] EXMEM_Badd,
input EXMEM_zero,
input EXMEM_Branch,
output reg[31:0] MEMWB_Badd,
output reg MEMWB_zero,
output reg MEMWB_Branch,
output reg[31:0]MEMWB_Read_Data,
output reg[31:0]MEMWB_ins,
output reg MEMWB_MemtoReg, 
output reg MEMWB_RegWrite,
output reg [31:0] MEMWB_ALU_result, 
output reg[4:0] MEMWB_Write_addr
);
always@(posedge clk)begin
    MEMWB_Read_Data <= Read_Data;
    MEMWB_ins <= EXMEM_ins;
    MEMWB_ALU_result <= EXMEM_ALU_result;
    MEMWB_RegWrite   <= EXMEM_RegWrite;
    MEMWB_MemtoReg  <= EXMEM_MemtoReg;
    MEMWB_Write_addr <= EXMEM_Write_addr;
    MEMWB_Badd <= EXMEM_Badd;
    MEMWB_zero <= EXMEM_zero;
    MEMWB_Branch <= EXMEM_Branch;
end
endmodule
