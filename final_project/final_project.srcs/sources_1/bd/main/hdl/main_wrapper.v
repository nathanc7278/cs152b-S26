//Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2018.2.2 (win64) Build 2348494 Mon Oct  1 18:25:44 MDT 2018
//Date        : Fri May 29 16:26:57 2026
//Host        : LAPTOP-F29JKP8H running 64-bit major release  (build 9200)
//Command     : generate_target main_wrapper.bd
//Design      : main_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module main_wrapper
   (clk,
    reset,
    usb_uart_rxd,
    usb_uart_txd);
  input clk;
  input reset;
  input usb_uart_rxd;
  output usb_uart_txd;

  wire clk;
  wire reset;
  wire usb_uart_rxd;
  wire usb_uart_txd;

  main main_i
       (.clk(clk),
        .reset(reset),
        .usb_uart_rxd(usb_uart_rxd),
        .usb_uart_txd(usb_uart_txd));
endmodule
