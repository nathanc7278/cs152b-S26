`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/08/2026 10:11:20 AM
// Design Name: 
// Module Name: operations
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


module subtract(
    input wire [15:0] A,
    input wire [15:0] B,
    output wire overflow,
    output wire [15:0] S
    );
    wire [15:0] not_B;
    wire [15:0] Cout;
    wire inv_overflow;
    invert inv(B, inv_overflow, not_B);
    full_adder fa0(A[0], not_B[0], 1'b0, Cout[0], S[0]);
    genvar i;
    generate 
        for(i = 1; i < 16; i=i+1) begin
            full_adder fa(A[i], not_B[i], Cout[i-1], Cout[i], S[i]);
        end
    endgenerate
    xor(overflow, Cout[15], Cout[14]);
endmodule

module add(
    input wire [15:0] A,
    input wire [15:0] B,
    output wire overflow,
    output wire [15:0] S
    );
    wire [15:0] Cout;
    genvar i;
    full_adder fa0(A[0], B[0], 1'b0, Cout[0], S[0]);
    generate 
        for(i = 1; i < 16; i=i+1) begin
            full_adder fa1(A[i], B[i], Cout[i-1], Cout[i], S[i]);
        end
    endgenerate
    xor(overflow, Cout[15], Cout[14]);
endmodule

module full_adder(
    input wire A,
    input wire B,
    input wire Cin,
    output wire overflow,
    output wire S
    );
    wire xor_out, and0, and1;
    xor(xor_out, A, B);
    xor(S, xor_out, Cin);
    and(and0, Cin, xor_out);
    and(and1, A, B);
    or(overflow, and0, and1);
endmodule

module decrement(
    input wire [15:0] A,
    output wire overflow,
    output wire [15:0] S
    );
    subtract sub(A, 16'h0001, overflow, S);
endmodule

module increment(
    input wire [15:0] A,
    output wire overflow,
    output wire [15:0] S
    );
    add a(A, 16'h0001, overflow, S);
endmodule

module invert(
    input wire [15:0] A,
    output wire overflow,
    output wire [15:0] inverted
    );
    wire [15:0] ones_complement;
    genvar i;
    generate 
        for(i = 0; i < 16; i=i+1) begin
            not(ones_complement[i], A[i]);
        end
    endgenerate
    increment inc(ones_complement, overflow, inverted);
endmodule

module arithmetic_shift_left(
    input wire [15:0] A,
    input wire [15:0] B,
    output wire overflow,
    output wire [15:0] shifted
    );
    wire [15:0] shift1, shift2, shift3, shift4, 
                shift5, shift6, shift7, shift8, 
                shift9, shift10, shift11, shift12, 
                shift13, shift14, shift15;
    wire [15:0] result_of_16mux;            
    wire [11:0] B_greater_than_15;
    shift_left_1bit s1(A, shift1);
    shift_left_1bit s2(shift1, shift2);
    shift_left_1bit s3(shift2, shift3);
    shift_left_1bit s4(shift3, shift4);
    shift_left_1bit s5(shift4, shift5);
    shift_left_1bit s6(shift5, shift6);
    shift_left_1bit s7(shift6, shift7);
    shift_left_1bit s8(shift7, shift8);
    shift_left_1bit s9(shift8, shift9);
    shift_left_1bit s10(shift9, shift10);
    shift_left_1bit s11(shift10, shift11);
    shift_left_1bit s12(shift11, shift12);
    shift_left_1bit s13(shift12, shift13);
    shift_left_1bit s14(shift13, shift14);
    shift_left_1bit s15(shift14, shift15);
    
    genvar i;
    generate 
       for(i = 0; i < 16; i=i+1) begin
          Sixteen_to_One_Mux Mux0(
               .Select(B[3:0]),
               .D0(A[i]),
               .D1(shift1[i]),
               .D2(shift2[i]),
               .D3(shift3[i]),
               .D4(shift4[i]),
               .D5(shift5[i]),
               .D6(shift6[i]),
               .D7(shift7[i]),
               .D8(shift8[i]),
               .D9(shift9[i]),
               .D10(shift10[i]),
               .D11(shift11[i]),
               .D12(shift12[i]),
               .D13(shift13[i]),
               .D14(shift14[i]),
               .D15(shift15[i]),
               .Result(result_of_16mux[i])
          );
       end
    endgenerate

    or(B_greater_than_15[0], B[4], 1'b0);
    genvar j;
    generate
        for (j = 1; j < 12; j=j+1) begin
            or(B_greater_than_15[j], B_greater_than_15[j-1], B[j+4]);
        end
    endgenerate
    
    genvar k;
    generate
        for(k = 0; k < 16; k=k+1) begin
            Two_to_One_Mux Mux1(
                .Select(B_greater_than_15[11]),
                .D0(result_of_16mux[k]),
                .D1(1'b0),
                .Result(shifted[k])
            );
        end
    endgenerate
    
    assign overflow = shifted[15] ^ A[15]; 
    
endmodule

module shift_left_1bit(
    input wire [15:0] A,
    output wire [15:0] shifted_A
    );
    genvar i;
    generate
        for(i = 15; i > 0; i=i-1) begin
            assign shifted_A[i] = A[i-1];
        end
    endgenerate
    assign shifted_A[0] = 0;
endmodule

module arithmetic_shift_right(
    input wire [15:0] A,
    input wire [15:0] B,
    output wire overflow,
    output wire [15:0] shifted
    );
    wire [15:0] shift1, shift2, shift3, shift4, 
                shift5, shift6, shift7, shift8, 
                shift9, shift10, shift11, shift12, 
                shift13, shift14, shift15;
    wire [15:0] result_of_16mux;            
    wire [11:0] B_greater_than_15;
    arithmetic_shift_right_1bit s1(A, shift1);
    arithmetic_shift_right_1bit s2(shift1, shift2);
    arithmetic_shift_right_1bit s3(shift2, shift3);
    arithmetic_shift_right_1bit s4(shift3, shift4);
    arithmetic_shift_right_1bit s5(shift4, shift5);
    arithmetic_shift_right_1bit s6(shift5, shift6);
    arithmetic_shift_right_1bit s7(shift6, shift7);
    arithmetic_shift_right_1bit s8(shift7, shift8);
    arithmetic_shift_right_1bit s9(shift8, shift9);
    arithmetic_shift_right_1bit s10(shift9, shift10);
    arithmetic_shift_right_1bit s11(shift10, shift11);
    arithmetic_shift_right_1bit s12(shift11, shift12);
    arithmetic_shift_right_1bit s13(shift12, shift13);
    arithmetic_shift_right_1bit s14(shift13, shift14);
    arithmetic_shift_right_1bit s15(shift14, shift15);
    
    genvar i;
    generate 
       for(i = 0; i < 16; i=i+1) begin
          Sixteen_to_One_Mux Mux0(
               .Select(B[3:0]),
               .D0(A[i]),
               .D1(shift1[i]),
               .D2(shift2[i]),
               .D3(shift3[i]),
               .D4(shift4[i]),
               .D5(shift5[i]),
               .D6(shift6[i]),
               .D7(shift7[i]),
               .D8(shift8[i]),
               .D9(shift9[i]),
               .D10(shift10[i]),
               .D11(shift11[i]),
               .D12(shift12[i]),
               .D13(shift13[i]),
               .D14(shift14[i]),
               .D15(shift15[i]),
               .Result(result_of_16mux[i])
          );
       end
    endgenerate

    or(B_greater_than_15[0], B[4], 1'b0);
    genvar j;
    generate
        for (j = 1; j < 12; j=j+1) begin
            or(B_greater_than_15[j], B_greater_than_15[j-1], B[j+4]);
        end
    endgenerate
    
    genvar k;
    generate
        for(k = 0; k < 16; k=k+1) begin
            Two_to_One_Mux Mux1(
                .Select(B_greater_than_15[11]),
                .D0(result_of_16mux[k]),
                .D1(A[15]),
                .Result(shifted[k])
            );
        end
    endgenerate
    
    assign overflow = shifted[15] ^ A[15]; 
    
endmodule

module arithmetic_shift_right_1bit(
    input wire [15:0] A,
    output wire [15:0] shifted_A
    );
    genvar i;
    generate
        for(i = 0; i < 15; i=i+1) begin
            assign shifted_A[i] = A[i+1];
        end
    endgenerate
    assign shifted_A[15] = A[15];
endmodule

module set_less_than_or_equal (
    input wire [15:0] A,
    input wire [15:0] B,
    output wire Result
    );
    wire [15:0] subtraction; 
    wire [15:0] is_zero;
    wire different_signs, same_signs;
    wire and1;
    wire and2;
    wire overflow;
    subtract sub(
        .A(A),
        .B(B),
        .overflow(overflow),
        .S(subtraction)
        );
    not(is_zero[0], subtraction[0]);
    genvar i;
    generate
        for(i = 1; i < 16; i=i+1) begin
            wire not_subtract;
            not(not_subtract, subtraction[i]);
            and(is_zero[i], is_zero[i-1], not_subtract);
        end
    endgenerate
    
    xor(different_signs, A[15], B[15]);
    and(and1, different_signs, A[15]);
    
    not(same_signs, different_signs);
    and(and2, same_signs, subtraction[15]);
    
    or(Result, is_zero[15], and1, and2);
endmodule

module bitwise_or(
    input wire [15:0] A,
    input wire [15:0] B,
    output wire [15:0] Result
    );
    genvar i;
    generate
        for(i = 0; i < 16; i=i+1) begin
            or(Result[i], A[i], B[i]);
        end
    endgenerate 
endmodule

module bitwise_and(
    input wire [15:0] A,
    input wire [15:0] B,
    output wire [15:0] Result
    );
    genvar i;
    generate
        for(i = 0; i < 16; i=i+1) begin
            and(Result[i], A[i], B[i]);
        end
    endgenerate 
endmodule

module logical_shift_left(
    input wire [15:0] A,
    input wire [15:0] B,
    output wire [15:0] shifted
    );
    wire overflow;
    arithmetic_shift_left asl(
        .A(A),
        .B(B),
        .overflow(overflow),
        .shifted(shifted)
        );
endmodule

module logical_shift_right(
    input wire [15:0] A,
    input wire [15:0] B,
    output wire [15:0] shifted
    );
    wire [15:0] shift1, shift2, shift3, shift4, 
                shift5, shift6, shift7, shift8, 
                shift9, shift10, shift11, shift12, 
                shift13, shift14, shift15;
    wire [15:0] result_of_16mux;            
    wire [11:0] B_greater_than_15;
    logical_shift_right_1bit s1(A, shift1);
    logical_shift_right_1bit s2(shift1, shift2);
    logical_shift_right_1bit s3(shift2, shift3);
    logical_shift_right_1bit s4(shift3, shift4);
    logical_shift_right_1bit s5(shift4, shift5);
    logical_shift_right_1bit s6(shift5, shift6);
    logical_shift_right_1bit s7(shift6, shift7);
    logical_shift_right_1bit s8(shift7, shift8);
    logical_shift_right_1bit s9(shift8, shift9);
    logical_shift_right_1bit s10(shift9, shift10);
    logical_shift_right_1bit s11(shift10, shift11);
    logical_shift_right_1bit s12(shift11, shift12);
    logical_shift_right_1bit s13(shift12, shift13);
    logical_shift_right_1bit s14(shift13, shift14);
    logical_shift_right_1bit s15(shift14, shift15);
    
    genvar i;
    generate 
       for(i = 0; i < 16; i=i+1) begin
          Sixteen_to_One_Mux Mux0(
               .Select(B[3:0]),
               .D0(A[i]),
               .D1(shift1[i]),
               .D2(shift2[i]),
               .D3(shift3[i]),
               .D4(shift4[i]),
               .D5(shift5[i]),
               .D6(shift6[i]),
               .D7(shift7[i]),
               .D8(shift8[i]),
               .D9(shift9[i]),
               .D10(shift10[i]),
               .D11(shift11[i]),
               .D12(shift12[i]),
               .D13(shift13[i]),
               .D14(shift14[i]),
               .D15(shift15[i]),
               .Result(result_of_16mux[i])
          );
       end
    endgenerate

    or(B_greater_than_15[0], B[4], 1'b0);
    genvar j;
    generate
        for (j = 1; j < 12; j=j+1) begin
            or(B_greater_than_15[j], B_greater_than_15[j-1], B[j+4]);
        end
    endgenerate
    
    genvar k;
    generate
        for(k = 0; k < 16; k=k+1) begin
            Two_to_One_Mux Mux1(
                .Select(B_greater_than_15[11]),
                .D0(result_of_16mux[k]),
                .D1(1'b0),
                .Result(shifted[k])
            );
        end
    endgenerate
endmodule

module logical_shift_right_1bit(
    input wire [15:0] A,
    output wire [15:0] shifted_A
    );
    genvar i;
    generate
        for(i = 0; i < 15; i=i+1) begin
            assign shifted_A[i] = A[i+1];
        end
    endgenerate
    assign shifted_A[15] = 1'b0;
endmodule