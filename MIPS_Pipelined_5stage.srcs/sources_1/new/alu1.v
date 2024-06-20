`timescale 1ns / 1ps

module alu1(
    input [31:0] IN_1,
    input [31:0] IN_2,
    input [3:0] Operation,
    output reg zero,
    output reg [31:0] result
);
wire [31:0]temp0;
wire [31:0]temp1;
wire [31:0]temp2;
wire [31:0]temp3;
wire [31:0]temp4;
OR1 r1 (.IN_1(IN_1), .IN_2(IN_2), .result(temp0));
SUB r2 (.IN_1(IN_1), .IN_2(IN_2), .result(temp1));
AND r3 (.IN_1(IN_1), .IN_2(IN_2), .result(temp2));
ADD r4 (.IN_1(IN_1), .IN_2(IN_2), .result(temp3));
//XOR r5 (.IN_1(IN_1), .IN_2(IN_2), .result(temp4));

always @(*)
begin
    case(Operation)
        4'b0001: begin       //OR
            result=temp0;
        end
                      
        4'b0110: begin          //SUB
            result=temp1;
        end

        4'b0000: begin       //AND
            result=temp2;
        end

        4'b0010: begin         //ADD
            result=temp3;
        end
        4'b1000:begin           // XOR
            result= IN_1^IN_2;
        end
        4'b0111:begin
            if(temp1==0)                 //SLT
            result = {31'b0,1'b1};
            else result = {31'b0,temp1[31]};
        end
    endcase

    if (result == 0)
        zero = 1;
    else
        zero = 0;
end

endmodule
