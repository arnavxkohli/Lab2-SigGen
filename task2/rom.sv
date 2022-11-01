module rom #(
    parameter ADDRESS_WIDTH = 8,
    DATA_WIDTH = 8
)(
    input logic                     clk,
    input logic [ADDRESS_WIDTH-1:0] addr,
    input logic [ADDRESS_WIDTH-1:0] offset,
    output logic [DATA_WIDTH-1:0]   dout1,
    output logic [DATA_WIDTH-1:0]   dout2
);

logic [DATA_WIDTH-1:0] rom_array [2**ADDRESS_WIDTH-1:0];
logic [ADDRESS_WIDTH-1:0] addr2;

initial begin
    $display("Loading rom.");
    $readmemh("sinerom.mem", rom_array);
end;

always_ff @(posedge clk)
    // output is syncronous
    begin
    dout1 <= rom_array [addr];
    addr2 <= addr + offset;
    dout2 <= rom_array [addr2];
    end

endmodule
