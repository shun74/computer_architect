module m_cmp(w_in1, w_in2, w_out);
  input wire [4:0] w_in1, w_in2;
  output wire w_out;
  assign w_out = (w_in1 == w_in2);
endmodule
