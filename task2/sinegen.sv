module sinegen #(
    parameter WIDTH = 8,
    ADDRESS_WIDTH = 8,
    DATA_WIDTH = 8
)(
    input logic         clk,
    input logic         rst,
    input logic         en,
    input logic [ADDRESS_WIDTH-1:0] offset,
    input logic         [WIDTH-1:0] incr,
    output logic       [DATA_WIDTH-1:0]   dout1,
    output logic       [DATA_WIDTH-1:0]   dout2
   
);
 
    logic  [ADDRESS_WIDTH-1:0]      addr;

counter mycounter(
  .clk (clk),
  .rst (rst),
  .en (en),
  .count (addr),
  .incr (incr)
);



rom myrom(
    .clk (clk),
    .addr (addr),
    .offset (offset),
    .dout1 (dout1),
    .dout2 (dout2)
);

endmodule



