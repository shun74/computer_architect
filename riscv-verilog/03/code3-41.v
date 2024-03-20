module m_top();
  reg [31:0] a = 0, b = 0, c = 0, d = 0;
  wire [31:0] sum;
  initial #100 begin
    a <= 3;
    b <= a + 5;
  end
  initial #100 begin
    c = 3;
    d = c + 5;
  end
  assign sum = a + b + c + d;
  initial #101 $display("%d %d %d %d %d", a, b, c, d, sum);
endmodule
