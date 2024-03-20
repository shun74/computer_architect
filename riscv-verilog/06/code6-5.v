module m_sim(w_clk, w_cc);
  input wire w_clk; input wire [31:0] w_cc;
  m_proc6 m (w_clk);
  initial begin
    `define MM m.m3.mem
    `include "asm6-10.txt"
  end
  initial #99 forever #100 $display("CC%1d %h %h %d %d %d",
    w_cc, m.r_pc, m.P1_pc, m.w_r1, m.w_s2, m.w_rt);
endmodule
