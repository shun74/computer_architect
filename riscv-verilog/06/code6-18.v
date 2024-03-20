module m_sim(w_clk, w_cc);
  input wire w_clk; input wire [31:0] w_cc;
  m_proc8 m (w_clk);
  initial begin
    `define MM m.m3.mem
    `include "asm6-10.txt"
  end
  initial #99 forever #100 $display("CC%1d %h %h %h %h %d %d %d",
    w_cc, m.r_pc, m.P1_pc, m.P2_pc, m.P3_pc,
    m.w_in1, m.w_in2, m.w_alu);
endmodule
