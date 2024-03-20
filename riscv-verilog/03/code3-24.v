module m_top();
  wire [7:0] w_a = 8'b11110101;
  wire [2:0] w_b = 3;
  initial #1 begin
    $display("%b", (w_a>>0));
    $display("%b", (w_a>>1));
    $display("%b", (w_a<<1));
    $display("%b", (w_a>>w_b));
    $display("%b", (w_a<<w_b));
  end
endmodule
