`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.04.2024 18:33:16
// Design Name: 
// Module Name: Write_Back
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


module Write_Back(input clk,input reset, input MEMWB_MemtoReg, input [31:0]MEMWB_Read_Data, input [31:0] MEMWB_ALU_Result,
output reg[31:0] Write_Data);
always@(*)begin
    case(MEMWB_MemtoReg)
        0: Write_Data <= MEMWB_ALU_Result;
        1: Write_Data <= MEMWB_Read_Data;
    endcase
end
endmodule
