module m_sm_imem(w_clk, w_pc, r_insn);
  input wire w_clk;
  input wire [31:0] w_pc;
  output reg [31:0] r_insn;
  reg [31:0] mem [0:63];
  always @(posedge w_clk) r_insn <= mem[w_pc[7:2]];
  integer i; initial for (i=0; i<64; i=i+1) mem[i] = 32'd0;
endmodule
