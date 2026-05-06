`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/08/2026 11:23:55 AM
// Design Name: 
// Module Name: mux
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

module Two_to_One_Mux(
    input wire Select,
    input wire D0,
    input wire D1,
    output wire Result
    );
    wire not_s, and0, and1, and2, and3;
    not(not_s, Select);
    and(and0, not_s, D0);
    and(and1, Select, D1);
    or(Result, and0, and1);
endmodule

module Four_to_One_Mux(
    input wire [1:0] Select,
    input wire D0,
    input wire D1,
    input wire D2,
    input wire D3,
    output wire Result
    );
    wire not_s0, not_s1, and0, and1, and2, and3;
    not(not_s0, Select[0]);
    not(not_s1, Select[1]);
    and(and0, not_s0, not_s1, D0);
    and(and1, Select[0], not_s1, D1);
    and(and2, not_s0, Select[1], D2);
    and(and3, Select[0], Select[1], D3);
    or(Result, and0, and1, and2, and3);
endmodule

module Sixteen_to_One_Mux(
    input wire [3:0] Select,
    input wire D0,
    input wire D1,
    input wire D2,
    input wire D3,
    input wire D4,
    input wire D5,
    input wire D6,
    input wire D7,
    input wire D8,
    input wire D9,
    input wire D10,
    input wire D11,
    input wire D12,
    input wire D13,
    input wire D14,
    input wire D15,
    output wire Result
    );
    wire Mux0_out;
    Four_to_One_Mux Mux0(
        .Select(Select[1:0]),
        .D0(D0),
        .D1(D1),
        .D2(D2),
        .D3(D3),
        .Result(Mux0_out)
    );
    
    wire Mux1_out;
    Four_to_One_Mux Mux1(
        .Select(Select[1:0]),
        .D0(D4),
        .D1(D5),
        .D2(D6),
        .D3(D7),
        .Result(Mux1_out)
    );
    
    wire Mux2_out;
    Four_to_One_Mux Mux2(
        .Select(Select[1:0]),
        .D0(D8),
        .D1(D9),
        .D2(D10),
        .D3(D11),
        .Result(Mux2_out)
    );
    
    wire Mux3_out;
    Four_to_One_Mux Mux3(
        .Select(Select[1:0]),
        .D0(D12),
        .D1(D13),
        .D2(D14),
        .D3(D15),
        .Result(Mux3_out)
    );
    
    Four_to_One_Mux Mux4(
        .Select(Select[3:2]),
        .D0(Mux0_out),
        .D1(Mux1_out),
        .D2(Mux2_out),
        .D3(Mux3_out),
        .Result(Result)
    );
endmodule