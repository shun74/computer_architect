module Z16InstrMemory(
  input wire [15:0] i_addr,
  output wire [15:0] o_instr
);

  wire [15:0] i_mem[4:0];
  assign o_instr = i_mem[i_addr[15:1]];

  assign i_mem[0] = 16'h0A19;
  assign i_mem[1] = 16'h1220;
  assign i_mem[2] = 16'hFF19;
  assign i_mem[3] = 16'hFC4F;
  assign i_mem[4] = 16'h00FD;

endmodule