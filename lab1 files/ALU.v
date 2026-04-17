`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/06/2026 10:49:32 AM
// Design Name: 
// Module Name: ALU
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

module ALU(
    input wire [3:0] ALUCtrl,
    input wire [15:0] A,
    input wire [15:0] B,
    output wire overflow_flag,
    output wire zero_flag,
    output wire [15:0] S
    );
    
    wire [16:0] sub, add, dec, inc, inv, asl, asr, slte, bit_or, bit_and, lsl, lsr;
    wire [15:0] mux_out;
    wire [15:0] zero;
    subtract sub_module(
        .A(A),
        .B(B),
        .overflow(sub[16]),
        .S(sub[15:0])
    );
    add add_module(
        .A(A),
        .B(B),
        .overflow(add[16]),
        .S(add[15:0])
    );
    decrement dec_module(
        .A(A),
        .overflow(dec[16]),
        .S(dec[15:0])
    );
    increment inc_module(
        .A(A),
        .overflow(inc[16]),
        .S(inc[15:0])
    );
    invert inv_module(
        .A(A),
        .overflow(inv[16]),
        .inverted(inv[15:0])
    ); 
    arithmetic_shift_left asl_module(
        .A(A),
        .B(B),
        .overflow(asl[16]),
        .shifted(asl[15:0])
    ); 
    arithmetic_shift_right asr_module(
        .A(A),
        .B(B),
        .overflow(asr[16]),
        .shifted(asr[15:0])
    ); 
    bitwise_or bit_or_module(
        .A(A),
        .B(B),
        .Result(bit_or[15:0])
    ); 
    assign bit_or[16] = 0;
    bitwise_and bit_and_module(
        .A(A),
        .B(B),
        .Result(bit_and[15:0])
    ); 
    assign bit_and[16] = 0;
    logical_shift_left lsl_module(
        .A(A),
        .B(B),
        .shifted(lsl[15:0])
    ); 
    assign lsl[16] = 0;
    set_less_than_or_equal slte_module(
        .A(A),
        .B(B),
        .Result(slte[0])
    );
    assign slte[15:1] = 15'b0;
    assign slte[16] = 0;
    logical_shift_right lsr_module(
        .A(A),
        .B(B),
        .shifted(lsr[15:0])
    ); 
    assign lsr[16] = 0;
    
    genvar i;
    generate
        for(i=0; i < 16; i=i+1) begin
            Sixteen_to_One_Mux Mux0(
                .Select(ALUCtrl),
                .D0(sub[i]),
                .D1(add[i]),
                .D2(bit_or[i]),
                .D3(bit_and[i]),
                .D4(dec[i]),
                .D5(inc[i]),
                .D6(inv[i]),
                .D7(1'b0),
                .D8(lsl[i]),
                .D9(slte[i]),
                .D10(lsr[i]),
                .D11(1'b0),
                .D12(asl[i]),
                .D13(1'b0),
                .D14(asr[i]),
                .D15(1'b0),
                .Result(mux_out[i])
            );
        end
    endgenerate
    Sixteen_to_One_Mux Mux1(
        .Select(ALUCtrl),
        .D0(sub[16]),
        .D1(add[16]),
        .D2(bit_or[16]),
        .D3(bit_and[16]),
        .D4(dec[16]),
        .D5(inc[16]),
        .D6(inv[16]),
        .D7(1'b0),
        .D8(lsl[16]),
        .D9(slte[16]),
        .D10(lsr[16]),
        .D11(1'b0),
        .D12(asl[16]),
        .D13(1'b0),
        .D14(asr[16]),
        .D15(1'b0),
        .Result(overflow_flag)
    );
    
    or(zero[0], mux_out[0], 1'b0);
    genvar j;
    generate
        for(j=1; j<16; j=j+1) begin
            or(zero[j], zero[j-1], mux_out[j]);
        end
    endgenerate
    not(zero_flag, zero[15]);
    
    assign S = mux_out;
endmodule
