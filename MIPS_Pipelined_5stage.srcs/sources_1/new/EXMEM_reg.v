`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.04.2024 17:03:55
// Design Name: 
// Module Name: EXMEM_reg
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


module EXMEM_reg(
    input clk,
    input reset,
    input [31:0] Badd,
    input zero,
    input [31:0] IDEX_ins,
    input [31:0] ALU_result,
    input [31:0] Write_addr,
    input [31:0] IDEX_rt_reg,
    input IDEX_Branch,
    input IDEX_MemWrite,
    input IDEX_MemRead,
    input IDEX_MemtoReg,
    input IDEX_RegWrite,
    input [1:0]forward_B,
    output reg [31:0] EXMEM_Badd,
    output reg EXMEM_zero,
    output reg [31:0] EXMEM_ALU_result,
    output reg [4:0] EXMEM_Write_addr,
    output reg [31:0] EXMEM_ins,
    output reg [31:0] EXMEM_rt_reg,
    output reg EXMEM_Branch,
    output reg EXMEM_MemWrite,
    output reg EXMEM_MemRead,
    output reg EXMEM_MemtoReg,
    output reg EXMEM_RegWrite,
    output reg [1:0]EXMEM_forward_B
);

always @(posedge clk or posedge reset) begin
    if (reset) begin
        // Reset all registers to zero
        EXMEM_Badd <= 32'b0;
        EXMEM_zero <= 1'b0;
        EXMEM_ALU_result <= 32'b0;
        EXMEM_Write_addr <= 32'b0;
        EXMEM_ins <= 32'b0;
        EXMEM_rt_reg <= 32'b0;
        EXMEM_Branch <= 1'b0;
        EXMEM_MemWrite <= 1'b0;
        EXMEM_MemRead <= 1'b0;
        EXMEM_MemtoReg <= 1'b0;
        EXMEM_RegWrite <= 1'b0;
        EXMEM_forward_B <= 2'b00;
    end else begin
        // Update registers with new values
        EXMEM_Badd <= Badd;
        EXMEM_zero <= zero;
        EXMEM_ALU_result <= ALU_result;
        EXMEM_Write_addr <= Write_addr;
        EXMEM_ins <= IDEX_ins;
        EXMEM_rt_reg <= IDEX_rt_reg;
        EXMEM_Branch <= IDEX_Branch;
        EXMEM_MemWrite <= IDEX_MemWrite;
        EXMEM_MemRead <= IDEX_MemRead;
        EXMEM_MemtoReg <= IDEX_MemtoReg;
        EXMEM_RegWrite <= IDEX_RegWrite;
        EXMEM_forward_B <= forward_B;
    end
end

endmodule

