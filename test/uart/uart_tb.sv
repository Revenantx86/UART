`timescale 1ns / 1ps

module uart_tb;

// General Pins
reg clk;
reg rst;
reg rx_data;
//
reg ff_rd_en;
wire [7:0] ff_data_out;
wire ff_empty;
//
uart_top #(.D_W(8), .B_TICK(16), .DEPTH(64), .DIV_W(16))
    uart_top_inst   (
                    .rst(rst),
                    .clk(clk),
                    .rx_data(rx_data),
                    //
                    .fifo_rx_rd_en(ff_rd_en),
                    .fifo_rx_data_out(ff_data_out),
                    .fifo_rx_empty(ff_empty)
                    );
//
// --- TEST BENCH --- //
// Clock Generation & Initial declarations
initial begin
    clk = 0;
    forever #5 clk = ~clk; // 100 MHz Clock
end

initial begin
    // Initialize Inputs
    rst = 1;
    rx_data = 1; // Typically idle high]
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
    $dumpfile("test/uart/uart_tb.vcd");
    $dumpvars(0, uart_tb);
end

endmodule
