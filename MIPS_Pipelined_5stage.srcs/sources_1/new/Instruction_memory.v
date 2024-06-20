`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.04.2024 11:57:42
// Design Name: 
// Module Name: Instruction_memory
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

module Instruction_memory(
    input clk,
    input reset,
    input PCSrc,
    input IDEX_Jmp, 
    input stall,
    input IFID_stall_B,
    input [31:0] Badd,
    input [31:0] Jmp_add, 
    input IFID_flush,
    output reg [31:0] instruction,
    output reg [31:0] PC
);

reg [7:0] Ins_Mem [0:63];
reg stall_B_reg;
reg [31:0] reg_ins;
reg [31:0] reg_ins_jmp;
initial begin
    PC <= 0;
    stall_B_reg <= 0;
    
    
//    Ins_Mem[0]  = 8'b10001100;
//    Ins_Mem[1]  = 8'b01000001; // LW reg1,2(reg2); 8c41002   PC = 04
//    Ins_Mem[2]  = 8'b00000000;         
//    Ins_Mem[3]  = 8'b00000010;

////    Ins_Mem[4] = 8'b00010001;           
////    Ins_Mem[5] = 8'b01101100; // BEQ reg11,reg12(1); 11610001   PC = 08
////    Ins_Mem[6] = 8'b00000000;
////    Ins_Mem[7] = 8'b00000001;

//    Ins_Mem[4]  = 8'b10001100;
//    Ins_Mem[5]  = 8'b00100100;
//    Ins_Mem[6]  = 8'b00000000; // LW reg4,4(reg1); 8c24004     PC = 08
//    Ins_Mem[7]  = 8'b00000100;
    
       
////    Ins_Mem[8] = 8'b00010001;           
////    Ins_Mem[9] = 8'b01101100; // BEQ reg11,reg12(1); 11610001   PC = 0c
////    Ins_Mem[10] = 8'b00000000;
////    Ins_Mem[11] = 8'b00000011;
    
//    Ins_Mem[8]  = 8'b10101100;           
//    Ins_Mem[9]  = 8'b10000100; // SW reg4,4(reg 2); ac440004   PC = 0c
//    Ins_Mem[10] = 8'b00000000;
//    Ins_Mem[11] = 8'b00000100;
    
////    Ins_Mem[12]  = 8'b00001000;           
////    Ins_Mem[13]  = 8'b00000000; // Jump 4;        PC = 10
////    Ins_Mem[14] = 8'b00000000;
////    Ins_Mem[15] = 8'b00000001; 

//    Ins_Mem[12] = 8'b00000000;
//    Ins_Mem[13] = 8'b01100101; // SUB reg6,reg3,reg5; 00653022  PC = 14
//    Ins_Mem[14] = 8'b00110000;
//    Ins_Mem[15] = 8'b00100010;
        
//    Ins_Mem[16] = 8'b00000000;
//    Ins_Mem[17] = 8'b11000111; // XOR reg8,reg6,reg7; 00c74026   PC = 18
//    Ins_Mem[18] = 8'b01000000;                                  
//    Ins_Mem[19] = 8'b00100110;

//    Ins_Mem[20] = 8'b00110101;           
//    Ins_Mem[21] = 8'b01001001;  // ORI reg9,reg10,22; 35490015   PC = 1c
//    Ins_Mem[22] = 8'b00000000;
//    Ins_Mem[23] = 8'b00010101;
    
//    Ins_Mem[24] = 8'b00000000;           
//    Ins_Mem[25] = 8'b10000111;  // SLT reg13,reg6,reg7   PC = 20
//    Ins_Mem[26] = 8'b01101000;
//    Ins_Mem[27] = 8'b00101010;

    Ins_Mem[0]  = 8'b10001100;
    Ins_Mem[1]  = 8'b01000001; // LW reg1,2(reg2); 8c41002   PC = 04   reg 1 = 4 
    Ins_Mem[2]  = 8'b00000000;         
    Ins_Mem[3]  = 8'b00000010;
    
    Ins_Mem[4]  = 8'b10001100;
    Ins_Mem[5]  = 8'b01000011; // LW reg3,0(reg2); 8c43000   PC = 08   reg 3 = 2
    Ins_Mem[6]  = 8'b00000000;         
    Ins_Mem[7]  = 8'b00000000;

    Ins_Mem[8] =  8'b00010000;           
    Ins_Mem[9] =  8'b00000011; // BEQ reg3,reg 0(8); 1003000b   PC = 0c
    Ins_Mem[10] = 8'b00000000;
    Ins_Mem[11] = 8'b00001000;
        
    Ins_Mem[12] = 8'b00000000;           
    Ins_Mem[13] = 8'b01100001;  // SLT reg4,reg3,reg1  0061202a   PC = 10
    Ins_Mem[14] = 8'b00100000;
    Ins_Mem[15] = 8'b00101010;
    
    Ins_Mem[16] =  8'b00010000;           
    Ins_Mem[17] =  8'b00000100; // BEQ reg4,reg 0(2); 10040003   PC = 14
    Ins_Mem[18] = 8'b00000000;
    Ins_Mem[19] = 8'b00000010;
    
    Ins_Mem[20] = 8'b00000000;
    Ins_Mem[21] = 8'b00100011; // SUB reg1,reg1,reg3; 00230822  PC = 18
    Ins_Mem[22] = 8'b00001000;
    Ins_Mem[23] = 8'b00100010;
    
    Ins_Mem[24] = 8'b00001000;           
    Ins_Mem[25] = 8'b00000000; // Jump 3;    08000003        PC = 1c
    Ins_Mem[26] = 8'b00000000;
    Ins_Mem[27] = 8'b00000011;
    
    Ins_Mem[28] = 8'b10101100;           
    Ins_Mem[29] = 8'b01000001; // SW reg1,4(reg 2); ac410004   PC = 20                
    Ins_Mem[30] = 8'b00000000;
    Ins_Mem[31] = 8'b00000100;
    
    Ins_Mem[32] = 8'b00000000;
    Ins_Mem[33] = 8'b01100000; // ADD reg1,reg3,reg0; 00600820  PC = 24
    Ins_Mem[34] = 8'b00001000;
    Ins_Mem[35] = 8'b00100000;
    
    Ins_Mem[36]  = 8'b10001100;
    Ins_Mem[37]  = 8'b01000011; // LW reg3,4(reg2); 8c4   PC = 28
    Ins_Mem[38]  = 8'b00000000;         
    Ins_Mem[39]  = 8'b00000100;
    
    Ins_Mem[40] = 8'b00001000;           
    Ins_Mem[41] = 8'b00000000; // Jump 3;        08000003     PC = 2c
    Ins_Mem[42] = 8'b00000000;
    Ins_Mem[43] = 8'b00000011;
    
    Ins_Mem[44] = 8'b10101100;           
    Ins_Mem[45] = 8'b01000001; // SW reg1,6(reg 2); ac440004   PC = 30
    Ins_Mem[46] = 8'b00000000;
    Ins_Mem[47] = 8'b00000110;    
                                               
    
end
always@(*)begin
    reg_ins <= {Ins_Mem[Badd], Ins_Mem[Badd + 1], Ins_Mem[Badd + 2], Ins_Mem[Badd + 3]};
    reg_ins_jmp <= {Ins_Mem[Jmp_add - 4], Ins_Mem[Jmp_add - 3], Ins_Mem[Jmp_add - 2], Ins_Mem[Jmp_add - 1]};
end

always@(*)begin
    stall_B_reg <= IFID_stall_B;
end
always @(posedge clk) begin
    if (reset) begin
        PC <= 32'b0;
        instruction <= 32'bx;
//    end else if (PC >= 64) begin
//        PC <= 32'b0;
//        instruction <= 32'bx;
    end else if (!stall && !stall_B_reg) begin
        if (PCSrc) begin
            PC <= Badd+4;
            instruction <= reg_ins;
        end else if(IDEX_Jmp)begin
            PC <= Jmp_add;
            instruction <= reg_ins_jmp;           
        end else begin
            PC <= PC + 4;
            instruction <= {Ins_Mem[PC], Ins_Mem[PC + 1], Ins_Mem[PC + 2], Ins_Mem[PC + 3]};
        end
//        if (!reset && !stall && PC < 40 && !stall_B_reg) begin
//            instruction <= {Ins_Mem[PC], Ins_Mem[PC + 1], Ins_Mem[PC + 2], Ins_Mem[PC + 3]};
//            $display("PC: %d", PC);
//            $display("instruction: %d", instruction);
//        end
    end
end
//always @(posedge clk)begin
//    if(reset || PC >= 40)begin 
//        PC <= 32'b0;
//        instruction <= 32'bx;
//    end
//    else if (PCSrc == 1)begin
//        PC <= Badd +4;
//        instruction <= {Ins_Mem[PC], Ins_Mem[PC + 1], Ins_Mem[PC + 2], Ins_Mem[PC + 3]};
//    end
//    else begin
//        if(PC < 40)begin
//            if(stall == 0)begin
//                PC <= PC +4;
//                instruction <= {Ins_Mem[PC], Ins_Mem[PC + 1], Ins_Mem[PC + 2], Ins_Mem[PC + 3]};
//            end
//        end
//    end
////    if(!reset && PC <= 40)begin
////        if(stall == 0 && IFID_stall_B == 0)begin
////            instruction <= {Ins_Mem[PC], Ins_Mem[PC + 1], Ins_Mem[PC + 2], Ins_Mem[PC + 3]};
////        end
////        else instruction <= 32'bx;
////    end
     
//end

endmodule
