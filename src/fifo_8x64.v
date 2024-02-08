module fifo_8x64 (
    input clk,                  // Clock input
    input rst,                  // Reset input
    input wr_en,                // Write enable
    input rd_en,                // Read enable
    input [7:0] data_in,        // Data input
    output reg [7:0] data_out,  // Data output
    output reg full,            // FIFO full flag
    output reg empty            // FIFO empty flag
);

// FIFO memory array
reg [7:0] fifo_mem[63:0];

// Read and write pointers
reg [5:0] write_pointer, read_pointer;

// Counter to keep track of the number of items in the FIFO
reg [6:0] count;

// Write operation
always @(posedge clk) begin
    if (rst) begin
        write_pointer <= 0;
        full <= 0;
    end else if (wr_en && !full) begin
        fifo_mem[write_pointer] <= data_in;
        write_pointer <= write_pointer + 1;
        if (write_pointer == 63) full <= 1;
    end
    if (wr_en && !full) begin
        count <= count + 1;
        empty <= 0;
    end
end

// Read operation
always @(posedge clk) begin
    if (rst) begin
        read_pointer <= 0;
        empty <= 1;
    end else if (rd_en && !empty) begin
        data_out <= fifo_mem[read_pointer];
        read_pointer <= read_pointer + 1;
        if (read_pointer == 63) empty <= 1;
    end
    if (rd_en && !empty) begin
        count <= count - 1;
        full <= 0;
    end
end

// FIFO full and empty logic
always @(*) begin
    full = (count == 64);
    empty = (count == 0);
end

endmodule
