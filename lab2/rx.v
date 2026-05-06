`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/24/2026 12:49:32 PM
// Design Name: 
// Module Name: rx
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

module rx(
    input wire clk,
    input wire rst,
    input wire rx_line,
    output reg [7:0] data
    );
    reg [3:0] states = 4'b0000;        // 0 is IDLE, 1 to 8 is DATA, 9 is buffer
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            states <= 4'b0000;
            data <= 8'b0;
        end else begin
            case (states)
                4'b0000: begin
                    if (rx_line == 0) 
                        states <= 4'b0001;
                end
                4'b0001: begin
                    data[0] <= rx_line;
                    states <= 4'b0010;
                end
                4'b0010: begin
                    data[1] <= rx_line;
                    states <= 4'b0011;
                end
                4'b0011: begin
                    data[2] <= rx_line;
                    states <= 4'b0100;
                end
                4'b0100: begin
                    data[3] <= rx_line;
                    states <= 4'b0101;
                end
                4'b0101: begin
                    data[4] <= rx_line;
                    states <= 4'b0110;
                end
                4'b0110: begin
                    data[5] <= rx_line;
                    states <= 4'b0111;
                end
                4'b0111: begin
                    data[6] <= rx_line;
                    states <= 4'b1000;
                end
                4'b1000: begin
                    data[7] <= rx_line;
                    states <= 4'b1001;
                end
                4'b1001: begin
                    if (rx_line == 1) 
                        states <= 4'b0000;
                    else
                        states <= 4'b1001;
                end
                default: begin
                    states <= 4'b0000;
                end 
            endcase
        end
    end
endmodule
