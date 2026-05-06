`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/27/2026 10:13:39 AM
// Design Name: 
// Module Name: tb_rx
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


module tb_rx;

reg rst;
reg clk;
reg rx_line;    
wire [7:0] rx_data;

rx uut(
    .clk(clk),
    .rst(rst),
    .rx_line(rx_line),
    .data(rx_data)
    );
    
always #5 clk = ~clk;
initial begin
    clk = 0;
     
    rst = 1;
    rx_line = 1;
     
    #10
    rx_line = 0;
    rst = 0;
    #10
    // receive data:
    rx_line = 1;
    #10
    rx_line = 1;
    #10
    rx_line = 1;
    #10
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
    rx_line = 1;
    #50
    
    #10
    rx_line = 0;
    #10
    rx_line = 1;
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
    rx_line = 0;
    #10
    rx_line = 1;
    #10
    rx_line = 0;
    #10
    rx_line = 0;
    #10
    rx_line = 1;
    #10
     

    $finish;
end 
 
endmodule
