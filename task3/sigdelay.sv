module sigdelay #(
    parameter WIDTH = 8,
    ADDRESS_WIDTH = 8,
    DATA_WIDTH = 8
)(
    input logic clk,
    input logic en,
    input logic rst,
    input logic [WIDTH-1:0] incr,
    input logic wr,
    input logic rd,
    input logic [ADDRESS_WIDTH-1:0] offset,
    input logic [DATA_WIDTH-1:0] din,
    output logic [DATA_WIDTH-1:0] mic_signal,
    output logic [DATA_WIDTH-1:0] delayed_signal
);
 
    logic  [ADDRESS_WIDTH-1:0]      addr;

counter mycounter(
  .clk (clk),
  .rst (rst),
  .en (en),
  .count (addr),
  .incr (incr)
);



ram myram(
    .clk (clk),
    .wr_addr (addr),
    .offset (offset),
    .din (din),
    .rd (rd),
    .wr (wr),
    .dout_read (mic_signal),
    .dout_write(delayed_signal)
);

endmodule
