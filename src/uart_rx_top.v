module uart_rx_top 
    # ( parameter D_W = 8, parameter B_TICK = 16, parameter DEPTH = 64)
    (
        input wire rst,
        input wire clk,
        // rx module input & outputs
        input wire b_clk,
        input wire rx_data,
        output wire b_en,

        // fifo module input & outputs
        input wire rd_en,
        output wire ff_data_out,
        output wire ff_empty,
        output wire ff_full
    )

    // ** Instantiate the FIFO module ** //
    wire ff_wr_en;
    reg ff_rd_en;
    reg [D_W-1:0] ff_data_in;
    wire [D_W-1:0] ff_data_out;
    wire ff_full;
    wire ff_empty;

    fifo #(.D_W(D_W), .DEPTH(DEPTH)) 
        fifo_rx 
                (
                    .clk(clk),
                    .rst(rst),
                    .wr_en(ff_wr_en),
                    .rd_en(ff_rd_en),
                    .data_in(ff_data_in),
                    .data_out(ff_data_out),
                    .full(ff_full),
                    .empty(ff_empty)
                );
    // ** //

    // ** Instantiate the rx module ** //
    uart_rx #(.D_W(D_W), .B_TICK(B_TICK)) 
        uart_rx (
                    .clk(clk),
                    .rst(rst),
                    .baud_clk(b_clk),
                    .rx_data(rx_data),
                    .baud_en(b_en),
                    .out_data(ff_data_in),
                    .ff_full(ff_full),
                    .ff_wr_en(ff_wr_en)
        );
    // ** //



endmodule