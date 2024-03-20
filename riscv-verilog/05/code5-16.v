module m_gen_imm(w_ir, w_imm, w_r, w_i, w_s, w_b, w_u, w_j, w_ld);
  input  wire [31:0] w_ir;
  output wire [31:0] w_imm;
  output wire w_r, w_i, w_s, w_b, w_u, w_j, w_ld;
  m_get_type m1 (w_ir[6:2], w_r, w_i, w_s, w_b, w_u, w_j); // 4-3
  m_get_imm  m2 (w_ir, w_i, w_s, w_b, w_u, w_j, w_imm); // 4-5
  assign w_ld = (w_ir[6:2]==0);
endmodule
