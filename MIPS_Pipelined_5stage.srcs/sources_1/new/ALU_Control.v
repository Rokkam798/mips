`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.04.2024 15:49:45
// Design Name: 
// Module Name: ALU_Control
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


module ALU_Control(input [1:0] ALUOP, input [4:0] Function_field, output reg [3:0] Operation);   
always@(*)
if(ALUOP == 2'b00)
begin
Operation = 4'b0010;
end
else if(ALUOP == 2'b01)
begin
Operation = 4'b0110;
end
else if(ALUOP[0] ==0)
begin
if(Function_field[3:0] == 4'b0000)
begin
Operation = 4'b0010;                         // ADD
end
else if(Function_field[3:0] == 4'b0010)
begin                                       // SUB
Operation = 4'b0110; 
end
else if(Function_field[3:0] == 4'b0100)
begin                                       // AND
Operation = 4'b0000;
end
else if(Function_field[3:0] == 4'b0101)
begin                                      // OR
Operation = 4'b0001;
end
else if(Function_field[3:0] == 4'b1010)
begin                                      // SLT
Operation = 4'b0111;
end
else if(Function_field[3:0] == 4'b0110)
begin                                        //XOR
Operation = 4'b1000;

end
end
endmodule
