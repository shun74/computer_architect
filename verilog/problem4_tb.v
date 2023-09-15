module problem4_tb;
  reg           i_clk     = 0;
  reg           i_rst     = 0;
  wire  [15:0]  o_p;

  initial begin
    $dumpfile("wave.vcd");
    $dumpvars(0, DUT);
  end

  problem4 DUT(
    .i_clk  (i_clk  ),
    .i_rst  (i_rst  ),
    .o_p    (o_p    )
  );

  always #1 begin    
    i_clk <= ~i_clk;
  end

  initial begin
    i_rst   = 1'b1;
    #10
    i_rst   = 1'b0;
    #100
    $finish;
  end
endmodule