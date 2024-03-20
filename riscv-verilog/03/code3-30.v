module m_top();
  reg r_clk=0;
  initial #150 forever #50 r_clk = ~r_clk;
  always@(*) $display("%3d: %d", $time, r_clk);
  initial #410 $finish;
endmodule
