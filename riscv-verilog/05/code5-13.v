module m_proc2(w_clk);
  input wire w_clk;
  wire [31:0] w_npc, w_ir, w_r1, w_r2, w_rt;
  reg [31:0] r_pc = 0;
  m_adder m2 (32'h4, r_pc, w_npc);
  m_am_imem m3 (r_pc, w_ir);
  m_RF m4 (w_clk, w_ir[19:15], w_ir[24:20], w_r1, w_r2,
           w_ir[11:7], 1'b1, w_rt);
  m_adder m5(w_r1, w_r2, w_rt);
  always @(posedge w_clk) r_pc <= w_npc;
endmodule
