module ram #(
    parameter ADDRESS_WIDTH = 8,
    DATA_WIDTH = 8
)(
    input logic clk,
    input logic wr,
    input logic rd,
    input logic [ADDRESS_WIDTH-1:0] offset,
    input logic [ADDRESS_WIDTH-1:0] rd_addr,
    input logic [DATA_WIDTH-1:0] din,
    output logic [DATA_WIDTH-1:0] dout_write,
    output logic [DATA_WIDTH-1:0] dout_read
);

logic [DATA_WIDTH-1:0] ram_array [2**ADDRESS_WIDTH-1:0]; //2^something 
logic [ADDRESS_WIDTH-1:0] wr_addr;
//because you can't get input from input(rd_addr and offset), you have to define wr addr as an intermediate logic

always_ff @(posedge clk) begin
    if (wr == 1'b1)
        wr_addr <= rd_addr + offset;
        ram_array [wr_addr] <= din;
        dout_write <= ram_array [wr_addr]; //when writing to the ram, the task also asks you to print the value stored in the ram, hence you need this extra line.
    if (rd == 1'b1)
    // output is synchronous
        dout_read <= ram_array [rd_addr];
end
endmodule
