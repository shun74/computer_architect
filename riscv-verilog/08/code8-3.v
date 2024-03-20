module m_sim(w_clk, w_cc);
  input wire w_clk; input wire [31:0] w_cc;
  reg [31:0] r_pc = 0;
  reg        r_re = 0;
  wire [31:0] w_insn;
  wire w_oe;
  m_imem m (w_clk, r_pc, r_re, w_insn, w_oe);
  initial begin
    m.mem[0]=11; m.mem[1]=22; m.mem[2]=33; m.mem[3]=44;
    #280 r_pc<=4; r_re<=1;
    #100 r_pc<=0; r_re<=0;
    #500 r_pc<=8; r_re<=1;
    #100 r_pc<=0; r_re<=0;
  end
  initial #99 forever #100 $display("CC%02d %3d %3d %3d %3d %3d",
    w_cc, m.w_pc, m.w_re, m.r_c, m.r_insn, m.r_oe);
  initial #1450 $finish;
endmodule