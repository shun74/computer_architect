module m_bimodal(w_clk, w_radr, w_pred, w_wadr, w_we, w_tkn);
  input  wire w_clk, w_we;
  input  wire [4:0] w_wadr, w_radr;
  input  wire w_tkn;
  output wire w_pred;
  reg [1:0] mem [0:31];
  wire [1:0] w_data = mem[w_radr];
  assign w_pred = w_data[1];
  reg [1:0] P1_cnt = 0, P2_cnt = 0;
  always @(posedge w_clk) {P1_cnt, P2_cnt} <= {w_data, P1_cnt};
  always @(posedge w_clk) if (w_we)
    mem[w_wadr] <= (P2_cnt < 3 &  w_tkn) ? P2_cnt + 1 :
                   (P2_cnt > 0 & !w_tkn) ? P2_cnt - 1 : P2_cnt;
  integer i; initial for (i=0; i<32; i=i+1) mem[i] = 1;
endmodule
