`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.04.2024 15:54:31
// Design Name: 
// Module Name: alu_top
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


module alu_top(input clk,input reset,input IDEX_ALUSrc,input [1:0] IDEX_ALUOP,input[31:0] IDEX_ins,input[1:0] forward, input[31:0]fwd_val,
input[31:0]fwd_val_2,input IDEX_RegDst,input[31:0] IDEX_PC,input[31:0] IDEX_rs_reg,input[31:0] IDEX_rt_reg,input[31:0] IDEX_sign_extnd,
output reg[31:0]Badd,output reg[31:0]Jmp_add, output reg zero, output reg[31:0]ALU_result,output reg[31:0] ALUOut, output reg[4:0]Write_addr);
reg [31:0]IN_2;
reg [31:0]IN_1;
wire [3:0]Operation_wire;
wire eq;
wire zr;
wire [31:0] result_wire,result_wire_2;
ALU_Control alu_cnt(.ALUOP(IDEX_ALUOP),.Function_field(IDEX_ins[5:0]),.Operation(Operation_wire));
alu1 al(.IN_1(IN_1),.IN_2(IN_2),.Operation(Operation_wire),.zero(eq),.result(result_wire));
alu1 al_ba(.IN_1(IDEX_PC),.IN_2({IDEX_sign_extnd[29:0],2'b00}),.Operation(4'b0010),.zero(zr),.result(result_wire_2));
always@(*) begin
case(forward)
    2'b00:IN_1 <= IDEX_rs_reg;
    2'b01:IN_1 <= fwd_val;
    2'b10:IN_1 <= fwd_val_2;
    2'b11:IN_1 <= IDEX_rs_reg;
endcase
if(forward == 2'b11)IN_2 <= fwd_val_2;
else begin
case(IDEX_ALUSrc)
    0: IN_2 <= IDEX_rt_reg;
    1: IN_2 <= IDEX_sign_extnd;    
endcase
end
case(IDEX_RegDst)
    0: Write_addr <= IDEX_ins[20:16];
    1: Write_addr <= IDEX_ins[15:11];
endcase
    ALU_result <= result_wire;
    Badd    <= result_wire_2;
    Jmp_add <= {IDEX_ins[31:28], IDEX_ins[25:0], 2'b00};
    zero    <= eq;
end
always@(*)
begin
   ALUOut  <= ALU_result; 
end
endmodule
