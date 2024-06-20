`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.04.2024 14:42:27
// Design Name: 
// Module Name: Harzard_Detection_Unit
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


module Hazard_Detection_Unit(input IDEX_RegWrite,
input IDEX_MemRead,
input IDEX_MemWrite,
input MemRead,
input MemWrite, 
input[31:0] IDEX_ins, 
input[31:0] IFID_ins, 
output reg stall,
output reg stall_B);
reg[4:0] rs_1,rt_1,rs_2,rt_2;
always@(*)begin
    rt_1 <= IDEX_ins[20:16];
    rs_1 <= IDEX_ins[25:21];
    rs_2 <= IFID_ins[25:21];
    rt_2 <= IFID_ins[20:16];
    if((IDEX_MemRead ==1 && MemWrite != 1)&&((rt_1 == rs_2)||(rt_1 == rt_2)))begin
        stall <= 1;       
    end else if((IDEX_MemRead ==1 && MemWrite == 1) && (rt_1 == rs_2))begin
        stall_B <= 1;
        stall <= 1;
    end else begin
        stall_B <= 0;
        stall <= 0;
    end
end
endmodule
