`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/01/2026 11:11:24 AM
// Design Name: 
// Module Name: top_counter
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


module top_counter(
    input wire clk,
    input wire btnR,
    output wire [3:0] led
    );

wire slow_clk;
wire rst = btnR;
clk_divider divider(
    .clk(clk),
    .rst(btnR),
    .out_clk(slow_clk)
);

wire [3:0] led_val;
counter counter(
    .slow_clk(slow_clk),
    .rst(btnR),
    .count(led_val)
);

assign led = led_val;

endmodule
