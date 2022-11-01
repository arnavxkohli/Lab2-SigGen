module sinegen #(
    parameter WIDTH = 8,
    ADDRESS_WIDTH = 8,
    DATA_WIDTH = 8
)(
    input logic         clk,
    input logic         rst,
    input logic         en,
    input logic         [WIDTH-1:0] incr,
    output logic       [DATA_WIDTH-1:0]   dout
   
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
    .dout (dout)
);

endmodule



