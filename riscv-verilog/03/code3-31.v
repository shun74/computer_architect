module m_top();
  reg r_clk = 0;
  initial #150 forever #50 r_clk = ~r_clk;
  wire [1:0] w_cnt;
  m_main m (r_clk, w_cnt);
  always@(posedge r_clk) #1
    $display("%3d %d %d", $time, w_cnt, m.r_cnt);
  initial #510 $finish;
endmodule

module m_main(w_clk, w_cnt);
  input  wire w_clk;
  output wire [1:0] w_cnt;
  reg [1:0] r_cnt = 0;
  always@(posedge w_clk) r_cnt <= w_cnt + 1;
  assign w_cnt = r_cnt;
endmodule
