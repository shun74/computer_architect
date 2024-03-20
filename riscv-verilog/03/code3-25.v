module m_top();
  wire signed [7:0] w_a = 8'b1010_0101, w_b = 8'd4;
  initial begin
    $display("%b %b %b %b",
      (w_a>>w_b), (w_a<<w_b), (w_a>>>w_b), (w_a<<<w_b));
  end
endmodule
