module problem1_tb;
  reg [7:0] i_p0;
  reg [7:0] i_p1;
  reg [7:0] i_p2;
  wire [7:0] o_p;

  initial begin
    $dumpfile("wave.vcd");
    $dumpvars(0, DUT);
  end
    
  problem1 DUT(
    .i_p0   (i_p0   ),
    .i_p1   (i_p1   ),
    .i_p2   (i_p2   ),
    .o_p    (o_p    )
  );
    
  initial begin
    i_p0 = 8'h00;
    i_p1 = 8'h00;
    i_p2 = 8'h00;
    #2
    $display("o_p = %02x", o_p);
    i_p0 = 8'h0f;
    i_p1 = 8'h55;
    i_p2 = 8'h88;
    #2
    $display("o_p = %02x", o_p);
    i_p0 = 8'h74;
    i_p1 = 8'h81;
    i_p2 = 8'h11;
    #2
    $display("o_p = %02x", o_p);
    $finish;
  end
endmodule