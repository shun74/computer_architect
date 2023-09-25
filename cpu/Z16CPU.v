module Z16CPU (
  input wire i_clk,
  input wire i_rst
);

  reg [15:0] r_pc;

  wire [15:0] w_instr;
  wire [3:0]  w_rd_addr;
  wire [3:0]  w_rs1_addr;
  wire [3:0]  w_rs2_addr;
  wire [15:0] w_imm;
  wire        w_rd_wen;
  wire        w_mem_wen;
  wire [15:0] w_mem_rdata;
  wire [3:0]  w_alu_ctrl;
  wire [3:0]  w_opecode;

  wire [15:0] w_rs1_data;
  wire [15:0] w_rs2_data;
  wire [15:0] w_rd_data;

  wire [15:0] w_data_b;
  wire [15:0] w_alu_data;

  always @(posedge i_clk) begin
    if (i_rst) begin
      r_pc <= 16'h0000;
    end else begin
      r_pc <= r_pc + 16'h0002;
    end
  end

  Z16InstrMemory InstrMem(
    .i_addr  (r_pc),
    .o_instr (w_instr)
  );

  Z16Decoder Decoder(
    .i_instr    (w_instr),
    .o_opecode  (w_opecode),
    .o_rd_addr  (w_rd_addr),
    .o_rs1_addr (w_rs1_addr),
    .o_rs2_addr (w_rs2_addr),
    .o_imm      (w_imm),
    .o_rd_wen   (w_rd_wen),
    .o_mem_wen  (w_mem_wen),
    .o_alu_ctrl (w_alu_ctrl)
  );


  assign w_rd_data = (w_opecode[3:0] == 4'hA) ? w_mem_rdata : w_alu_data;
  Z16RegisterFile RegFile(
    .i_clk      (i_clk),
    .i_rs1_addr (w_rs1_addr),
    .o_rs1_data (w_rs1_data),
    .i_rs2_addr (w_rs2_addr),
    .o_rs2_data (w_rs2_data),
    .i_rd_data  (w_rd_data),
    .i_rd_addr  (w_rd_addr),
    .i_rd_wen   (w_rd_wen)
  );

  assign w_data_b = (w_opecode <= 8'h8) ? w_rs2_data : w_imm;
  Z16ALU ALU(
    .i_data_a (w_rs1_data),
    .i_data_b (w_data_b),
    .i_ctrl   (w_alu_ctrl),
    .o_data   (w_alu_data)
  );

  Z16DataMemory DataMem(
    .i_clk   (i_clk),
    .i_addr  (w_alu_data),
    .i_wen   (w_mem_wen),
    .i_data  (w_rs2_data),
    .o_data  (w_mem_rdata)
  );

endmodule
