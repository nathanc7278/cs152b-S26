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

    );

endmodule

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
                if (rx_line == 1) 
                    states <= 4'b0000;
                else
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
        endcase
    end
end


endmodule

module tx(
    input wire clk,
    input wire rst,
    input wire transmit_start,
    input wire [7:0] data,
    output wire tx_line
    );
reg [3:0] states = 4'b0000;        // 0 is IDLE, 1 to 8 is DATA, 9 is buffer
reg tx_line_val;
always @(posedge clk or posedge rst) begin
    if (rst) begin
        states <= 4'b0000;
        tx_line_val <= 1;
    end else begin
        case (states)
            4'b0000: begin
                if (transmit_start == 1) begin
                    tx_line_val <= 0;
                    states <= 4'b0001;
                end else
                    tx_line_val <= 1;
            end
            4'b0001: begin
                tx_line_val <= data[0];
                states <= 4'b0010;
            end
            4'b0010: begin
                tx_line_val <= data[1];
                states <= 4'b0011;
            end
            4'b0011: begin
                tx_line_val <= data[2];
                states <= 4'b0100;
            end
            4'b0100: begin
                tx_line_val <= data[3];
                states <= 4'b0101;
            end
            4'b0101: begin
                tx_line_val <= data[4];
                states <= 4'b0110;
            end
            4'b0110: begin
                tx_line_val <= data[5];
                states <= 4'b0111;
            end
            4'b0111: begin
                tx_line_val <= data[6];
                states <= 4'b1000;
            end
            4'b1000: begin
                tx_line_val <= data[7];
                states <= 4'b1001;
            end
            4'b1001: begin          // tx shouldn't transmit unless it reach idle state
                if (tx_line == 1) 
                    states <= 4'b1001;
                else
                    states <= 4'b0000;
            end
        endcase
    end
end
assign tx_line = tx_line_val;
endmodule
