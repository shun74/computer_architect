module m_top();
  wire [7:0] w_a = 8'b11110101;
  wire [3:0] w_b, w_c;
  wire       w_d;
  assign w_b = w_a[3:0];
  assign w_c = w_a[4:1];
  assign w_d = w_a[7];
  always@(*) #1 $display("%b %b %b %b", w_a, w_b, w_c, w_d);
endmodule
