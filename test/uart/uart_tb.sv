`timescale 1ns / 1ps

module uart_tb;

// General Pins
reg clk;
reg rst;
reg rx_data;
reg tx_data;
reg tx_start;
wire tx_done;
//
reg ff_tx_wr_en;
reg ff_rd_en;
wire [7:0] ff_data_out;
wire ff_empty;
//
//
reg PRESET;
reg [7:0] PADDR;
reg PSEL;
reg PENABLE;
reg PWRITE;
reg [7:0] PWDATA;
wire PREADY;
wire [7:0] PRDATA;
//
uart_top #(.D_W(8), .B_TICK(16), .DEPTH(64), .DIV_W(16), .APB_DW(8))
    uart_top_inst   (
                    .rst(!PRESET),
                    .clk(clk),
                    .rx_data(rx_data),
                    //
                    .tx_data(tx_data),
                    .tx_start(tx_start),
                    //
                    .PADDR(PADDR),
                    .PSEL(PSEL),
                    .PENABLE(PENABLE),
                    .PWRITE(PWRITE),
                    .PWDATA(PWDATA),
                    .PREADY(PREADY),
                    .PRDATA(PRDATA)
                    );
//
// --- TEST BENCH --- //
// Clock Generation & Initial declarations
initial begin
    clk = 1;
    forever #5 clk = ~clk; // 100 MHz Clock
end

// Reset APB Signals
initial begin
    PRESET = 1;
    PADDR = 0;
    PENABLE = 0;
    PWDATA = 0;
    PSEL = 0;
    PWRITE = 0;
end

initial begin
    // Initialize Inputs
    PRESET = 0;
    rx_data = 1; // Typically idle high]
    ff_tx_wr_en = 0;
    ff_rd_en = 0; // Ensure read enable is disabled
    #10 PRESET = 1; // Release reset
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

    PSEL <= 1;
    PWRITE <= 0;
    #10
    PENABLE <= 1;
    wait(PREADY == 1);
    #10
    PENABLE <= 0;
    PSEL <= 0;
    #1000;

    PSEL <= 1;
    PWRITE <= 0;
    #10
    PENABLE <= 1;
    wait(PREADY == 1);
    #10
    PENABLE <= 0;
    PSEL <= 0;
    #1000;

    PSEL <= 1;
    PWRITE <= 0;
    #10
    PENABLE <= 1;
    wait(PREADY == 1);
    #10
    PENABLE <= 0;
    PSEL <= 0;
    #1000;


    PSEL <= 1;
    PWRITE <= 1;
    PADDR <= 2;
    PWDATA <= 56;
    #10
    PENABLE <= 1;
    wait(PREADY == 1);
    #10
    PENABLE <= 0;
    PWRITE <= 0;
    PSEL <= 0;
    #1000;
    $finish; // End simulation
end

// Detailed Monitoring to Observe Ticks
initial begin
    // Initialize VCD dump
    $dumpfile("test/uart/uart_tb.vcd");
    $dumpvars(0, uart_tb);
end

endmodule
