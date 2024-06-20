`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/24/2024 06:03:36 PM
// Design Name: 
// Module Name: Forwarding_unit
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


module Forwarding_unit(input EXMEM_RegWrite,input IDEX_RegWrite, input MEMWB_RegWrite,input EXMEM_MemWrite, input[31:0] EXMEM_ins,input[31:0]IDEX_ins,input[31:0]IFID_ins, input[31:0]MEMWB_ins, output reg[1:0] forward,output reg[1:0] forward_B);
reg[4:0] rt_1,rs_2,rd_1,rt_2,rt_3,rs_3;
always@(*)begin
    rt_1 <= MEMWB_ins[20:16];
    rd_1 <= EXMEM_ins[15:11];
    rs_2 <= IDEX_ins[25:21];
    rt_2 <= IDEX_ins[20:16];
    rt_3 <= EXMEM_ins[20:16];
//    rs_3 <= EXMEM_ins[25:16];
    if((EXMEM_RegWrite == 1)&&(rt_1 == rs_2))begin
        forward <=2'b01;
    end
    else forward <=2'b00;
    if(EXMEM_RegWrite == 1)begin
    if(rd_1 == rs_2)
        forward <= 2'b10;
    else if(rd_1 == rt_2)
       forward <= 2'b11; 
    end
    if(MEMWB_RegWrite == 1 && EXMEM_MemWrite == 1 && rt_1 == rt_3)begin
        forward_B <= 2'b01;
    end
    else forward_B <= 2'b00;
end
endmodule
