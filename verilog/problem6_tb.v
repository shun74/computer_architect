module problem6_tb;
  reg i_clk = 0;
  reg i_rst = 0;
  reg [15:0] i_data = 16'b0010001101000100;
  wire [2:0] o_p;

  initial begin
    $dumpfile("wave.vcd");
    $dumpvars(0, DUT);
  end

  problem6 DUT(
    .i_clk (i_clk),
    .i_rst (i_rst),
    .i_data (i_data),
    .o_data (o_p)
  );

  always #1 begin
    i_clk = ~i_clk;
  end

  initial begin
    i_data[1:0] = 2'b00;
    #10
    $display("i_data: %016b, o_data: %03b", i_data, o_p);
    i_data[1:0] = 2'b01;
    #10
    $display("i_data: %016b, o_data: %03b", i_data, o_p);
    i_data[1:0] = 2'b10;
    $display("i_data: %016b, o_data: %03b", i_data, o_p);
    i_data[1:0] = 2'b11;
    #10
    $display("i_data: %016b, o_data: %03b", i_data, o_p);
    i_rst = 1'b1;
    #10
    $display("i_data: %016b, o_data: %03b", i_data, o_p);
    $finish;
  end

endmodule
