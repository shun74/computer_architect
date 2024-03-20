module m_proc9(w_clk);
  input wire w_clk;
  reg [31:0] P1_ir=32'h13, P1_pc=0, P2_pc=0, P3_pc=0, P4_pc=0;
  reg [31:0] P2_r1=0, P2_s2=0, P2_r2=0, P2_tpc=0, P3_r2=0;
  reg [31:0] P3_alu, P3_in3, P4_alu=0, P4_ldd=0;
  reg P2_r=0, P2_s=0, P2_b=0, P2_ld=0, P4_s=0, P4_b=0, P4_ld=0;
  reg P3_s=0, P3_b=0, P3_ld=0;
  reg [4:0] P2_rd=0, P2_rs1=0, P2_rs2=0, P3_rd=0, P4_rd=0;
  reg P1_v=0, P2_v=0, P3_v=0, P4_v=0;
  wire [31:0] w_npc, w_ir, w_imm, w_r1, w_r2, w_s2, w_rt;
  wire [31:0] w_alu, w_ldd, w_tpc, w_pcin, w_in1, w_in2, w_in3;
  wire w_r, w_i, w_s, w_b, w_u, w_j, w_ld, w_tkn;
  reg [31:0] r_pc = 0;
  wire w_miss = P2_b & w_tkn & P2_v;
  wire w_lduse = P3_v & P3_ld &
       ((P3_rd==P2_rs1) | ((P3_rd==P2_rs2) & (P2_r | P2_b)));
  m_mux m0 (w_npc, P2_tpc, w_miss, w_pcin);
  m_adder m2 (32'h4, r_pc, w_npc);
  m_am_imem m3 (r_pc, w_ir);
  m_gen_imm m4 (P1_ir, w_imm, w_r, w_i, w_s, w_b, w_u, w_j, w_ld);
  m_RF2 m5 (w_clk, P1_ir[19:15], P1_ir[24:20], w_r1, w_r2,
            P4_rd, !P4_s & !P4_b & P4_v, w_rt);
  m_adder m6 (w_imm, P1_pc, w_tpc);
  m_mux m7 (w_r2, w_imm, !w_r & !w_b, w_s2);
  always @(posedge w_clk) if (!w_lduse) begin
    {P1_v, P2_v} <= {!w_miss, !w_miss & P1_v};
    {r_pc, P1_ir, P1_pc, P2_pc} <= {w_pcin, w_ir, r_pc, P1_pc};
    {P2_r1, P2_r2, P2_s2, P2_tpc} <= {w_r1, w_r2, w_s2, w_tpc};
    {P2_r, P2_s, P2_b, P2_ld} <= {w_r, w_s, w_b, w_ld};
    {P2_rs2, P2_rs1, P2_rd} <= {P1_ir[24:15], P1_ir[11:7]};
  end
  always @(posedge w_clk) begin
    {P3_v, P4_v} <= {P2_v & !w_lduse, P3_v};
    {P3_pc, P3_ld, P3_r2, P3_in3} <= {P2_pc, P2_ld, P2_r2, w_in3};
    {P3_alu, P3_rd} <= {w_alu, P2_rd};
    {P3_s, P3_b, P3_ld} <= {P2_s, P2_b, P2_ld};
    {P4_pc, P4_s, P4_b, P4_ld} <= {P3_pc, P3_s, P3_b, P3_ld};
    {P4_alu, P4_ldd, P4_rd} <= {P3_alu, w_ldd, P3_rd};
  end
  m_alu m8 (w_in1, w_in2, w_alu, w_tkn);
  m_am_dmem m9 (w_clk, P3_alu, P3_s & P3_v, P3_in3, w_ldd);
  m_mux m10 (P4_alu, P4_ldd, P4_ld, w_rt);
  wire w_f3 = !P3_s & !P3_b & |P3_rd & P3_v;
  wire w_f4 = !P4_s & !P4_b & |P4_rd & P4_v;
  wire w_fwd1_P3 = (w_f3 & P3_rd==P2_rs1);
  wire w_fwd1_P4 = (w_f4 & P4_rd==P2_rs1);
  wire w_fwd2_P3 = (w_f3 & P3_rd==P2_rs2 & (P2_r | P2_b));
  wire w_fwd2_P4 = (w_f4 & P4_rd==P2_rs2 & (P2_r | P2_b));
  wire w_fwd3_P3 = (w_f3 & P3_rd==P2_rs2);
  wire w_fwd3_P4 = (w_f4 & P4_rd==P2_rs2);
  assign w_in1 = (w_fwd1_P3) ? P3_alu : (w_fwd1_P4) ? w_rt : P2_r1;
  assign w_in2 = (w_fwd2_P3) ? P3_alu : (w_fwd2_P4) ? w_rt : P2_s2;
  assign w_in3 = (w_fwd3_P3) ? P3_alu : (w_fwd3_P4) ? w_rt : P2_r2;
endmodule 
