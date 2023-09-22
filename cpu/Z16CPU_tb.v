module Z16CPU_tb;

  reg i_clk = 1'b0;
  reg i_rst = 1'b0;

  always #1 begin
    i_clk = ~i_clk;
  end

  initial begin
    $dumpfile("wave.vcd");
    $dumpvars(0, Z16CPU_tb);
  end

  Z16CPU CPU(
    .i_clk (i_clk),
    .i_rst (i_rst)
  );

  initial begin
    i_rst = 1'b1;
    #2
    i_rst = 1'b0;
    #100
    $finish;
  end
  
endmodule
