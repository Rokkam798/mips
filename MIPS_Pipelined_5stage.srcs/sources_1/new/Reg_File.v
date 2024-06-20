`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.04.2024 12:33:26
// Design Name: 
// Module Name: Reg_File
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


module Reg_File(input clk,input reset,input [31:0] IFID_ins,input RegWrite,input [4:0] Write_addr, 
input[31:0] Writedata, output reg[31:0] rs_reg, output reg[31:0] rt_reg, output reg[31:0] rd_reg,output reg[31:0]sgn_ext, output reg[31:0] sgn_shlf);
reg [31:0] registers [31:0];
initial begin
    registers[0]  = 32'h00000000;
    registers[2]  = 32'h00000006;
//    registers[3]  = 32'h00000011;
//   registers[4]  = 32'h0000E311;
    registers[5]  = 32'h000964EB;
    registers[7]  = 32'h000964EA;
    registers[8]  = 32'h000113D4;
    registers[10] = 32'h0001230B;
    registers[11] = 32'h00000002;
    registers[12] = 32'h00000002;
end
always@(*)
begin
    if(RegWrite == 1)begin
        registers[Write_addr] <= Writedata;
    end
    rs_reg <=registers[IFID_ins[25:21]];
    rt_reg <=registers[IFID_ins[20:16]];
    rd_reg <=registers[IFID_ins[15:11]];
    sgn_ext <= {16'b0,IFID_ins[15:0]};
    sgn_shlf <= {sgn_ext[31:0],2'b00}; 
end
endmodule
