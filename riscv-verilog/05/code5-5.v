module m_circuit1(w_clk);
  input wire w_clk;
  reg [31:0] r_pc = 0;
  wire [31:0] w_npc;
  m_adder m (32'h4, r_pc, w_npc);
  always @(posedge w_clk) r_pc <= w_npc;
endmodule
