module m_top();
  reg r_clk=0; initial #150 forever #50 r_clk = ~r_clk;
  m_circuit2 m (r_clk);
  initial #99 forever #100
    $display("%3d %h", $time, m.w_ir);
  initial #400 $finish;
endmodule
