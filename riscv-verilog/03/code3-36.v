`define D_INTERVAL 999999
module m_main (w_clk, r_out);
  input wire w_clk;
  output reg r_out=0;
  reg [31:0] r_cnt = 0;
  always@(posedge w_clk) begin
    r_cnt <= (r_cnt==`D_INTERVAL) ? 0 : r_cnt+1;
    r_out <= (r_cnt==0) ? ~r_out : r_out;
  end
endmodule
