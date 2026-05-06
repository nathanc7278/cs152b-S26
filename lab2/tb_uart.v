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


module tb_uart;

reg clk;
reg ts;
reg rst;   
reg [7:0] sw; 
reg JA_rx;
wire JA_tx;
wire [7:0] led;

always #5 clk = ~clk;

// 1 baud period = 2 * 5208 * 10ns = 104,160ns
localparam BAUD = 104160;

UART uut(
    .clk(clk),
    .btnC(ts),
    .btnR(rst),
    .sw(sw),
    .JA_rx(JA_tx),
    .JA_tx(JA_tx),
    .led(led)
    );



initial begin
    clk = 0;
    rst = 1;
    ts = 0;
    sw = 8'b00001111;
    #100;
    rst = 0;
    #(BAUD * 2);
    ts = 1;
    #(BAUD);
    ts  = 0;
    #(BAUD * 15);
    $finish;
end

endmodule
