module m_top();
  wire [31:0] w_a = 7, w_b = 8;
  initial #1 begin
    $display("%b %b %b", (w_a>w_b), (w_a<w_b), (w_a>=w_b));
    $display("%b %b %b", (w_a<=w_b), (w_a==w_b), (w_a!=w_b));
  end
endmodule
