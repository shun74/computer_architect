module m_cache3(w_clk, w_adr, w_hit, w_dout, w_wadr, w_we, w_wd);
  input  wire w_clk, w_we;
  input  wire [31:0] w_adr;
  input  wire [4:0] w_wadr;
  input  wire [57:0] w_wd;
  output wire w_hit;
  output wire [31:0] w_dout;
  wire w_hit1, w_hit2, w_we1, w_we2;
  wire [31:0] w_dout1, w_dout2;
  m_cache1 way1 (w_clk, w_adr, w_hit1, w_dout1, w_wadr, w_we1, w_wd);
  m_cache1 way2 (w_clk, w_adr, w_hit2, w_dout2, w_wadr, w_we2, w_wd);
  assign w_hit = w_hit1 | w_hit2;
  assign w_dout = (w_hit1) ? w_dout1 : w_dout2;
  reg [0:0] lru [0:31];
  always @(posedge w_clk) if (w_hit) lru[w_adr[6:2]] <= w_hit1;
  assign w_we1 = (w_we & lru[w_wadr]==0);
  assign w_we2 = (w_we & lru[w_wadr]==1);
  integer i; initial for (i=0; i<32; i=i+1) lru[i] = 0;
endmodule
