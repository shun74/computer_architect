module m_proc6m(w_clk);
  input wire w_clk;
  reg [31:0] P1_ir=32'h13, P1_pc=0;
  wire [31:0] w_npc, w_ir, w_imm, w_r1, w_r2, w_s2, w_rt;
  wire [31:0] w_alu, w_ldd, w_tpc, w_pcin;
  wire w_r, w_i, w_s, w_b, w_u, w_j, w_ld, w_tkn;
  reg [31:0] r_pc=0;
  m_mux m0 (w_npc, w_tpc, w_b & w_tkn, w_pcin);
  m_adder m2 (32'h4, r_pc, w_npc);
  m_am_imem m3 (r_pc, w_ir);
  always @(posedge w_clk)
    {r_pc, P1_ir, P1_pc} <= {w_pcin, w_ir, r_pc};
  m_gen_imm m4 (P1_ir, w_imm, w_r, w_i, w_s, w_b, w_u, w_j, w_ld);
  m_RF m5 (w_clk, P1_ir[19:15], P1_ir[24:20], w_r1, w_r2,
          P1_ir[11:7], !w_s & !w_b, w_rt);
  m_adder m6 (w_imm, P1_pc, w_tpc);
  m_mux m7 (w_r2, w_imm, !w_r & !w_b, w_s2);
  m_alu m8 (w_r1, w_s2, w_alu, w_tkn);
  m_am_dmem m9 (w_clk, w_alu, w_s, w_r2, w_ldd);
  m_mux m10 (w_alu, w_ldd, w_ld, w_rt);
endmodule
