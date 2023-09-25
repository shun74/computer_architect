module Z16InstrMemory(
  input wire [15:0] i_addr,
  output wire [15:0] o_instr
);

  wire [15:0] mem[10:0];
  assign o_instr = mem[i_addr[15:1]];

  assign mem[0] = 16'h0040; // ADD ZR ZR G0
  assign mem[1] = 16'h0050; // ADD ZR ZR G1
  assign mem[2] = 16'h0080; // ADD ZR ZR G4
  assign mem[3] = 16'h7849; // ADDI 120 G0
  assign mem[4] = 16'h5759; // ADDI 87 G1
  assign mem[5] = 16'h0389; // ADDI 3 G4
  assign mem[6] = 16'h8462; // MUL G4 G0 G2
  assign mem[7] = 16'h6459; // ADDI 100 G1
  assign mem[8] = 16'h65B0; // ADD G2 G1 G7
  assign mem[9] = 16'hB00B; // STORE G7 ZR 0
  assign mem[10] = 16'h0000; 

endmodule
