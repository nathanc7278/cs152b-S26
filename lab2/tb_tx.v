`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/27/2026 10:10:51 AM
// Design Name: 
// Module Name: tb_tx
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


module tb_tx;

reg rst;
reg clk;
reg ts;
reg [7:0] tx_data;
wire tx_line;

tx uut(
    .clk(clk),
    .rst(rst),
    .transmit_start(ts),
    .data(tx_data),
    .tx_line(tx_line)
    );
    
always #5 clk = ~clk;

initial begin  
    // transmit data:
    clk = 0;
    rst = 1;
    ts = 0;
    tx_data = 8'b00000000;
    #10
    rst = 0;
    tx_data = 8'b10001000;
    ts = 1;
    
    #100
    ts = 0;
    #10
    tx_data = 8'b00000000;
    ts = 1;
    #10
    ts = 0;
    #20
    rst = 1;
    #10
    rst = 0;
    #100
    $finish;
end  
endmodule
