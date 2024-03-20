module m_proc7(w_clk);
  input wire w_clk;
  reg [31:0] P1_ir=32'h13, P1_pc=0, P2_pc=0;
  reg [31:0] P2_r1=0, P2_s2=0, P2_r2=0, P2_tpc=0;
  reg P2_s=0, P2_b=0, P2_ld=0, P1_v=0, P2_v=0;
  reg [4:0] P2_rd=0;
  wire [31:0] w_npc, w_ir, w_imm, w_r1, w_r2, w_s2, w_rt;
  wire [31:0] w_alu, w_ldd, w_tpc, w_pcin;
  wire w_r, w_i, w_s, w_b, w_u, w_j, w_ld, w_tkn;
  reg [31:0] r_pc=0;
  wire w_miss = P2_b & w_tkn & P2_v;
  m_mux m0 (w_npc, P2_tpc, w_miss, w_pcin);
  m_adder m2 (32'h4, r_pc, w_npc);
  m_am_imem m3 (r_pc, w_ir);
  m_gen_imm m4 (P1_ir, w_imm, w_r, w_i, w_s, w_b, w_u, w_j, w_ld);
  m_RF2 m5 (w_clk, P1_ir[19:15], P1_ir[24:20], w_r1, w_r2,
          P2_rd, !P2_s & !P2_b & P2_v, w_rt);
  m_adder m6 (w_imm, P1_pc, w_tpc);
  m_mux m7 (w_r2, w_imm, !w_r & !w_b, w_s2);
  always @(posedge w_clk) begin
    {P1_v, P2_v} <= {!w_miss, !w_miss & P1_v};
    {r_pc, P1_ir, P1_pc} <= {w_pcin, w_ir, r_pc};
    {P2_r1, P2_r2, P2_s2} <= {w_r1, w_r2, w_s2};
    {P2_pc, P2_tpc, P2_rd} <= {P1_pc, w_tpc, P1_ir[11:7]};
    {P2_s, P2_b, P2_ld} <= {w_s, w_b, w_ld};
  end
  m_alu m8 (P2_r1, P2_s2, w_alu, w_tkn);
  m_am_dmem m9 (w_clk, w_alu, P2_s & P2_v, P2_r2, w_ldd);
  m_mux m10 (w_alu, w_ldd, P2_ld, w_rt);
endmodule
