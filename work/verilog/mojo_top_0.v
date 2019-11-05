/*
   This file was generated automatically by the Mojo IDE version B1.3.6.
   Do not edit this file directly. Instead edit the original Lucid source.
   This is a temporary file and any changes made to it will be destroyed.
*/

module mojo_top_0 (
    input clk,
    input rst_n,
    input cclk,
    input spi_ss,
    input spi_mosi,
    input spi_sck,
    input avr_tx,
    input avr_rx_busy,
    output reg [7:0] io_seg,
    output reg [3:0] io_sel,
    input [4:0] io_button,
    input [23:0] io_dip
  );
  
  
  
  reg rst;
  
  localparam TIME = 5'h1c;
  
  wire [1-1:0] M_reset_cond_out;
  reg [1-1:0] M_reset_cond_in;
  reset_conditioner_1 reset_cond (
    .clk(clk),
    .in(M_reset_cond_in),
    .out(M_reset_cond_out)
  );
  reg [15:0] M_register_a_d, M_register_a_q = 1'h0;
  reg [15:0] M_register_b_d, M_register_b_q = 1'h0;
  reg [5:0] M_register_alufn_d, M_register_alufn_q = 1'h0;
  reg [28:0] M_count_d, M_count_q = 1'h0;
  localparam IDLE_state = 5'd0;
  localparam START_state = 5'd1;
  localparam MANUAL_state = 5'd2;
  localparam CASEP_ADD_state = 5'd3;
  localparam CASEP_SUBTRACT1_state = 5'd4;
  localparam CASEN_SUBTRACT2_state = 5'd5;
  localparam CASE_OVERFLOW_PPNA_state = 5'd6;
  localparam CASE_OVERFLOW_NNPA_state = 5'd7;
  localparam CASE_OVERFLOW_NPPS_state = 5'd8;
  localparam CASE_AND_state = 5'd9;
  localparam CASE_OR_state = 5'd10;
  localparam CASE_XOR_state = 5'd11;
  localparam CASE_A_state = 5'd12;
  localparam CASE_SHL_state = 5'd13;
  localparam CASE_SHR_state = 5'd14;
  localparam CASE_SRA_state = 5'd15;
  localparam CASE_CMPEQ_T_state = 5'd16;
  localparam CASE_CMPEQ_F_state = 5'd17;
  localparam CASE_CMPLT_T_state = 5'd18;
  localparam CASE_CMPLT_F_state = 5'd19;
  localparam CASE_CMPLE_T1_state = 5'd20;
  localparam CASE_CMPLE_F1_state = 5'd21;
  localparam CASE_CMPLE_T2_state = 5'd22;
  localparam CASE_MUL1_state = 5'd23;
  
  reg [4:0] M_state_d, M_state_q = IDLE_state;
  wire [7-1:0] M_seg_seg;
  wire [4-1:0] M_seg_sel;
  reg [20-1:0] M_seg_values;
  multi_seven_seg_2 seg (
    .clk(clk),
    .rst(rst),
    .values(M_seg_values),
    .seg(M_seg_seg),
    .sel(M_seg_sel)
  );
  
  reg [15:0] a;
  
  reg [15:0] b;
  
  reg [5:0] alufn;
  
  reg [15:0] alu;
  
  reg [28:0] time_hold;
  
  wire [16-1:0] M_alucall_alu;
  wire [1-1:0] M_alucall_z;
  wire [1-1:0] M_alucall_v;
  wire [1-1:0] M_alucall_n;
  reg [16-1:0] M_alucall_a;
  reg [16-1:0] M_alucall_b;
  reg [6-1:0] M_alucall_alufn;
  alu_3 alucall (
    .a(M_alucall_a),
    .b(M_alucall_b),
    .alufn(M_alucall_alufn),
    .alu(M_alucall_alu),
    .z(M_alucall_z),
    .v(M_alucall_v),
    .n(M_alucall_n)
  );
  
  always @* begin
    M_state_d = M_state_q;
    M_register_b_d = M_register_b_q;
    M_register_a_d = M_register_a_q;
    M_count_d = M_count_q;
    M_register_alufn_d = M_register_alufn_q;
    
    M_reset_cond_in = ~rst_n;
    rst = M_reset_cond_out;
    time_hold = M_count_q - 1'h1;
    io_seg = 8'hff;
    io_sel = 4'hf;
    M_seg_values = 20'h00000;
    io_sel = 4'hf;
    a = 8'h00;
    b = 8'h00;
    alufn = io_dip[0+2+5-:6];
    M_alucall_alufn = alufn;
    M_alucall_a = a;
    M_alucall_b = b;
    alu = M_alucall_alu;
    
    case (M_state_q)
      START_state: begin
        if (io_button[0+0-:1]) begin
          M_state_d = CASEP_ADD_state;
        end
        if (io_dip[0+0+0-:1]) begin
          M_state_d = MANUAL_state;
        end
      end
      MANUAL_state: begin
        if (io_dip[0+1+0-:1]) begin
          a[0+7-:8] = io_dip[8+7-:8];
          a[8+7-:8] = io_dip[16+7-:8];
          if (io_button[1+0-:1]) begin
            M_register_a_d = a;
          end else begin
            b[0+7-:8] = io_dip[8+7-:8];
            b[8+7-:8] = io_dip[16+7-:8];
          end
          if (io_button[1+0-:1]) begin
            M_register_b_d = b;
          end
        end
        alufn = io_dip[0+2+5-:6];
        if (io_button[2+0-:1]) begin
          M_register_alufn_d = alufn;
        end
        if (io_button[3+0-:1]) begin
          M_register_a_d = 16'h0000;
          M_register_b_d = 16'h0000;
          M_register_alufn_d = 6'h00;
        end
        M_alucall_a = M_register_a_q;
        M_alucall_b = M_register_b_q;
        M_alucall_alufn = M_register_alufn_q;
        alu = M_alucall_alu;
        if (io_button[3+0-:1]) begin
          M_state_d = START_state;
        end
      end
      CASEP_ADD_state: begin
        M_alucall_alufn = 1'h0;
        M_alucall_a = 44'ha0123196199;
        M_alucall_b = 44'ha0377bc51f5;
        alu = M_alucall_alu;
        if (io_dip[16+7+0-:1]) begin
          alu = alu + 1'h1;
        end
        if (alu == 47'h640db3a0a116) begin
          M_seg_values[15+4-:5] = 5'h0a;
          M_seg_values[10+4-:5] = 5'h0d;
          M_seg_values[5+4-:5] = 5'h0d;
          M_seg_values[0+4-:5] = 5'h01;
          io_seg = ~M_seg_seg;
          io_sel = ~M_seg_sel;
        end else begin
          M_seg_values[15+4-:5] = 5'h0f;
          M_seg_values[10+4-:5] = 5'h0f;
          M_seg_values[5+4-:5] = 5'h0f;
          M_seg_values[0+4-:5] = 5'h08;
          io_seg = ~M_seg_seg;
          io_sel = ~M_seg_sel;
        end
        if (io_dip[0+0+0-:1]) begin
          M_state_d = MANUAL_state;
        end
        M_count_d = M_count_q + 1'h1;
        if (io_button[0+0-:1] | (M_count_q[28+0-:1] ^ time_hold[28+0-:1])) begin
          M_count_d = 1'h0;
          M_state_d = CASEP_SUBTRACT1_state;
        end
      end
      CASEP_SUBTRACT1_state: begin
        M_alucall_alufn = 1'h1;
        M_alucall_a = 50'h3f28cb7156dde;
        M_alucall_b = 11'h44c;
        alu = M_alucall_alu;
        if (alu == 11'h44d) begin
          M_seg_values[15+4-:5] = 5'h05;
          M_seg_values[10+4-:5] = 5'h03;
          M_seg_values[5+4-:5] = 5'h0b;
          M_seg_values[0+4-:5] = 5'h01;
          io_seg = ~M_seg_seg;
          io_sel = ~M_seg_sel;
        end else begin
          M_seg_values[15+4-:5] = 5'h0f;
          M_seg_values[10+4-:5] = 5'h0f;
          M_seg_values[5+4-:5] = 5'h0f;
          M_seg_values[0+4-:5] = 5'h08;
          io_seg = ~M_seg_seg;
          io_sel = ~M_seg_sel;
        end
        if (io_dip[0+0+0-:1]) begin
          M_state_d = MANUAL_state;
        end
        M_count_d = M_count_q + 1'h1;
        if (io_button[0+0-:1] | (M_count_q[28+0-:1] ^ time_hold[28+0-:1])) begin
          M_count_d = 1'h0;
          M_state_d = CASEN_SUBTRACT2_state;
        end
      end
      CASEN_SUBTRACT2_state: begin
        M_alucall_alufn = 1'h1;
        M_alucall_a = 50'h3f28cb7157163;
        M_alucall_b = 11'h44c;
        alu = M_alucall_alu;
        if (alu == 50'h3f28cb7154a52) begin
          M_seg_values[15+4-:5] = 5'h05;
          M_seg_values[10+4-:5] = 5'h03;
          M_seg_values[5+4-:5] = 5'h0b;
          M_seg_values[0+4-:5] = 5'h16;
          io_seg = ~M_seg_seg;
          io_sel = ~M_seg_sel;
        end else begin
          M_seg_values[15+4-:5] = 5'h0f;
          M_seg_values[10+4-:5] = 5'h0f;
          M_seg_values[5+4-:5] = 5'h0f;
          M_seg_values[0+4-:5] = 5'h08;
          io_seg = ~M_seg_seg;
          io_sel = ~M_seg_sel;
        end
        if (io_dip[0+0+0-:1]) begin
          M_state_d = MANUAL_state;
        end
        M_count_d = M_count_q + 1'h1;
        if (io_button[0+0-:1] | M_count_q[28+0-:1] == 1'h1) begin
          M_count_d = 1'h0;
          M_state_d = CASE_OVERFLOW_PPNA_state;
        end
      end
      CASE_OVERFLOW_PPNA_state: begin
        M_alucall_alufn = 1'h0;
        M_alucall_a = 47'h5af3107a4000;
        M_alucall_b = 47'h5af3107a4000;
        alu = M_alucall_alu;
        if (alu == 50'h38d7ea4c68000) begin
          M_seg_values[15+4-:5] = 5'h06;
          M_seg_values[10+4-:5] = 5'h06;
          M_seg_values[5+4-:5] = 5'h10;
          M_seg_values[0+4-:5] = 5'h0a;
          io_seg = ~M_seg_seg;
          io_sel = ~M_seg_sel;
        end else begin
          M_seg_values[15+4-:5] = 5'h0f;
          M_seg_values[10+4-:5] = 5'h0f;
          M_seg_values[5+4-:5] = 5'h0f;
          M_seg_values[0+4-:5] = 5'h08;
          io_seg = ~M_seg_seg;
          io_sel = ~M_seg_sel;
        end
        if (io_dip[0+0+0-:1]) begin
          M_state_d = MANUAL_state;
        end
        M_count_d = M_count_q + 1'h1;
        if (io_button[0+0-:1] | (M_count_q[28+0-:1] ^ time_hold[28+0-:1])) begin
          M_count_d = 1'h0;
          M_state_d = CASE_OVERFLOW_NNPA_state;
        end
      end
      CASE_OVERFLOW_NNPA_state: begin
        M_alucall_alufn = 1'h0;
        M_alucall_a = 50'h38d7ea4c683e8;
        M_alucall_b = 50'h38d7ea4c683e8;
        alu = M_alucall_alu;
        if (alu == 14'h2710) begin
          M_seg_values[15+4-:5] = 5'h10;
          M_seg_values[10+4-:5] = 5'h06;
          M_seg_values[5+4-:5] = 5'h06;
          M_seg_values[0+4-:5] = 5'h0a;
          io_seg = ~M_seg_seg;
          io_sel = ~M_seg_sel;
        end else begin
          M_seg_values[15+4-:5] = 5'h0f;
          M_seg_values[10+4-:5] = 5'h0f;
          M_seg_values[5+4-:5] = 5'h0f;
          M_seg_values[0+4-:5] = 5'h08;
          io_seg = ~M_seg_seg;
          io_sel = ~M_seg_sel;
        end
        if (io_dip[0+0+0-:1]) begin
          M_state_d = MANUAL_state;
        end
        M_count_d = M_count_q + 1'h1;
        if (io_button[0+0-:1] | (M_count_q[28+0-:1] ^ time_hold[28+0-:1])) begin
          M_count_d = 1'h0;
          M_state_d = CASE_OVERFLOW_NPPS_state;
        end
      end
      CASE_OVERFLOW_NPPS_state: begin
        M_alucall_alufn = 1'h1;
        M_alucall_a = 50'h3e871b540c000;
        M_alucall_b = 47'h5af3107a4000;
        alu = M_alucall_alu;
        if (alu == 47'h5af3107a4000) begin
          M_seg_values[15+4-:5] = 5'h10;
          M_seg_values[10+4-:5] = 5'h06;
          M_seg_values[5+4-:5] = 5'h06;
          M_seg_values[0+4-:5] = 5'h0a;
          io_seg = ~M_seg_seg;
          io_sel = ~M_seg_sel;
        end else begin
          M_seg_values[15+4-:5] = 5'h0f;
          M_seg_values[10+4-:5] = 5'h0f;
          M_seg_values[5+4-:5] = 5'h0f;
          M_seg_values[0+4-:5] = 5'h08;
          io_seg = ~M_seg_seg;
          io_sel = ~M_seg_sel;
        end
        if (io_dip[0+0+0-:1]) begin
          M_state_d = MANUAL_state;
        end
        M_count_d = M_count_q + 1'h1;
        if (io_button[0+0-:1] | (M_count_q[28+0-:1] ^ time_hold[28+0-:1])) begin
          M_count_d = 1'h0;
          M_state_d = CASE_AND_state;
        end
      end
      CASE_AND_state: begin
        M_alucall_alufn = 14'h2af8;
        M_alucall_a = 47'h6422e30dfbbf;
        M_alucall_b = 50'h396b08fcb3232;
        alu = M_alucall_alu;
        if (io_dip[16+7+0-:1]) begin
          alu = alu + 1'h1;
        end
        if (alu == 44'h92f96f8ca4a) begin
          M_seg_values[15+4-:5] = 5'h0a;
          M_seg_values[10+4-:5] = 5'h10;
          M_seg_values[5+4-:5] = 5'h0d;
          M_seg_values[0+4-:5] = 5'h08;
          io_seg = ~M_seg_seg;
          io_sel = ~M_seg_sel;
        end else begin
          M_seg_values[15+4-:5] = 5'h0f;
          M_seg_values[10+4-:5] = 5'h0f;
          M_seg_values[5+4-:5] = 5'h0f;
          M_seg_values[0+4-:5] = 5'h08;
          io_seg = ~M_seg_seg;
          io_sel = ~M_seg_sel;
        end
        if (io_dip[0+0+0-:1]) begin
          M_state_d = MANUAL_state;
        end
        M_count_d = M_count_q + 1'h1;
        if (io_button[0+0-:1] | (M_count_q[28+0-:1] ^ time_hold[28+0-:1])) begin
          M_count_d = 1'h0;
          M_state_d = CASE_OR_state;
        end
      end
      CASE_OR_state: begin
        M_alucall_alufn = 14'h2b66;
        M_alucall_a = 47'h6422a7733151;
        M_alucall_b = 50'h396b08fbd7688;
        alu = M_alucall_alu;
        if (alu == 50'h3f1a3a0471fd9) begin
          M_seg_values[15+4-:5] = 5'h00;
          M_seg_values[10+4-:5] = 5'h02;
          M_seg_values[5+4-:5] = 5'h08;
          M_seg_values[0+4-:5] = 5'h08;
          io_seg = ~M_seg_seg;
          io_sel = ~M_seg_sel;
        end else begin
          M_seg_values[15+4-:5] = 5'h0f;
          M_seg_values[10+4-:5] = 5'h0f;
          M_seg_values[5+4-:5] = 5'h0f;
          M_seg_values[0+4-:5] = 5'h08;
          io_seg = ~M_seg_seg;
          io_sel = ~M_seg_sel;
        end
        if (io_dip[0+0+0-:1]) begin
          M_state_d = MANUAL_state;
        end
        M_count_d = M_count_q + 1'h1;
        if (io_button[0+0-:1] | (M_count_q[28+0-:1] ^ time_hold[28+0-:1])) begin
          M_count_d = 1'h0;
          M_state_d = CASE_XOR_state;
        end
      end
      CASE_XOR_state: begin
        M_alucall_alufn = 14'h277e;
        M_alucall_a = 47'h6422a77331bf;
        M_alucall_b = 50'h396b09054ad82;
        alu = M_alucall_alu;
        if (alu == 50'h3e87409f4810d) begin
          M_seg_values[15+4-:5] = 5'h11;
          M_seg_values[10+4-:5] = 5'h00;
          M_seg_values[5+4-:5] = 5'h02;
          M_seg_values[0+4-:5] = 5'h08;
          io_seg = ~M_seg_seg;
          io_sel = ~M_seg_sel;
        end else begin
          M_seg_values[15+4-:5] = 5'h0f;
          M_seg_values[10+4-:5] = 5'h0f;
          M_seg_values[5+4-:5] = 5'h0f;
          M_seg_values[0+4-:5] = 5'h08;
          io_seg = ~M_seg_seg;
          io_sel = ~M_seg_sel;
        end
        if (io_dip[0+0+0-:1]) begin
          M_state_d = MANUAL_state;
        end
        M_count_d = M_count_q + 1'h1;
        if (io_button[0+0-:1] | (M_count_q[28+0-:1] ^ time_hold[28+0-:1])) begin
          M_count_d = 1'h0;
          M_state_d = CASE_A_state;
        end
      end
      CASE_A_state: begin
        M_alucall_alufn = 14'h2b02;
        M_alucall_a = 50'h39696f3394af9;
        M_alucall_b = 50'h396b08fbbefe8;
        alu = M_alucall_alu;
        if (alu == 50'h39696f3394af9) begin
          M_seg_values[15+4-:5] = 5'h0a;
          M_seg_values[10+4-:5] = 5'h08;
          M_seg_values[5+4-:5] = 5'h08;
          M_seg_values[0+4-:5] = 5'h08;
          io_seg = ~M_seg_seg;
          io_sel = ~M_seg_sel;
        end else begin
          M_seg_values[15+4-:5] = 5'h0f;
          M_seg_values[10+4-:5] = 5'h0f;
          M_seg_values[5+4-:5] = 5'h0f;
          M_seg_values[0+4-:5] = 5'h08;
          io_seg = ~M_seg_seg;
          io_sel = ~M_seg_sel;
        end
        if (io_dip[0+0+0-:1]) begin
          M_state_d = MANUAL_state;
        end
        M_count_d = M_count_q + 1'h1;
        if (io_button[0+0-:1] | (M_count_q[28+0-:1] ^ time_hold[28+0-:1])) begin
          M_count_d = 1'h0;
          M_state_d = CASE_SHL_state;
        end
      end
      CASE_SHL_state: begin
        M_alucall_alufn = 17'h186a0;
        M_alucall_a = 47'h5b0a5901f52c;
        M_alucall_b = 10'h3e8;
        alu = M_alucall_alu;
        if (io_dip[16+7+0-:1]) begin
          alu = alu + 1'h1;
        end
        if (alu == 47'h6424fb6fac00) begin
          M_seg_values[15+4-:5] = 5'h05;
          M_seg_values[10+4-:5] = 5'h11;
          M_seg_values[5+4-:5] = 5'h04;
          M_seg_values[0+4-:5] = 5'h08;
          io_seg = ~M_seg_seg;
          io_sel = ~M_seg_sel;
        end else begin
          M_seg_values[15+4-:5] = 5'h0f;
          M_seg_values[10+4-:5] = 5'h0f;
          M_seg_values[5+4-:5] = 5'h0f;
          M_seg_values[0+4-:5] = 5'h08;
          io_seg = ~M_seg_seg;
          io_sel = ~M_seg_sel;
        end
        if (io_dip[0+0+0-:1]) begin
          M_state_d = MANUAL_state;
        end
        M_count_d = M_count_q + 1'h1;
        if (io_button[0+0-:1] | (M_count_q[28+0-:1] ^ time_hold[28+0-:1])) begin
          M_count_d = 1'h0;
          M_state_d = CASE_SHR_state;
        end
      end
      CASE_SHR_state: begin
        M_alucall_alufn = 17'h186a1;
        M_alucall_a = 47'h6424fc193270;
        M_alucall_b = 7'h6e;
        alu = M_alucall_alu;
        if (alu == 21'h10cd2c) begin
          M_seg_values[15+4-:5] = 5'h05;
          M_seg_values[10+4-:5] = 5'h11;
          M_seg_values[5+4-:5] = 5'h02;
          M_seg_values[0+4-:5] = 5'h08;
          io_seg = ~M_seg_seg;
          io_sel = ~M_seg_sel;
        end else begin
          M_seg_values[15+4-:5] = 5'h0f;
          M_seg_values[10+4-:5] = 5'h0f;
          M_seg_values[5+4-:5] = 5'h0f;
          M_seg_values[0+4-:5] = 5'h08;
          io_seg = ~M_seg_seg;
          io_sel = ~M_seg_sel;
        end
        if (io_dip[0+0+0-:1]) begin
          M_state_d = MANUAL_state;
        end
        M_count_d = M_count_q + 1'h1;
        if (io_button[0+0-:1] | (M_count_q[28+0-:1] ^ time_hold[28+0-:1])) begin
          M_count_d = 1'h0;
          M_state_d = CASE_SRA_state;
        end
      end
      CASE_SRA_state: begin
        M_alucall_alufn = 17'h186ab;
        M_alucall_a = 50'h3e888fdc870e1;
        M_alucall_b = 7'h64;
        alu = M_alucall_alu;
        if (alu == 50'h3f28c7573d2ee) begin
          M_seg_values[15+4-:5] = 5'h05;
          M_seg_values[10+4-:5] = 5'h11;
          M_seg_values[5+4-:5] = 5'h0a;
          M_seg_values[0+4-:5] = 5'h08;
          io_seg = ~M_seg_seg;
          io_sel = ~M_seg_sel;
        end else begin
          M_seg_values[15+4-:5] = 5'h0f;
          M_seg_values[10+4-:5] = 5'h0f;
          M_seg_values[5+4-:5] = 5'h0f;
          M_seg_values[0+4-:5] = 5'h08;
          io_seg = ~M_seg_seg;
          io_sel = ~M_seg_sel;
        end
        if (io_dip[0+0+0-:1]) begin
          M_state_d = MANUAL_state;
        end
        M_count_d = M_count_q + 1'h1;
        if (io_button[0+0-:1] | (M_count_q[28+0-:1] ^ time_hold[28+0-:1])) begin
          M_count_d = 1'h0;
          M_state_d = CASE_CMPEQ_T_state;
        end
      end
      CASE_CMPEQ_T_state: begin
        M_alucall_alufn = 17'h1adbb;
        M_alucall_a = 14'h2775;
        M_alucall_b = 14'h2775;
        alu = M_alucall_alu;
        if (io_dip[16+7+0-:1]) begin
          alu = alu + 1'h1;
        end
        if (alu == 1'h1) begin
          M_seg_values[15+4-:5] = 5'h0e;
          M_seg_values[10+4-:5] = 5'h01;
          M_seg_values[5+4-:5] = 5'h08;
          M_seg_values[0+4-:5] = 5'h08;
          io_seg = ~M_seg_seg;
          io_sel = ~M_seg_sel;
        end else begin
          M_seg_values[15+4-:5] = 5'h0f;
          M_seg_values[10+4-:5] = 5'h0f;
          M_seg_values[5+4-:5] = 5'h0f;
          M_seg_values[0+4-:5] = 5'h08;
          io_seg = ~M_seg_seg;
          io_sel = ~M_seg_sel;
        end
        if (io_dip[0+0+0-:1]) begin
          M_state_d = MANUAL_state;
        end
        M_count_d = M_count_q + 1'h1;
        if (io_button[0+0-:1] | (M_count_q[28+0-:1] ^ time_hold[28+0-:1])) begin
          M_count_d = 1'h0;
          M_state_d = CASE_CMPEQ_F_state;
        end
      end
      CASE_CMPEQ_F_state: begin
        M_alucall_alufn = 17'h1adbb;
        M_alucall_a = 14'h2775;
        M_alucall_b = 7'h64;
        alu = M_alucall_alu;
        if (alu == 1'h0) begin
          M_seg_values[15+4-:5] = 5'h0e;
          M_seg_values[10+4-:5] = 5'h0f;
          M_seg_values[5+4-:5] = 5'h08;
          M_seg_values[0+4-:5] = 5'h08;
          io_seg = ~M_seg_seg;
          io_sel = ~M_seg_sel;
        end else begin
          M_seg_values[15+4-:5] = 5'h0f;
          M_seg_values[10+4-:5] = 5'h0f;
          M_seg_values[5+4-:5] = 5'h0f;
          M_seg_values[0+4-:5] = 5'h08;
          io_seg = ~M_seg_seg;
          io_sel = ~M_seg_sel;
        end
        if (io_dip[0+0+0-:1]) begin
          M_state_d = MANUAL_state;
        end
        M_count_d = M_count_q + 1'h1;
        if (io_button[0+0-:1] | (M_count_q[28+0-:1] ^ time_hold[28+0-:1])) begin
          M_count_d = 1'h0;
          M_state_d = CASE_CMPLT_T_state;
        end
      end
      CASE_CMPLT_T_state: begin
        M_alucall_alufn = 17'h1ae15;
        M_alucall_a = 10'h3e8;
        M_alucall_b = 14'h2710;
        alu = M_alucall_alu;
        if (alu == 1'h1) begin
          M_seg_values[15+4-:5] = 5'h04;
          M_seg_values[10+4-:5] = 5'h01;
          M_seg_values[5+4-:5] = 5'h08;
          M_seg_values[0+4-:5] = 5'h08;
          io_seg = ~M_seg_seg;
          io_sel = ~M_seg_sel;
        end else begin
          M_seg_values[15+4-:5] = 5'h0f;
          M_seg_values[10+4-:5] = 5'h0f;
          M_seg_values[5+4-:5] = 5'h0f;
          M_seg_values[0+4-:5] = 5'h08;
          io_seg = ~M_seg_seg;
          io_sel = ~M_seg_sel;
        end
        if (io_dip[0+0+0-:1]) begin
          M_state_d = MANUAL_state;
        end
        M_count_d = M_count_q + 1'h1;
        if (io_button[0+0-:1] | (M_count_q[28+0-:1] ^ time_hold[28+0-:1])) begin
          M_count_d = 1'h0;
          M_state_d = CASE_CMPLT_F_state;
        end
      end
      CASE_CMPLT_F_state: begin
        M_alucall_alufn = 17'h1ae15;
        M_alucall_a = 7'h6e;
        M_alucall_b = 50'h38d7ea4c68000;
        alu = M_alucall_alu;
        if (alu == 1'h0) begin
          M_seg_values[15+4-:5] = 5'h04;
          M_seg_values[10+4-:5] = 5'h0f;
          M_seg_values[5+4-:5] = 5'h00;
          M_seg_values[0+4-:5] = 5'h08;
          io_seg = ~M_seg_seg;
          io_sel = ~M_seg_sel;
        end else begin
          M_seg_values[15+4-:5] = 5'h0f;
          M_seg_values[10+4-:5] = 5'h0f;
          M_seg_values[5+4-:5] = 5'h0f;
          M_seg_values[0+4-:5] = 5'h08;
          io_seg = ~M_seg_seg;
          io_sel = ~M_seg_sel;
        end
        if (io_dip[0+0+0-:1]) begin
          M_state_d = MANUAL_state;
        end
        M_count_d = M_count_q + 1'h1;
        if (io_button[0+0-:1] | (M_count_q[28+0-:1] ^ time_hold[28+0-:1])) begin
          M_count_d = 1'h0;
          M_state_d = CASE_CMPLE_T1_state;
        end
      end
      CASE_CMPLE_T1_state: begin
        M_alucall_alufn = 17'h1ae1f;
        M_alucall_a = 50'h38d7ea4c68000;
        M_alucall_b = 14'h2710;
        alu = M_alucall_alu;
        if (alu == 1'h1) begin
          M_seg_values[15+4-:5] = 5'h04;
          M_seg_values[10+4-:5] = 5'h0e;
          M_seg_values[5+4-:5] = 5'h01;
          M_seg_values[0+4-:5] = 5'h01;
          io_seg = ~M_seg_seg;
          io_sel = ~M_seg_sel;
        end else begin
          M_seg_values[15+4-:5] = 5'h0f;
          M_seg_values[10+4-:5] = 5'h0f;
          M_seg_values[5+4-:5] = 5'h0f;
          M_seg_values[0+4-:5] = 5'h08;
          io_seg = ~M_seg_seg;
          io_sel = ~M_seg_sel;
        end
        if (io_dip[0+0+0-:1]) begin
          M_state_d = MANUAL_state;
        end
        M_count_d = M_count_q + 1'h1;
        if (io_button[0+0-:1] | (M_count_q[28+0-:1] ^ time_hold[28+0-:1])) begin
          M_count_d = 1'h0;
          M_state_d = CASE_CMPLE_F1_state;
        end
      end
      CASE_CMPLE_F1_state: begin
        M_alucall_alufn = 17'h1ae1f;
        M_alucall_a = 14'h2710;
        M_alucall_b = 4'hb;
        alu = M_alucall_alu;
        if (alu == 1'h0) begin
          M_seg_values[15+4-:5] = 5'h04;
          M_seg_values[10+4-:5] = 5'h0e;
          M_seg_values[5+4-:5] = 5'h0f;
          M_seg_values[0+4-:5] = 5'h08;
          io_seg = ~M_seg_seg;
          io_sel = ~M_seg_sel;
        end else begin
          M_seg_values[15+4-:5] = 5'h0f;
          M_seg_values[10+4-:5] = 5'h0f;
          M_seg_values[5+4-:5] = 5'h0f;
          M_seg_values[0+4-:5] = 5'h08;
          io_seg = ~M_seg_seg;
          io_sel = ~M_seg_sel;
        end
        if (io_dip[0+0+0-:1]) begin
          M_state_d = MANUAL_state;
        end
        M_count_d = M_count_q + 1'h1;
        if (io_button[0+0-:1] | (M_count_q[28+0-:1] ^ time_hold[28+0-:1])) begin
          M_count_d = 1'h0;
          M_state_d = CASE_CMPLE_T2_state;
        end
      end
      CASE_CMPLE_T2_state: begin
        M_alucall_alufn = 17'h1ae1f;
        M_alucall_a = 14'h2710;
        M_alucall_b = 14'h2710;
        alu = M_alucall_alu;
        if (alu == 1'h1) begin
          M_seg_values[15+4-:5] = 5'h04;
          M_seg_values[10+4-:5] = 5'h0e;
          M_seg_values[5+4-:5] = 5'h16;
          M_seg_values[0+4-:5] = 5'h01;
          io_seg = ~M_seg_seg;
          io_sel = ~M_seg_sel;
        end else begin
          M_seg_values[15+4-:5] = 5'h0f;
          M_seg_values[10+4-:5] = 5'h0f;
          M_seg_values[5+4-:5] = 5'h0f;
          M_seg_values[0+4-:5] = 5'h08;
          io_seg = ~M_seg_seg;
          io_sel = ~M_seg_sel;
        end
        if (io_dip[0+0+0-:1]) begin
          M_state_d = MANUAL_state;
        end
        M_count_d = M_count_q + 1'h1;
        if (io_button[0+0-:1] | M_count_q[28+0-:1] == 1'h1) begin
          M_count_d = 1'h0;
          M_state_d = CASE_MUL1_state;
        end
      end
      CASE_MUL1_state: begin
        M_alucall_alufn = 4'ha;
        M_alucall_a = 16'h0008;
        M_alucall_b = 16'h0003;
        alu = M_alucall_alu;
        if (alu == 14'h2af8) begin
          M_seg_values[15+4-:5] = 5'h10;
          M_seg_values[10+4-:5] = 5'h10;
          M_seg_values[5+4-:5] = 5'h03;
          M_seg_values[0+4-:5] = 5'h04;
          io_seg = ~M_seg_seg;
          io_sel = ~M_seg_sel;
        end else begin
          M_seg_values[15+4-:5] = 5'h0f;
          M_seg_values[10+4-:5] = 5'h0f;
          M_seg_values[5+4-:5] = 5'h0f;
          M_seg_values[0+4-:5] = 5'h08;
          io_seg = ~M_seg_seg;
          io_sel = ~M_seg_sel;
        end
        if (io_dip[0+0+0-:1]) begin
          M_state_d = MANUAL_state;
        end
        M_count_d = M_count_q + 1'h1;
        if (io_button[0+0-:1] | (M_count_q[28+0-:1] ^ time_hold[28+0-:1])) begin
          M_count_d = 1'h0;
          M_state_d = START_state;
        end
      end
    endcase
  end
  
  always @(posedge clk) begin
    if (rst == 1'b1) begin
      M_register_a_q <= 1'h0;
      M_register_b_q <= 1'h0;
      M_register_alufn_q <= 1'h0;
      M_count_q <= 1'h0;
      M_state_q <= 1'h0;
    end else begin
      M_register_a_q <= M_register_a_d;
      M_register_b_q <= M_register_b_d;
      M_register_alufn_q <= M_register_alufn_d;
      M_count_q <= M_count_d;
      M_state_q <= M_state_d;
    end
  end
  
endmodule