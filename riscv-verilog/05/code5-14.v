module m_am_imem(w_adr, w_ir);
  input  wire [31:0] w_adr;
  output wire [31:0] w_ir;
  assign w_ir =
    (w_adr==0) ? {7'd0,5'd2,5'd1,3'd0,5'd5,7'h33} : // add x1,x0,x1
    (w_adr==4) ? {7'd0,5'd4,5'd3,3'd0,5'd6,7'h33} : // add x1,x1,x0
                 {7'd0,5'd6,5'd5,3'd0,5'd7,7'h33};  // add x1,x1,x1
endmodule
