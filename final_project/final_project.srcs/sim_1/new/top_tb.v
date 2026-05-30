`timescale 1ns / 1ps

// Testbench for top level module
module top_tb(
    );
    
    reg clk;
    reg clr;
    reg p_clk;
    reg begin_transmit;
    reg cam_hsync;
    reg cam_vsync;
    reg [7:0] cam_data;
    wire xclk;
    wire pwdn;
    wire reset;
    wire hsync;
    wire vsync;
    wire [3:0] red;
    wire [3:0] green;
    wire [3:0] blue;
    wire debug;
    wire debug2;
    wire debug3;
    wire txd;
    
    top_mod t(
        .clk(clk),
        .clr(clr),
        .p_clk(p_clk),
        .begin_transmit(begin_transmit),
        .cam_hsync(cam_hsync),
        .cam_vsync(cam_vsync),
        .cam_data(cam_data),
        .xclk(xclk),
        .pwdn(pwdn),
        .reset(reset),
        .hsync(hsync),
        .vsync(vsync),
        .red(red),
        .green(green),
        .blue(blue),
        .debug(debug),
        .debug2(debug2),
        .debug3(debug3),
        .txd(txd)
    );

    initial
    begin
        clk <= 1'b0;
        clr <= 1'b1;
        cam_data <= 0;
        p_clk <= 0;
        cam_hsync <= 0;
        cam_vsync <= 1;
        begin_transmit <= 0;
        
        # 10
        cam_vsync <= 0; // Camera frame begins
        
        # 10
        cam_hsync <= 1; // Camera row begins
        
        # 5
        clr <= 1'b0;    // Begin transmitting
        begin_transmit <= 1;
    end
    
    always
    begin
        # 2 cam_data <= 1 + cam_data;
    end
    
    always
    begin
        # 8 p_clk <= ~p_clk;
    end
    
    always
    begin
        # 2 clk <= ~clk;
    end
endmodule
