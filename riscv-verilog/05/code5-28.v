module m_sim(w_clk, w_cc); /* please wrap me by m_top_wrapper */
  input wire w_clk; input wire [31:0] w_cc;
  m_proc5 m (w_clk);
  initial begin
    `define MM m.m3.mem
    `include "asm.txt"
  end
  initial #99 forever #100 $display ("CC%02d %h %d %d %d",
    w_cc, m.r_pc, m.w_r1, m.w_s2, m.w_rt);
endmodule
