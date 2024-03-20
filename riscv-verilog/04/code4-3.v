module m_get_type(opcode5, r, i ,s, b, u, j);
  input wire [4:0] opcode5;
  output wire r, i, s ,b, u, j;
  assign j = (opcode5==5'b11011);
  assign b = (opcode5==5'b11000);
  assign s = (opcode5==5'b01000);
  assign r = (opcode5==5'b01100);
  assign u = (opcode5==5'b01101 || opcode5==5'b00101);
  assign i = ~(r | s | b | u | j);
endmodule
