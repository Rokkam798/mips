`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.04.2024 12:17:51
// Design Name: 
// Module Name: IFID_reg
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


module IFID_reg(
    input clk,
    input reset,
    input stall,
    input stall_B,
    input [31:0] instruction,
    input [31:0] PC,
    input IFID_flush,
    input zero,
    input Jmp,
    output reg [31:0] IFID_ins,
    output reg [31:0] IFID_PC,
    output reg IFID_stall,
    output reg IFID_stall_B,
    output reg IFID_IFID_flush
);
reg flush;
always @(posedge flush)begin 
if (flush) begin
    IFID_ins <= 32'bx; // Set IFID_ins to all zeroes
    IFID_PC <= 32'b0;  // Set IFID_PC to all zeroes
end
end
always @(posedge clk) begin
    flush <= IFID_flush; 
    if (reset || flush) begin
        IFID_ins <= 32'bx; // Set IFID_ins to all zeroes
        IFID_PC <= 32'b0;  // Set IFID_PC to all zeroes
        flush <= 0;
    end else begin
        if(!stall && !IFID_stall_B)begin
        IFID_ins <= instruction;
        IFID_PC <= PC;
        IFID_stall_B <= 0;
        IFID_IFID_flush <= IFID_flush;
        end
        IFID_stall <= stall;
        IFID_stall_B <= stall_B;
    end
end

endmodule

