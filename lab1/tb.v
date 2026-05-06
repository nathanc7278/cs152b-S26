`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/10/2026 01:36:29 PM
// Design Name: 
// Module Name: tb
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


module tb;

reg [3:0] ALUCtrl;
reg [15:0] A, B;
wire overflow_flag, zero_flag;
wire [15:0] S;

ALU uut(
    .ALUCtrl(ALUCtrl),
    .A(A),
    .B(B),
    .overflow_flag(overflow_flag),
    .zero_flag(zero_flag),
    .S(S)
);

initial begin

    // ADD Module
    ALUCtrl = 4'b0001;

    // 0 + 0 = 0, zero_flag = 1, overflow = 0
    A = 16'h0000; B = 16'h0000;
    #5

    // 1 + 1 = 2, zero_flag = 0, overflow = 0
    A = 16'h0001; B = 16'h0001;
    #5

    // -1 + 1 = 0, zero_flag = 1, overflow = 0
    A = 16'hFFFF; B = 16'h0001;
    #5

    // INT_MAX + INT_MAX = -2, zero_flag = 0, overflow = 1
    A = 16'h7FFF; B = 16'h7FFF;
    #5

    // INT_MIN + INT_MIN = 0; zero_flag = 1, overflow = 1
    A = 16'h8000; B = 16'h8000;
    #5

    // Sub Module
    ALUCtrl = 4'b0000;

    // 0 - 0 = 0, zero_flag = 1, overflow = 0
    A = 16'h0000; B = 16'h0000;
    #5

    // 3 - 2 = 1, zero_flag = 0, overflow = 0
    A = 16'h0003; B = 16'h0002;
    #5
    
    // 3 - 5 = -2, zero_flag = 0, overflow = 0 (-2 is hFFFE)
    A = 16'h0003; B = 16'h0005;
    #5

    // INT_MIN - 1 = 16'h7FFF, zero_flag = 0, overflow = 1
    A = 16'h8000; B = 16'h0001;
    #5

    // 7 - 7 = 0, zero_flag = 1, overflow = 0
    A = 16'h0007; B = 16'h0007;
    #5
    
    // Decrement Module
    ALUCtrl = 4'b0100;
    
    // 1 - 1 = 0, zero_flag = 1, overflow = 0
    A = 16'h0001;
    #5
    
    // 0 - 1  = -1, zero_flag = 0, overflow = 0
    A = 16'h0000;
    #5
    
    //INT_MIN - 1 = positive, zero_flag = 0, overflow = 1
    A = 16'h8000;
    #5
    
    // Increment Module
    ALUCtrl = 4'b0101;
    
    // 1 + 1 = 2, zero_flag = 0, overflow = 0
    A = 16'h0001;
    #5
    
    // -1 + 1  = 0, zero_flag = 1, overflow = 0
    A = 16'hFFFF;
    #5
    
    //INT_MAX + 1 = negative, zero_flag = 0, overflow = 1
    A = 16'h7FFF;
    #5
    
    // Two's Complement Invert Module
    ALUCtrl = 4'b0110;
    
    // invert 0 = 0, zero_flag = 1, overflow = 0
    A = 16'h0000;
    #5
    
    // invert INT_MIN = INT_MIN, zero_flag = 0, overflow = 1
    A = 16'h8000;
    #5
    
    // invert 1 = FFFF, zero_flag = 0, overflow = 0
    A = 16'h0001;
    #5
    
    // Arithmetic Shift Left
    ALUCtrl = 4'b1100;
    
    // shift 1 by 1 = 16'h0002, zero_flag = 0, overflow = 0
    A = 16'h0001;
    B = 16'h0001;
    #5
    
    // shift 1 by 16 = 16'h0000, zero_flag = 1, overflow = 0
    A = 16'h0001;
    B = 16'h0010;
    #5
    // shift 1 by 15 = 16'h8000, zero_flag = 0, overflow = 1
    A = 16'h0001;
    B = 16'h000F;
    #5
    
    // Arithmetic Shift Right
    ALUCtrl = 4'b1110;
    
    // shift 1 by 1 = 16'h0000, zero_flag = 1, overflow = 0
    A = 16'h0001;
    B = 16'h0001;
    #5
    
    // shift INT_MIN by 1 = 16'hC000, zero_flag = 0, overflow = 0
    A = 16'h8000;
    B = 16'h0001;
    #5
    
    // shift INT_MIN by 15 = 16'hFFFF, zero_flag = 0, overflow = 0
    A = 16'h8000;
    B = 16'h000F;
    #5
    
    // Set Less than or Equal
    ALUCtrl = 4'b1001;
    
    // 0 <= 1 = 1, zero_flag = 0
    A = 16'h0000;
    B = 16'h0001;
    #5
    
    // 1 <= 1 = 1, zero_flag = 0
    A = 16'h0001;
    B = 16'h0001;
    #5
    
    // -1 <= INT_MIN = 0, zero_flag = 1
    A = 16'hFFFF;
    B = 16'h8000;
    #5
    
    // INT_MIN <= -1 = 1, zero_flag = 0
    A = 16'h8000;
    B = 16'hFFFF;
    #5
    
    // Bitwise OR
    ALUCtrl = 4'b0010;
    
    // -1 OR 0 = -1, zero_flag = 0
    A = 16'h0000;
    B = 16'hFFFF;
    #5
    
    // 0 OR 0 = 0, zero_flag = 1
    A = 16'h0000;
    B = 16'h0000;
    #5
    
    // INT_MAX OR INT_MIN = -1, zero_flag = 0
    A = 16'h7FFF;
    B = 16'h8000;
    #5
    
    // Bitwise AND
    ALUCtrl = 4'b0011;
    
    // -1 AND 0 = 0, zero_flag = 1
    A = 16'h0000;
    B = 16'hFFFF;
    #5
    
    // 0 AND 0 = 0, zero_flag = 1
    A = 16'h0000;
    B = 16'h0000;
    #5
    
    // INT_MAX AND INT_MIN = 0, zero_flag = 1
    A = 16'h7FFF;
    B = 16'h8000;
    #5
    
    // -1 AND INT_MIN = INT_MIN, zero_flag = 0
    A = 16'hFFFF;
    B = 16'h8000;
    #5
    
    // Logical Shift Left
    ALUCtrl = 4'b1000;
    
    // shift 1 by 1 = 16'h0002, zero_flag = 0
    A = 16'h0001;
    B = 16'h0001;
    #5
    
    // shift 1 by 16 = 16'h0000, zero_flag = 1
    A = 16'h0001;
    B = 16'h0010;
    #5
    // shift 1 by 15 = 16'h8000, zero_flag = 0
    A = 16'h0001;
    B = 16'h000F;
    #5
    
    // Logical Shift Right
    ALUCtrl = 4'b1010;
    
    // shift 1 by 1 = 16'h0000, zero_flag = 1
    A = 16'h0001;
    B = 16'h0001;
    #5
    
    // shift INT_MIN by 1 = 16'h4000, zero_flag = 0
    A = 16'h8000;
    B = 16'h0001;
    #5
    
    // shift INT_MIN by 15 = 16'h0001, zero_flag = 0
    A = 16'h8000;
    B = 16'h000F;
    #5
    
    // shift INT_MIN by 16 = 16'h0000, zero_flag = 1
    A = 16'h8000;
    B = 16'h0010;
    #5
    
    $finish;
end

endmodule
