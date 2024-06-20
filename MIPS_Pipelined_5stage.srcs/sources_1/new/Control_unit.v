`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.04.2024 12:53:37
// Design Name: 
// Module Name: Control_unit
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


module Control_unit(input [5:0] opcode,input stall, output reg RegDst, output reg Branch, output reg Jmp, output reg MemRead, output reg MemtoReg, 
                    output reg [1:0] ALUOP, output reg MemWrite, output reg ALUSrc, output reg RegWrite,output reg IFID_flush, output reg IDEX_flush);

always@(*)
begin
    if(!stall)begin
        case(opcode)
            6'b000000:begin
                RegDst   <=1;
                Branch   <=0;                   //Rtype
                Jmp      <=0;
                MemRead  <=0;
                MemtoReg <=0;
                ALUOP    <=2'b10;
                MemWrite <=0;
                ALUSrc   <=0;
                RegWrite <=1; 
                IFID_flush <= 0;
                IDEX_flush <= 0;     
            end
            6'b001101:begin
                RegDst   <=0;
                Branch   <=0;                   //Itype
                Jmp      <=0;
                MemRead  <=0;
                MemtoReg <=0;
                ALUOP    <=2'b10;
                MemWrite <=0;
                ALUSrc   <=1;
                RegWrite <=1;
                IFID_flush <= 0;
                IDEX_flush <= 0; 
            end
            6'b100011:begin
                RegDst   <=0;
                Branch   <=0;
                Jmp      <=0;
                MemRead  <=1;                //LW
                MemtoReg <=1;
                ALUOP    <=2'b00;
                MemWrite <=0;
                ALUSrc   <=1;
                RegWrite <=1;
                IFID_flush <= 0;
                IDEX_flush <= 0;  
            end
            6'b101011:begin
                RegDst   <=1'bX;
                Branch   <=0;
                Jmp      <=0;
                MemRead  <=0;                //SW
                MemtoReg <=1'bX;
                ALUOP    <=2'b00;
                MemWrite <=1;
                ALUSrc   <=1;
                RegWrite <=0;
                IFID_flush <= 0;
                IDEX_flush <= 0;  
            end
            6'b000100:begin
                RegDst   <=1'bX;
                Branch   <=1;
                Jmp      <=0;
                MemRead  <=0;                //Beq
                MemtoReg <=1'bX;
                ALUOP    <=2'b01;
                MemWrite <=0;
                ALUSrc   <=0;
                RegWrite <=0;
                IFID_flush <= 1;
                IDEX_flush <= 1;  
            end
            6'b000010:begin
                RegDst   <=1'bX;
                Branch   <=0;
                Jmp      <=1;
                MemRead  <=0;                //JUMP
                MemtoReg <=1'bX;
                ALUOP    <=2'b01;
                MemWrite <=0;
                ALUSrc   <=0;
                RegWrite <=0;
                IFID_flush <= 1;
                IDEX_flush <= 1;               
            end
        endcase
    end
    else begin
       //MemWrite <= 1'bx;
       MemRead  <= 1'bx;
       MemtoReg <=1'bx;
       RegWrite <= 1'bx;
       ALUOP <= 2'bxx;
       RegDst <= 1'bx;
       Branch <= 1'bx;
       Jmp      <=1'bx;
    end
end
endmodule
