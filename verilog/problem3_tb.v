module problem3_tb;
  reg [15:0] i_p0;
  reg [15:0] i_p1;
  wire [15:0] o_p;

  initial begin
    $dumpfile("wave.vcd");
    $dumpvars(0, DUT);
  end
    
  problem3 DUT(
    .i_p0   (i_p0   ),
    .i_p1   (i_p1   ),
    .o_p    (o_p    )
  );
    
  initial begin
    i_p0 = 16'h0f0f;
    i_p1 = 16'h0f0f;
    #2
    $display("o_p = %04x", o_p);
    i_p0 = 16'h3366;
    i_p1 = 16'h6633;
    #2
    $display("o_p = %04x", o_p);
    i_p0 = 16'h1234;
    i_p1 = 16'h5678;
    #2
    $display("o_p = %04x", o_p);
    $finish;
  end
endmodule