module m_adder(w_in1, w_in2, w_out);
  input wire [31:0] w_in1, w_in2;
  output wire [31:0] w_out;
  assign w_out = w_in1 + w_in2;
endmodule

module m_cmp(w_in1, w_in2, w_out);
  input wire [4:0] w_in1, w_in2;
  output wire w_out;
  assign w_out = (w_in1 == w_in2);
endmodule

module m_mux(w_in1, w_in2, w_s, w_out);
  input  wire [31:0] w_in1, w_in2;
  input  wire w_s;
  output wire [31:0] w_out;
  assign w_out = (w_s) ? w_in2 : w_in1;
endmodule

module m_RF(w_clk, w_ra1, w_ra2, w_rd1, w_rd2, w_wa, w_we, w_wd);
  input  wire w_clk, w_we;
  input  wire [4:0] w_ra1, w_ra2, w_wa;
  output wire [31:0] w_rd1, w_rd2;
  input  wire [31:0] w_wd;
  reg [31:0] mem [0:31];
  assign w_rd1 = (w_ra1==5'd0) ? 32'd0 : mem[w_ra1];
  assign w_rd2 = (w_ra2==5'd0) ? 32'd0 : mem[w_ra2];
  always @(posedge w_clk) if (w_we) mem[w_wa] <= w_wd;
  always @(posedge w_clk) if (w_we & w_wa==5'd30) $finish;
  integer i; initial for (i=0; i<32; i=i+1) mem[i] = 0;
endmodule

module m_RF2(w_clk, w_ra1, w_ra2, w_rd1, w_rd2, w_wa, w_we, w_wd);
  input  wire w_clk, w_we;
  input  wire [4:0] w_ra1, w_ra2, w_wa;
  output wire [31:0] w_rd1, w_rd2;
  input  wire [31:0] w_wd;
  reg [31:0] mem [0:31];
  wire w_bp1 = (w_we & w_ra1==w_wa);
  wire w_bp2 = (w_we & w_ra2==w_wa);
  assign w_rd1 = (w_ra1==5'd0) ? 32'd0 : (w_bp1) ? w_wd : mem[w_ra1];
  assign w_rd2 = (w_ra2==5'd0) ? 32'd0 : (w_bp2) ? w_wd : mem[w_ra2];
  always @(posedge w_clk) if (w_we) mem[w_wa] <= w_wd;
  always @(posedge w_clk) if (w_we & w_wa==5'd30) $finish;
  integer i; initial for (i=0; i<32; i=i+1) mem[i] = 32'd0;
endmodule

module m_get_type(opcode5, r, i ,s, b, u, j);
  input wire [4:0] opcode5;
  output wire r, i, s ,b, u, j;
  assign j = (opcode5==5'b11011);
  assign b = (opcode5==5'b11000);
  assign s = (opcode5==5'b01000);
  assign r = (opcode5==5'b01100);
  assign u = (opcode5==5'b01101 || opcode5==5'b00101);
  assign i = ~(r | s | b | u | j);
endmodule

module m_get_imm(ir, i, s, b, u, j, imm);
  input wire [31:0] ir;
  input wire i, s, b, u, j;
  output wire [31:0] imm;
  assign imm= (i) ? {{20{ir[31]}},ir[31:20]} :
              (s) ? {{20{ir[31]}},ir[31:25],ir[11:7]} :
              (b) ? {{20{ir[31]}},ir[7],ir[30:25],ir[11:8],1'b0} :
              (u) ? {ir[31:12],12'b0} :
              (j) ? {{12{ir[31]}},ir[19:12],ir[20],ir[30:21],1'b0} : 0;
endmodule

module m_gen_imm(w_ir, w_imm, w_r, w_i, w_s, w_b, w_u, w_j, w_ld);
  input  wire [31:0] w_ir;
  output wire [31:0] w_imm;
  output wire w_r, w_i, w_s, w_b, w_u, w_j, w_ld;
  m_get_type m1 (w_ir[6:2], w_r, w_i, w_s, w_b, w_u, w_j); // 4-3
  m_get_imm  m2 (w_ir, w_i, w_s, w_b, w_u, w_j, w_imm); // 4-5
  assign w_ld = (w_ir[6:2]==0);
endmodule

module m_am_imem(w_pc, w_insn);
  input  wire [31:0] w_pc;
  output wire [31:0] w_insn;
  reg [31:0] mem[0:63];
  assign w_insn = mem[w_pc[7:2]];
  integer i; initial for (i=0; i<64; i=i+1) mem[i] = 32'd0;
endmodule

module m_sm_imem(w_clk, w_pc, r_insn);
  input wire w_clk;
  input wire [31:0] w_pc;
  output reg [31:0] r_insn;
  reg [31:0] mem [0:63];
  always @(posedge w_clk) r_insn <= mem[w_pc[7:2]];
  integer i; initial for (i=0; i<64; i=i+1) mem[i] = 32'd0;
endmodule

module m_am_dmem(w_clk, w_adr, w_we, w_wd, w_rd);
  input  wire w_clk, w_we;
  input  wire [31:0] w_adr, w_wd;
  output wire [31:0] w_rd;
  reg [31:0] mem [0:63];
  assign w_rd = mem[w_adr[7:2]];
  always @(posedge w_clk) if (w_we) mem[w_adr[7:2]] <= w_wd;
  integer i; initial for (i=0; i<64; i=i+1) mem[i] = 32'd0;
endmodule

module m_sm_dmem(w_clk, w_adr, w_we, w_wd, w_rd);
  input  wire w_clk, w_we;
  input  wire [31:0] w_adr, w_wd;
  output reg [31:0] w_rd;
  reg [31:0] mem [0:63];
  always @(posedge w_clk) w_rd <= mem[w_adr[7:2]];
  always @(posedge w_clk) if (w_we) mem[w_adr[7:2]] <= w_wd;
  integer i; initial for (i=0; i<64; i=i+1) mem[i] = 32'd0;
endmodule

module m_alu(w_in1, w_in2, w_out, w_tkn);
  input  wire [31:0] w_in1, w_in2;
  output wire [31:0] w_out;
  output wire w_tkn;
  assign w_out = w_in1 + w_in2;
  assign w_tkn = w_in1 != w_in2;
endmodule

module m_btb(w_clk, w_pc, w_hit, w_dout, w_wadr, w_we, w_wd);
  input  wire w_clk, w_we;
  input  wire [31:0] w_pc;
  input  wire [4:0] w_wadr;
  input  wire [57:0] w_wd;
  output wire w_hit;
  output wire [31:0] w_dout;
  wire w_v;
  wire [24:0] w_tag;
  wire [31:0] w_data;
  reg [57:0] mem [0:31];
  always @(posedge w_clk) if (w_we) mem[w_wadr] <= w_wd;
  assign {w_v, w_tag, w_data} = mem[w_pc[6:2]];
  assign w_hit = w_v & (w_tag==w_pc[31:7]);
  assign w_dout = w_data;
  integer i; initial for (i=0; i<32; i=i+1) mem[i] = 0;
endmodule

module m_pht(w_clk, w_radr, w_rd, w_wadr, w_we, w_wd);
  input  wire w_clk, w_we;
  input  wire [4:0] w_wadr, w_radr;
  input  wire w_wd;
  output wire w_rd;
  reg [0:0] mem [0:31];
  assign w_rd = mem[w_radr];
  always @(posedge w_clk) if (w_we) mem[w_wadr] <= w_wd;
  integer i; initial for (i=0; i<32; i=i+1) mem[i] = 0;
endmodule

module m_bimodal(w_clk, w_radr, w_pred, w_wadr, w_we, w_tkn);
  input  wire w_clk, w_we;
  input  wire [4:0] w_wadr, w_radr;
  input  wire w_tkn;
  output wire w_pred;
  reg [1:0] mem [0:31];
  wire [1:0] w_data = mem[w_radr];
  assign w_pred = w_data[1];
  reg [1:0] P1_cnt = 0, P2_cnt = 0;
  always @(posedge w_clk) {P1_cnt, P2_cnt} <= {w_data, P1_cnt};
  always @(posedge w_clk) if (w_we)
    mem[w_wadr] <= (P2_cnt < 3 &  w_tkn) ? P2_cnt + 1 :
                   (P2_cnt > 0 & !w_tkn) ? P2_cnt - 1 : P2_cnt;
  integer i; initial for (i=0; i<32; i=i+1) mem[i] = 1;
endmodule

module m_gshare(w_clk, w_radr, w_pred, w_wadr, w_we, w_tkn);
  input  wire w_clk, w_we;
  input  wire [4:0] w_wadr, w_radr;
  input  wire w_tkn;
  output wire w_pred;
  reg [1:0] mem [0:31];
  reg [4:0] r_bhr = 0;
  always @(posedge w_clk) if (w_we) r_bhr <= {w_tkn, r_bhr[4:1]};
  wire [1:0] w_data = mem[w_radr ^ r_bhr];
  assign w_pred = w_data[1];
  reg [1:0] P1_cnt = 0, P2_cnt = 0;
  always @(posedge w_clk) {P1_cnt, P2_cnt} <= {w_data, P1_cnt};
  always @(posedge w_clk) if (w_we)
    mem[w_wadr ^ r_bhr] <= (P2_cnt < 3 &  w_tkn) ? P2_cnt + 1 :
                           (P2_cnt > 0 & !w_tkn) ? P2_cnt - 1 : P2_cnt;
  integer i; initial for (i=0; i<32; i=i+1) mem[i] = 1;
endmodule

`define D_DELAY 3
module m_imem(w_clk, w_pc, w_re, r_insn, r_oe);
  input  wire w_clk, w_re;
  input  wire [31:0] w_pc;
  output reg  [31:0] r_insn = 0;
  output reg  r_oe = 0;
  reg [31:0] mem [0:2047];
  reg [31:0] r_c=1, r_pc=0;
  always @(posedge w_clk) begin
    r_pc <= (r_c==1 & w_re) ? w_pc : r_pc;
    r_c <= (r_c==1 & w_re) ? 2 : (r_c==1 | r_c==`D_DELAY) ? 1 : r_c+1;
    r_oe <= (r_c==`D_DELAY-1);
    r_insn <= (r_c==`D_DELAY-1) ? mem[r_pc[12:2]] : 0;
  end
  integer i; initial for (i=0; i<2048; i=i+1) mem[i] = 32'd0;
endmodule

module m_cache1(w_clk, w_adr, w_hit, w_dout, w_wadr, w_we, w_wd);
  input  wire w_clk, w_we;
  input  wire [31:0] w_adr;
  input  wire [4:0] w_wadr;
  input  wire [57:0] w_wd;
  output wire w_hit;
  output wire [31:0] w_dout;
  wire w_v;
  wire [24:0] w_tag;
  reg [57:0] mem [0:31];
  always @(posedge w_clk) if (w_we) mem[w_wadr] <= w_wd;
  assign {w_v, w_tag, w_dout} = mem[w_adr[6:2]];
  assign w_hit = w_v & (w_tag==w_adr[31:7]);
  integer i; initial for (i=0; i<32; i=i+1) mem[i] = 0;
endmodule

module m_cache3(w_clk, w_adr, w_hit, w_dout, w_wadr, w_we, w_wd);
  input  wire w_clk, w_we;
  input  wire [31:0] w_adr;
  input  wire [4:0] w_wadr;
  input  wire [57:0] w_wd;
  output wire w_hit;
  output wire [31:0] w_dout;
  wire w_hit1, w_hit2, w_we1, w_we2;
  wire [31:0] w_dout1, w_dout2;
  m_cache1 way1 (w_clk, w_adr, w_hit1, w_dout1, w_wadr, w_we1, w_wd);
  m_cache1 way2 (w_clk, w_adr, w_hit2, w_dout2, w_wadr, w_we2, w_wd);
  assign w_hit = w_hit1 | w_hit2;
  assign w_dout = (w_hit1) ? w_dout1 : w_dout2;
  reg [0:0] lru [0:31];
  always @(posedge w_clk) if (w_hit) lru[w_adr[6:2]] <= w_hit1;
  assign w_we1 = (w_we & lru[w_wadr]==0);
  assign w_we2 = (w_we & lru[w_wadr]==1);
  integer i; initial for (i=0; i<32; i=i+1) lru[i] = 0;
endmodule

