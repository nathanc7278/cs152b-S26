`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/30/2026 11:50:42 AM
// Design Name: 
// Module Name: testbench
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


module testbench;

reg slow_clk;
reg rst;
wire [3:0] count;

always #5 slow_clk = ~slow_clk;

counter uut(
    .slow_clk(slow_clk),
    .rst(rst),
    .count(count)
    );
 
initial begin
    slow_clk = 0;
    rst = 1;
    #5
    rst = 0;
    #180
    rst = 1;
    #5
    rst = 0;
    #180
    $finish;
end

endmodule
