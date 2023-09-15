module problem2(
  input [7:0] i_p0,
  input [7:0] i_p1,
  input [7:0] i_p2,
  output wire [7:0] o_p
);

  wire [7:0] w_p;
  assign w_p = i_p1 & i_p2;
  assign o_p = w_p + i_p0;
endmodule