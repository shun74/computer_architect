module m_top();
  wire [4:0] opcode5 = 5'b01101;
  wire r, i, s, b, u, j;
  m_get_type m (opcode5, r, i, s, b, u, j);
  initial #100
    $display("%b %b %b %b %b %b %b", opcode5, r, i, s, b, u, j);
endmodule
