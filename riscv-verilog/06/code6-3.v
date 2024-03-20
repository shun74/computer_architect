module m_madd_pipe(w_clk, w_b, w_c, r_y);
  input wire w_clk;
  input wire [15:0] w_b;
  input wire [31:0] w_c;
  output reg [31:0] r_y = 0;
  reg [15:0] r_b = 0;
  reg [31:0] r_c = 0, r_d = 0, r_e = 0;
  always @(posedge w_clk) begin
    r_b <= w_b;
    r_c <= w_c;
    r_d <= 16'd3 * r_b;
    r_e <= r_c;
    r_y <= r_d + r_e;
  end
endmodule
