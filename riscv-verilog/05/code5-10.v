module m_top();
  reg r_clk=0; initial #150 forever #50 r_clk = ~r_clk;
  m_proc1 m (r_clk);
  initial #99 forever #100
    $display("%3d %d %d %d",
      $time, m.w_r1,m.w_r2, m.w_rt);
  initial #400 $finish;
endmodule
