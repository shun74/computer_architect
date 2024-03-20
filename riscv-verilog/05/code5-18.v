module m_proc3(w_clk);
  input wire w_clk;
  wire [31:0] w_npc, w_ir, w_imm, w_r1, w_r2, w_s2, w_rt;
  wire w_r, w_i, w_s, w_b, w_u, w_j, w_ld;
  reg [31:0] r_pc = 0;
  m_adder m2 (32'h4, r_pc, w_npc); // 5-1
  m_am_imem m3 (r_pc, w_ir); // 5-17
  m_gen_imm m4 (w_ir, w_imm, w_r, w_i, w_s, w_b, w_u, w_j, w_ld); // 5-16
  m_RF m5 (w_clk, w_ir[19:15], w_ir[24:20], w_r1, w_r2,
           w_ir[11:7], 1'b1, w_rt); // 5-12
  m_mux m6 (w_r2, w_imm, w_i, w_s2); // 5-3
  m_adder m7 (w_r1, w_s2, w_rt); // 5-1
  always @(posedge w_clk) r_pc <= w_npc;
endmodule
