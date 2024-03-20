module m_proc1(w_clk);
  input wire w_clk;
  wire [31:0] w_npc, w_ir, w_r1, w_r2, w_rt;
  wire w_cmp1, w_cmp2;
  reg [31:0] r_pc = 0, r_x1 = 3;
  m_adder m2 (32'h4, r_pc, w_npc);
  m_am_imem m3 (r_pc, w_ir);
  m_cmp m4 (5'd1, w_ir[19:15], w_cmp1);
  m_cmp m5 (5'd1, w_ir[24:20], w_cmp2);
  m_mux m7 (32'h0, r_x1, w_cmp1, w_r1);
  m_mux m8 (32'h0, r_x1, w_cmp2, w_r2);
  m_adder m9 (w_r1, w_r2, w_rt);
  always @(posedge w_clk) r_pc <= w_npc;
  always @(posedge w_clk) r_x1 <= w_rt;
endmodule
