module m_top();
  reg r_clk=0; initial #150 forever #50 r_clk = ~r_clk;
  m_proc5 m (r_clk);
  initial begin
    m.m3.mem[0]={12'd5,5'd0,3'h0,5'd1,7'h13};         // addi x1,x0,5
    m.m3.mem[1]={7'd0,5'd1,5'd1,3'h0,5'd2,7'h33};     // add x2,x1,x1
    m.m3.mem[2]={12'd1,5'd1,3'd0,5'd1,7'h13};         // L: addi x1,x1,1
    m.m3.mem[3]={~12'd0,5'd2,5'd1,3'h1,5'h1d,7'h63};  // bne x1,x2,L
    m.m3.mem[4]={12'd9,5'd1,3'd0,5'd10,7'h13};        // addi x10,x1,9
  end
  initial #99 forever #100 $display ("%4d %h %h %d %d %d",
    $time, m.r_pc, m.w_imm, m.w_r1, m.w_s2, m.w_rt);
  initial #1400 $finish;
endmodule
