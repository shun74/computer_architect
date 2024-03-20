module m_pht(w_clk, w_radr, w_rd, w_wadr, w_we, w_wd);
  input  wire w_clk, w_we;
  input  wire [4:0] w_wadr, w_radr;
  input  wire w_wd;
  output wire w_rd;
  reg [0:0] mem [0:31];
  assign w_rd = mem[w_rdar];
  always @(posedge w_clk) if (w_we) mem[w_wadr] <= w_wd;
  integer i; initial for (i=0; i<32; i=i+1) mem[i] = 0;
endmodule
