`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/22/2026 10:27:55 AM
// Design Name: 
// Module Name: UART
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



module UART(
    input wire clk,
    input wire btnC,
    input wire btnR,
    input wire [7:0] sw,
    input wire JA_rx,
    output wire JA_tx,
    output wire [7:0] led
    );
    wire slow_clk;
    clk_divider divider(
        .clk(clk),
        .rst(btnR),
        .out_clk(slow_clk)
    );
    rx rx(
        .clk(slow_clk),
        .rst(btnR),
        .rx_line(JA_rx),
        .data(led)
        );
        
    tx tx(
        .clk(slow_clk),
        .rst(btnR),
        .transmit_start(btnC),
        .data(sw),
        .tx_line(JA_tx)
        );
endmodule

module clk_divider(
    input wire clk,
    input wire rst,
    output wire out_clk
    );
    reg slow_clk;
    reg [26:0] ctr = 0;
    // 9600 bits/s = 100_000_000 / (2 * div)
    localparam div = 5208;
    // 115200 bits/s
    // localparam div = 434;
    always @(posedge clk or posedge rst) begin
        if (rst) begin
	       slow_clk <= 0;
           ctr <= 0;
	    end else begin
	        if (ctr >= div) begin
                slow_clk <= ~slow_clk;
                ctr <= 0;
            end else begin
                ctr <= ctr + 1;
            end
        end
    end
    assign out_clk = slow_clk;
endmodule