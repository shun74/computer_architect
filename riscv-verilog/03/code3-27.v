module m_main(w_a, w_b, w_c);
  input wire w_a, w_b;
  output wire w_c;
  assign w_c = ({w_a, w_b}==2'b00) ? 0 :
               ({w_a, w_b}==2'b01) ? 1 :
               ({w_a, w_b}==2'b10) ? 0 : 1;
endmodule
