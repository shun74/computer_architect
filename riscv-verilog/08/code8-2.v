`define D_DELAY 3
module m_imem(w_clk, w_pc, w_re, r_insn, r_oe);
  input  wire w_clk, w_re;
  input  wire [31:0] w_pc;
  output reg  [31:0] r_insn = 0;
  output reg  r_oe = 0;
  reg [31:0] mem [0:2047];
  reg [31:0] r_c=1, r_pc=0;
  always @(posedge w_clk) begin
    r_pc <= (r_c==1 & w_re) ? w_pc : r_pc;
    r_c <= (r_c==1 & w_re) ? 2 : (r_c==1 | r_c==`D_DELAY) ? 1 : r_c+1;
    r_oe <= (r_c==`D_DELAY-1);
    r_insn <= (r_c==`D_DELAY-1) ? mem[r_pc[12:2]] : 0;
  end
  integer i; initial for (i=0; i<2048; i=i+1) mem[i] = 32'd0;
endmodule
