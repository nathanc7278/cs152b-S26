`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/30/2026 11:24:08 AM
// Design Name: 
// Module Name: counter
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

module clk_divider(
    input wire clk,
    input wire rst,
    output wire out_clk
    );
    reg slow_clk = 0;
    reg [26:0] ctr = 0;
    localparam div = 50_000_000;
    
   
    always @(posedge clk) begin
        if (rst) begin
            ctr <= 0;
            slow_clk <= 0;
        end
        if (ctr > div) begin
            slow_clk <= ~slow_clk;
            ctr <= 0;
        end else begin
            ctr <= ctr + 1;
        end
    end
    
    assign out_clk = slow_clk;
endmodule


module counter(
    input wire slow_clk,
    input wire rst,
    output wire [3:0] count
    );
    
    reg [3:0] count_val = 0;    
    always @(posedge slow_clk or posedge rst) begin
        if (rst) begin
            count_val <= 0;
        end else if (count_val > 15) begin
            count_val <= 0;
        end else begin
            count_val <= count_val + 1;
        end
    end
    
    assign count = count_val;
endmodule
