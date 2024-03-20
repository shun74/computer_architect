module m_sim(w_clk, w_cc);
  input wire w_clk; input wire [31:0] w_cc;
  wire w_re, w_oe;
  wire [31:0] w_pc, w_ir;
  m_proc8_c2 u1 (w_clk, w_pc, w_ir, w_oe, w_re);
  m_imem u2 (w_clk, w_pc, w_re, w_ir, w_oe);
  initial begin
    `define MM u2.mem
    `include "asm8-11.txt"
  end
  initial #99 forever #100
    $display("CC%02d %h %h %h %h %b %5d %5d %5d",
      w_cc, u1.r_pc, u1.P1_pc, u1.P2_pc, u1.P3_pc, u1.w_stall,
      u1.w_in1, u1.w_in2, u1.w_alu);
endmodule
