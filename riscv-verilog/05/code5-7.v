module m_circuit2(w_clk);
  input wire w_clk;
  reg [31:0] r_pc = 0;
  wire [31:0] w_npc;
  m_adder m (32'h4, r_pc, w_npc);
  always @(posedge w_clk) r_pc <= w_npc;
  wire [31:0] w_ir;
  m_am_imem m2 (r_pc, w_ir);
endmodule
