module m_top();
  initial #200 $display("%3d Hello, World!", $time);
  initial begin
    #100 $display("%3d in Verilog HDL", $time);
    #150 $display("%3d When am I displayed?", $time);
  end
endmodule
