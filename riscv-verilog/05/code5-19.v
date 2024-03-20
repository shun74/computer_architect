module m_top();
  reg r_clk=0; initial #150 forever #50 r_clk = ~r_clk;
  m_proc3 m (r_clk); // 5-18
  initial begin
    m.m3.mem[0]={12'd3,5'd0,3'd0,5'd1,7'h13};
    m.m3.mem[1]={12'd4,5'd1,3'd0,5'd2,7'h13};
    m.m3.mem[2]={12'd5,5'd2,3'd0,5'd3,7'h13};
  end
  initial #99 forever #100 $display("%3d %d %d %d",
    $time, m.w_r1, m.w_s2, m.w_rt);
  initial #400 $finish;
endmodule
