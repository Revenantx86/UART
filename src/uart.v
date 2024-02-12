/*
 * ----------------------------------------------------------------------------
 * "THE BEER-WARE LICENSE" (Revision 42):
 * Refik Yalcin wrote this file. As long as you retain this notice you
 * can do whatever you want with this stuff. If we meet some day, and you think
 * this stuff is worth it, you can buy me a coffe or ginger ale in return.
 * ----------------------------------------------------------------------------
 *
 * File Name: uart.v
 *
 * Project: UART Communication module 
 *
 * Module Name: UART Top module 
 *
 * Description: <Universal asyncronus send/receive communicaiton protocol module implemented using verilog for gate level synthesis 
 *
 * Functional Description:
 * This file contains the top module construction of the all uart protocol modules
 *
 *
 * Revision History:
 * Rev 1.0 - <Date>, <Your Name> - Initial release
 *
 * Additional Notes:
 * - Note 1: Baud controller created
 *
 */

module uart # 
( 
    parameter D_W = 8,
    parameter B_TICK = 16
) 
(
    input wire clk,
    input wire rst,

    // -- Input UART -- //
    input wire rxd,

    // -- input to baud_gen -- //
        
    // -- uart rx -- //
    output wire [7:0] out_data,

    // -- uart tx -- //
    output wire txd,
    input wire [7:0] input_data,
    input wire tx_start,
    output wire tx_done
);

wire baud_clk;
wire baud_en;

wire fifo_rx_wr_en;
wire fifo_rx_rd_en;
wire fifo_rx_data_in;
wire fifo_rx_data_out;
wire fifo_rx_full;
wire fifo_rx_empty;

fifo #(.D_W(D_W), .DEPTH(64)) 
    fifo_rx (
            .clk(clk),
            .rst(rst),
            .wr_en(fifo_rx_wr_en),
            .rd_en(fifo_rx_rd_en),
            .data_in(fifo_rx_data_in),
            .data_out(fifo_rx_data_out),
            .full(fifo_rx_full),
            .empty(fifo_rx_empty)
            );

endmodule