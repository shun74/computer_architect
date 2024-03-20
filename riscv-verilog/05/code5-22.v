module m_top();
  reg r_clk=0; initial #150 forever #50 r_clk = ~r_clk;
  m_proc4 m (r_clk);
  initial begin
    m.m3.mem[0]={12'd7,5'd0,3'd0,5'd1,7'h13};     // addi x1,x0,7
    m.m3.mem[1]={7'd0,5'd1,5'd0,3'h2,5'd8,7'h23}; // sw x1, 8(x0)
    m.m3.mem[2]={12'd8,5'd0,3'b010,5'd2,7'h3};   // lw x2, 8(x0)
  end
  initial #99 forever #100 $display("%3d %d %d %d",
    $time, m.w_r1, m.w_s2, m.w_rt);
  initial #400 $finish;
endmodule
