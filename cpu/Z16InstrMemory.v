module Z16InstrMemory(
  input wire [15:0] i_addr,
  output wire [15:0] o_instr
);

  wire [15:0] mem[10:0];
  assign o_instr = mem[i_addr[15:1]];

  assign mem[0] = 16'h0010; // ADD ZR ZR B1
  assign mem[1] = 16'h0020; // ADD ZR ZR B2
  assign mem[2] = 16'h0A19; // ADDI 10 B1
  assign mem[3] = 16'h1220; // ADD B1 B2 B2
  assign mem[4] = 16'hFF19; // ADDI -1 B1
  assign mem[5] = 16'hFC4F; // BLT B1 ZR -4
  assign mem[6] = 16'h00FD; // JRL 0 ZR G11

endmodule
