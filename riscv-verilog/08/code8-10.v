module m_cache2(w_clk, w_adr, w_hit, w_dout, w_wadr, w_we, w_wd);
  input  wire w_clk, w_we;
  input  wire [31:0] w_adr;
  input  wire [4:0] w_wadr;
  input  wire [88:0] w_wd;
  output wire w_hit;
  output wire [31:0] w_dout;
  wire w_v;
  wire [23:0] w_tag;
  wire [31:0] w_d1, w_d2;
  reg [88:0] mem [0:31];
  always @(posedge w_clk) if (w_we) mem[w_wadr] <= w_wd;
  assign {w_v, w_tag, w_d1, w_d2} = mem[w_adr[7:3]];
  assign w_hit = w_v & (w_tag==w_adr[31:8]);
  assign w_dout = (w_adr[2]) ? w_d1 : w_d2;
  integer i; initial for (i=0; i<32; i=i+1) mem[i] = 0;\
endmodule
