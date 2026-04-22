`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/22/2026 10:54:04 AM
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

reg rst;
reg clk;
reg rx_line;    
wire [7:0] rx_data;

reg ts;
reg [7:0] tx_data;
wire tx_line;

always #5 clk = ~clk;

rx uut(
    .clk(clk),
    .rst(rst),
    .rx_line(rx_line),
    .rx_data(data)
    );
    
tx other_uut(
    .clk(clk),
    .rst(rst),
    .ts(transmit_start),
    .tx_data(data),
    .tx_line(tx_line)
    );
 
initial begin
    clk = 0;
    rst = 1;
    rx_line = 1;
    #10
    rst = 0;
    #20
    rx_line = 0;
    #10
    // receive data:
    rx_line = 1;
    #10
    rx_line = 0;
    #10
    rx_line = 0;
    #10
    rx_line = 0;
    #10
    rx_line = 0;
    #10
    rx_line = 0;
    #10
    rx_line = 1;
    #10
    rx_line = 1;
    #10
    rx_line = 0;
    #10
    rx_line = 1;
    #10
    
    clk = 0;
    rst = 1;
    ts = 1;
    tx_data = 8'b10001000;
    #10
    ts = 0;
    #100
    $finish;
end

endmodule
