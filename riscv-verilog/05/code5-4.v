module m_am_imem(w_adr, w_ir);
  input  wire [31:0] w_adr;
  output wire [31:0] w_ir;
  assign w_ir =
    (w_adr==0) ? {7'd0,5'd1,5'd0,3'd0,5'd1,7'b0110011} : // add x1,x0,x1
    (w_adr==4) ? {7'd0,5'd0,5'd1,3'd0,5'd1,7'b0110011} : // add x1,x1,x0
                 {7'd0,5'd1,5'd1,3'd0,5'd1,7'b0110011};  // add x1,x1,x1
endmodule
