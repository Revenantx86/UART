`timescale 1ns / 1ps

module rx_module_tb;

// General Pins
reg clk;
reg rst;

// ** Instantiate baud rate generator ** //
reg [15:0] dvsr;
wire b_en;
wire b_clk;

baud_gen # (.DIV_W(16))
    baud_gen 
            (
                .clk(clk),
                .rst(rst),
                .DIVxR(dvsr),
                .b_clk(b_clk),
                .b_en(b_en)
            );
// ** //

// ** Instantiate the FIFO module ** //
wire ff_wr_en;
reg ff_rd_en;
reg [7:0] ff_data_in;
wire [7:0] ff_data_out;
wire ff_full;
wire ff_empty;

fifo #(.D_W(8), .DEPTH(64)) 
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
reg rx_data;

uart_rx #(.D_W(8), .B_TICK(16)) 
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


// --- TEST BENCH --- //

// Clock Generation & Initial declarations
initial begin
    clk = 0;
    forever #5 clk = ~clk; // 100 MHz Clock
end

initial begin
    // Initialize Inputs
    rst = 1;
    dvsr = 16'd54; // Example value for baud rate of 115200 Baud Rate
    rx_data = 1; // Typically idle high

    ff_rd_en = 0;

    #10 rst = 0; // Release reset

    // Send a byte (for example 0x55)
    // Assuming LSB first transmission
    // Start bit
    #8680 rx_data = 0; // Start bit
    // Byte data
    #8680 rx_data = 1; // Bit 0
    #8680 rx_data = 0; // Bit 1
    #8680 rx_data = 1; // Bit 2
    #8680 rx_data = 0; // Bit 3
    #8680 rx_data = 1; // Bit 4
    #8680 rx_data = 0; // Bit 5
    #8680 rx_data = 1; // Bit 6
    #8680 rx_data = 1; // Bit 7
    // Stop bit
    #8680 rx_data = 1; // Stop bit
    #10000; // Wait for some time after transmission
    
    // Send a byte (for example 0x55)
    // Assuming LSB first transmission
    // Start bit
    #8680 rx_data = 0; // Start bit
    // Byte data
    #8680 rx_data = 1; // Bit 0
    #8680 rx_data = 1; // Bit 1
    #8680 rx_data = 1; // Bit 2
    #8680 rx_data = 1; // Bit 3
    #8680 rx_data = 1; // Bit 4
    #8680 rx_data = 0; // Bit 5
    #8680 rx_data = 1; // Bit 6
    #8680 rx_data = 1; // Bit 7
    // Stop bit
    #8680 rx_data = 1; // Stop bit
    #10000; // Wait for some time after transmission


    #8680;
    // Read data from the FIFO
    if (!ff_empty) ff_rd_en = 1; // If FIFO is not empty, enable read
    #10;
    ff_rd_en = 0; // Ensure read enable is disabled
    #8680;
    if (!ff_empty) ff_rd_en = 1; // If FIFO is not empty, enable read
    #10;
    ff_rd_en = 0; // Ensure read enable is disabled
    #10000;

    #100;
    $finish; // End simulation
end

// Detailed Monitoring to Observe Ticks
initial begin
    // Initialize VCD dump
    $dumpfile("test/rx_module/uart_rx_module.vcd");
    $dumpvars(0, rx_module_tb);
end

endmodule
