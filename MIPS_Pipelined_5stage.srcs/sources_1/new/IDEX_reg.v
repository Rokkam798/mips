`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.04.2024 13:02:16
// Design Name: 
// Module Name: IDEX_reg
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


module IDEX_reg(
    input clk,
    input reset,
    input [31:0] IFID_ins,
    input RegDst,
    input [1:0] ALUOP,
    input [31:0] IFID_PC,
    input ALUSrc,
    input Branch,
    input Jmp,
    input MemRead,
    input MemWrite,
    input RegWrite,
    input MemtoReg,
    input IDEX_flush,
    input IFID_flush,
    input [31:0] sgn_ext,
    input [31:0] rt_reg,
    input [31:0] rs_reg,
    output reg [31:0] IDEX_ins,
    output reg IDEX_RegDst,
    output reg [1:0] IDEX_ALUOP,
    output reg [31:0] IDEX_PC,
    output reg IDEX_ALUSrc,
    output reg IDEX_Branch,
    output reg IDEX_Jmp,
    output reg IDEX_MemRead,
    output reg IDEX_MemWrite,
    output reg IDEX_RegWrite,
    output reg IDEX_MemtoReg,
    output reg [31:0] IDEX_sign_extnd,
    output reg [31:0] IDEX_rt_reg,
    output reg [31:0] IDEX_rs_reg,
    output reg IDEX_IDEX_flush,
    output reg IDEX_IFID_flush
);
//reg flush;
//always@(posedge flush)begin
//   if(flush)begin
//        IDEX_ins <= 32'bx;
//        IDEX_RegDst <= 1'b0;
//        IDEX_ALUOP <= 2'b00;
//        IDEX_PC <= 32'b0;
//        IDEX_ALUSrc <= 1'b0;
//        IDEX_Branch <= 1'b0;
//        IDEX_MemRead <= 1'b0;
//        IDEX_MemWrite <= 1'b0;
//        IDEX_RegWrite <= 1'b0;
//        IDEX_MemtoReg <= 1'b0;
//        IDEX_sign_extnd <= 32'b0;
//        IDEX_rt_reg <= 32'b0;
//        IDEX_rs_reg <= 32'b0;
//   end 
//end
always @(posedge clk or posedge reset) begin
//    flush <= IDEX_flush;
    if (reset) begin
        // Reset all registers to zero
        IDEX_ins <= 32'bx;
        IDEX_RegDst <= 1'b0;
        IDEX_ALUOP <= 2'b00;
        IDEX_PC <= 32'b0;
        IDEX_ALUSrc <= 1'b0;
        IDEX_Branch <= 1'b0;
        IDEX_MemRead <= 1'b0;
        IDEX_MemWrite <= 1'b0;
        IDEX_RegWrite <= 1'b0;
        IDEX_MemtoReg <= 1'b0;
        IDEX_sign_extnd <= 32'b0;
        IDEX_rt_reg <= 32'b0;
        IDEX_rs_reg <= 32'b0;
    end else begin
        // Update registers with new values
        IDEX_ins <= IFID_ins;
        IDEX_RegDst <= RegDst;
        IDEX_ALUOP <= ALUOP;
        IDEX_PC <= IFID_PC;
        IDEX_ALUSrc <= ALUSrc;
        IDEX_Branch <= Branch;
        IDEX_Jmp    <= Jmp;
        IDEX_MemRead <= MemRead;
        IDEX_MemWrite <= MemWrite;
        IDEX_RegWrite <= RegWrite;
        IDEX_MemtoReg <= MemtoReg;
        IDEX_sign_extnd <= sgn_ext;
        IDEX_rt_reg <= rt_reg;
        IDEX_rs_reg <= rs_reg;
        IDEX_IDEX_flush <= IDEX_flush;
        IDEX_IFID_flush <= IFID_flush;
     end
end

endmodule

