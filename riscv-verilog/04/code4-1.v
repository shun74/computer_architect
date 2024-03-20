module m_top();
  wire [7:0] w_a = 8'b11111110;
  wire [31:0] w_b = {{24{w_a[7]}}, w_a};
  initial #1 $display("%b %b", w_a, w_b);
endmodule
