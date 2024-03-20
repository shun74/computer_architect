module m_proc5(w_clk);
  input wire w_clk;
  wire [31:0] w_npc, w_ir, w_imm, w_r1, w_r2, w_s2, w_rt;
  wire [31:0] w_alu, w_ldd, w_tpc, w_pcin;
  wire w_tkn;
  reg [31:0] r_pc=0;
  m_mux m11 (w_npc, w_tpc, w_b & w_tkn, w_pcin); // 5-3
  m_adder m2 (32'h4, r_pc, w_npc); // 5-1
  m_am_imem m3 (r_pc, w_ir); // 5-17
  wire w_r, w_i, w_s, w_b, w_u, w_j, w_ld;
  m_gen_imm m4 (w_ir, w_imm, w_r, w_i, w_s, w_b, w_u, w_j, w_ld); // 5-16
  m_RF m5 (w_clk, w_ir[19:15], w_ir[24:20], w_r1, w_r2, w_ir[11:7], !w_s & !w_b, w_rt); // 5-12
  m_adder m6 (w_imm, r_pc, w_tpc); // 5-1
  m_mux m7 (w_r2, w_imm, !w_r & !w_b, w_s2); // 5-3
  m_alu m8 (w_r1, w_s2, w_alu, w_tkn); // 5-23
  m_am_dmem m9 (w_clk, w_alu, w_s, w_r2, w_ldd); // 5-20
  m_mux m10 (w_alu, w_ldd, w_ld, w_rt); // 5-3
  always @(posedge w_clk) r_pc <= w_pcin;
  wire w_halt = (!w_s & !w_b & w_ir[11:7]==5'd30);
endmodule
