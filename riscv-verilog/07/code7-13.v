module m_gshare(w_clk, w_radr, w_pred, w_wadr, w_we, w_tkn);
  input  wire w_clk, w_we;
  input  wire [4:0] w_wadr, w_radr;
  input  wire w_tkn;
  output wire w_pred;
  reg [1:0] mem [0:31];
  reg [4:0] r_bhr = 0;
  always @(posedge w_clk) r_bhr <= {w_tkn, r_bhr[4:1]};
  wire [1:0] w_data = mem[w_radr ^ r_bhr];
  assign w_pred = w_data[1];
  wire [1:0] w_cnt  = mem[w_radr ^ r_bhr];
  always @(posedge w_clk) if (w_we)
    mem[w_wadr ^ r_bhr] <= (w_cnt < 3 &  w_tkn) ? w_cnt + 1 :
                           (w_cnt > 0 & !w_tkn) ? w_cnt - 1 : w_cnt;
  integer i; initial for (i=0; i<32; i=i+1) mem[i] = 1;
endmodule
