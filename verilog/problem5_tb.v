module problem5_tb;
  reg         i_clk = 0;
  reg  [1:0]  i_ctrl = 2'b00;
  wire [15:0] o_p;

  initial begin
    $dumpfile("wave.vcd");
    $dumpvars(0, DUT);
  end

  problem5 DUT(
    .i_clk (i_clk),
    .i_ctrl (i_ctrl),
    .i_data_0 (16'h0000),
    .i_data_1 (16'h0008),
    .i_data_2 (16'h0010),
    .i_data_3 (16'h0018),
    .o_data (o_p)
  );

  always #1 begin
    i_clk = ~i_clk;
  end

  initial begin
    i_ctrl = 2'b00;
    #10
    $display("o_data = %04x", o_p);
    i_ctrl = 2'b01;
    #10
    $display("o_data = %04x", o_p);
    i_ctrl = 2'b10;
    #10
    $display("o_data = %04x", o_p);
    i_ctrl = 2'b11;
    #10
    $display("o_data = %04x", o_p);
    $finish;
  end
endmodule