`timescale 1ns/100ps
`default_nettype none
module m_top_wrapper();
  reg r_clk=0; initial #150 forever #50 r_clk = ~r_clk;
  reg [31:0] r_cc=1; always @(posedge r_clk) r_cc <= r_cc + 1;
  initial #1000000 begin $display("timeout"); $finish; end
  m_sim m (r_clk, r_cc);
  initial $dumpvars(0, m);
endmodule