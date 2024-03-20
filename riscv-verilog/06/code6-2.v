module m_sim(w_clk, w_cc);
  input wire w_clk; input wire [31:0] w_cc;
  reg [15:0] r_in1;
  reg [31:0] r_in2;
  wire [31:0] w_y;
  initial begin #50
    #100 r_in1 = 1; r_in2 = 2;
    #100 r_in1 = 3; r_in2 = 4;
    #100 r_in1 = 5; r_in2 = 6;
    #100 r_in1 = 7; r_in2 = 8;
    #100 r_in1 = 0; r_in2 = 0;
  end
  m_madd_pipe m (w_clk, r_in1, r_in2, w_y);
  initial #99 forever #100 $display("CC%1d %5d %5d %5d",
    w_cc, m.r_b, m.r_c, m.r_y);
  initial #800 $finish;
endmodule
