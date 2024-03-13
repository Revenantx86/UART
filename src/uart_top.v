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

module uart_top# 
( 
    parameter D_W = 8,
    parameter B_TICK = 16,
    parameter DEPTH = 64,
    parameter DIV_W = 16
) 
(
    // Master wires
    input wire      clk,
    input wire      rst,

    // RX-Channel I&O
    input  wire     rx_data,

    // AXI Read

    // AXI Write
    
    //FIFO Test
    input wire fifo_rx_rd_en,
    output wire [D_W-1:0] fifo_rx_data_out,
    output wire fifo_rx_empty
);
//
//------------------------//     
//      Wire & Regs       //
//------------------------//     
//
// Read Channel FIFO
wire             fifo_rx_wr_en;
//wire             fifo_rx_rd_en;
wire [D_W-1:0]   fifo_rx_data_in;
//wire [D_W-1:0]   fifo_rx_data_out;
wire             fifo_rx_full;
//wire             fifo_rx_empty;
//
// Transmit Channel FIFO
wire             fifo_tx_wr_en;
wire             fifo_tx_rd_en;
wire  [D_W-1:0]  fifo_tx_data_in;
wire  [D_W-1:0]  fifo_tx_data_out;
//
// Baud Generator 
reg  [DIV_W-1:0]  DIVxR;
wire              b_clk;
wire              b_en;
//
//------------------------//     
//   BAUD CLK Generator   //
//------------------------// 
baud_gen # (.DIV_W(DIV_W))
    baud_gen_inst   (
                    .clk(clk),
                    .rst(rst),
                    .DIVxR(DIVxR),
                    .b_clk(b_clk),
                    .b_en(b_en)
                    );
//------------------------//     
//    FIFO Instatiation   //
//------------------------//    
fifo #(.D_W(D_W), .DEPTH(DEPTH)) 
    fifo_rx_inst    (
                    .clk(clk),
                    .rst(rst),
                    .wr_en(fifo_rx_wr_en),
                    .rd_en(fifo_rx_rd_en),
                    .data_in(fifo_rx_data_in),
                    .data_out(fifo_rx_data_out),
                    .full(fifo_rx_full),
                    .empty(fifo_rx_empty)
                    );
fifo #(.D_W(D_W), .DEPTH(DEPTH)) 
    fifo_tx_inst    (
                    .clk(clk),
                    .rst(rst),
                    .wr_en(fifo_tx_wr_en),
                    .rd_en(fifo_tx_rd_en),
                    .data_in(fifo_tx_data_in),
                    .data_out(fifo_tx_data_out),
                    .full(fifo_tx_full),
                    .empty(fifo_tx_empty)
                    );
//------------------------//     
//   RX-TX Instatiation   //
//------------------------//    
uart_rx #(.D_W(D_W), .B_TICK(B_TICK))
    uart_rx_inst    (
                    .rst(rst),
                    .clk(clk),
                    .baud_clk(b_clk),
                    .rx_data(rx_data),
                    .baud_en(b_en),
                    .out_data(fifo_rx_data_in),
                    //
                    .ff_full(fifo_rx_full),
                    .ff_wr_en(fifo_rx_wr_en)
                    );
//-------------------------------//     
//      AXI Control Logic       //
//-----------------------------//    

always @(posedge clk ) begin

    if(rst) begin
        DIVxR = 16'd54; // Example value for baud rate of 115200 Baud Rate
    end

end



endmodule