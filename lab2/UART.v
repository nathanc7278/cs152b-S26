
module UART(

    );

endmodule

module rx(
    input wire clk,
    input wire rst,
    input wire rx_line,
    output reg [7:0] data
    );
wire [3:0] states = 4'b0000;        // 0 is IDLE, 1 to 8 is DATA, 9 is buffer

always @(posedge clk or posedge rst) begin
    if (rst) begin
        states <= 4'b0000;
    end else begin
        case (states)
            4'b0000: begin
                if (rx_line == 1) 
                    states <= 4'b0000;
                else
                    states <= 4'b0001;

            end
    end
end


endmodule

module tx(
    input wire clk,
    input wire rst,
    input wire [7:0] data,
    output wire tx_line
    );

endmodule