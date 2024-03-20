module m_top();
  wire [3:0] w_a = 4'b1101;
  initial #1 begin
    $display("%b", {w_a, w_a});
    $display("%b", {w_a, w_a, w_a});
    $display("%b", {{4{w_a}}});
    $display("%b", {4{w_a[2:0]}});
  end
endmodule
