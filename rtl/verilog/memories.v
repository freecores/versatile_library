//////////////////////////////////////////////////////////////////////
////                                                              ////
////  Versatile library, memories                                 ////
////                                                              ////
////  Description                                                 ////
////  memories                                                    ////
////                                                              ////
////                                                              ////
////  To Do:                                                      ////
////   - add more memory types                                    ////
////                                                              ////
////  Author(s):                                                  ////
////      - Michael Unneback, unneback@opencores.org              ////
////        ORSoC AB                                              ////
////                                                              ////
//////////////////////////////////////////////////////////////////////
////                                                              ////
//// Copyright (C) 2010 Authors and OPENCORES.ORG                 ////
////                                                              ////
//// This source file may be used and distributed without         ////
//// restriction provided that this copyright statement is not    ////
//// removed from the file and that any derivative work contains  ////
//// the original copyright notice and the associated disclaimer. ////
////                                                              ////
//// This source file is free software; you can redistribute it   ////
//// and/or modify it under the terms of the GNU Lesser General   ////
//// Public License as published by the Free Software Foundation; ////
//// either version 2.1 of the License, or (at your option) any   ////
//// later version.                                               ////
////                                                              ////
//// This source is distributed in the hope that it will be       ////
//// useful, but WITHOUT ANY WARRANTY; without even the implied   ////
//// warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR      ////
//// PURPOSE.  See the GNU Lesser General Public License for more ////
//// details.                                                     ////
////                                                              ////
//// You should have received a copy of the GNU Lesser General    ////
//// Public License along with this source; if not, download it   ////
//// from http://www.opencores.org/lgpl.shtml                     ////
////                                                              ////
//////////////////////////////////////////////////////////////////////

/// ROM

module vl_rom_init ( adr, q, clk);
   parameter data_width = 32;
   parameter addr_width = 8;
   input [(addr_width-1):0] 	 adr;
   output reg [(data_width-1):0] q;
   input 			 clk;
   reg [data_width-1:0] rom [(1<<addr_width)-1:0];
   parameter memory_file = "vl_rom.vmem";
   initial
     begin
	$readmemh(memory_file, rom);
     end
   
   always @ (posedge clk)
     q <= rom[adr];

endmodule

/*
module vl_rom ( adr, q, clk);

parameter data_width = 32;
parameter addr_width = 4;

parameter [0:1>>addr_width-1] data [data_width-1:0] = {
    {32'h18000000},
    {32'hA8200000},
    {32'hA8200000},
    {32'hA8200000},
    {32'h44003000},
    {32'h15000000},
    {32'h15000000},
    {32'h15000000},
    {32'h15000000},
    {32'h15000000},
    {32'h15000000},
    {32'h15000000},
    {32'h15000000},
    {32'h15000000},
    {32'h15000000},
    {32'h15000000}};

input [addr_width-1:0] adr;
output reg [data_width-1:0] q;
input clk;

always @ (posedge clk)
    q <= data[adr];

endmodule
*/
// Single port RAM

module vl_ram ( d, adr, we, q, clk);
   parameter data_width = 32;
   parameter addr_width = 8;
   input [(data_width-1):0]      d;
   input [(addr_width-1):0] 	 adr;
   input 			 we;
   output reg [(data_width-1):0] q;
   input 			 clk;
   reg [data_width-1:0] ram [(1<<addr_width)-1:0];
   parameter init = 0;
   parameter memory_file = "vl_ram.vmem";
   generate if (init) begin : init_mem
   initial
     begin
	$readmemh(memory_file, ram);
     end
   end
   endgenerate 
   
   always @ (posedge clk)
   begin
   if (we)
     ram[adr] <= d;
   q <= ram[adr];
   end

endmodule

module vl_ram_be ( d, adr, be, we, q, clk);
   parameter data_width = 32;
   parameter addr_width = 8;
   input [(data_width-1):0]      d;
   input [(addr_width-1):0] 	 adr;
   input [(addr_width/4)-1:0]    be;
   input 			 we;
   output reg [(data_width-1):0] q;
   input 			 clk;

   reg [data_width-1:0] ram [(1<<addr_width)-1:0];
   
   parameter init = 0;
   parameter memory_file = "vl_ram.vmem";
   generate if (init) begin : init_mem
   initial
     begin
	$readmemh(memory_file, ram);
     end
   end
   endgenerate 

   genvar i;
   generate for (i=0;i<addr_width/4;i=i+1) begin : be_ram
      always @ (posedge clk)
      if (we & be[i])
        ram[adr][(i+1)*8-1:i*8] <= d[(i+1)*8-1:i*8];
   end
   endgenerate

   always @ (posedge clk)
      q <= ram[adr];

endmodule


// Dual port RAM

// ACTEL FPGA should not use logic to handle rw collision
`ifdef ACTEL
	`define SYN /*synthesis syn_ramstyle = "no_rw_check"*/
`else
        `define SYN 
`endif

module vl_dpram_1r1w ( d_a, adr_a, we_a, clk_a, q_b, adr_b, clk_b );
   parameter data_width = 32;
   parameter addr_width = 8;
   input [(data_width-1):0]      d_a;
   input [(addr_width-1):0] 	 adr_a;
   input [(addr_width-1):0] 	 adr_b;
   input 			 we_a;
   output [(data_width-1):0] 	 q_b;
   input 			 clk_a, clk_b;
   reg [(addr_width-1):0] 	 adr_b_reg;
   reg [data_width-1:0] ram [(1<<addr_width)-1:0] `SYN;

   parameter init = 0;
   parameter memory_file = "vl_ram.vmem";
   generate if (init) begin : init_mem
   initial
     begin
	$readmemh(memory_file, ram);
     end
   end
   endgenerate 

   always @ (posedge clk_a)
   if (we_a)
     ram[adr_a] <= d_a;
   always @ (posedge clk_b)
   adr_b_reg <= adr_b;   
   assign q_b = ram[adr_b_reg];
endmodule

module vl_dpram_2r1w ( d_a, q_a, adr_a, we_a, clk_a, q_b, adr_b, clk_b );
   parameter data_width = 32;
   parameter addr_width = 8;
   input [(data_width-1):0]      d_a;
   input [(addr_width-1):0] 	 adr_a;
   input [(addr_width-1):0] 	 adr_b;
   input 			 we_a;
   output [(data_width-1):0] 	 q_b;
   output reg [(data_width-1):0] q_a;
   input 			 clk_a, clk_b;
   reg [(data_width-1):0] 	 q_b;   
   reg [data_width-1:0] ram [(1<<addr_width)-1:0] `SYN;

   parameter init = 0;
   parameter memory_file = "vl_ram.vmem";
   generate if (init) begin : init_mem
   initial
     begin
	$readmemh(memory_file, ram);
     end
   end
   endgenerate 

   always @ (posedge clk_a)
     begin 
	q_a <= ram[adr_a];
	if (we_a)
	     ram[adr_a] <= d_a;
     end 
   always @ (posedge clk_b)
	  q_b <= ram[adr_b];
endmodule

module vl_dpram_2r2w ( d_a, q_a, adr_a, we_a, clk_a, d_b, q_b, adr_b, we_b, clk_b );
   parameter data_width = 32;
   parameter addr_width = 8;
   input [(data_width-1):0]      d_a;
   input [(addr_width-1):0] 	 adr_a;
   input [(addr_width-1):0] 	 adr_b;
   input 			 we_a;
   output [(data_width-1):0] 	 q_b;
   input [(data_width-1):0] 	 d_b;
   output reg [(data_width-1):0] q_a;
   input 			 we_b;
   input 			 clk_a, clk_b;
   reg [(data_width-1):0] 	 q_b;   
   reg [data_width-1:0] ram [(1<<addr_width)-1:0] `SYN;

   parameter init = 0;
   parameter memory_file = "vl_ram.vmem";
   generate if (init) begin : init_mem
   initial
     begin
	$readmemh(memory_file, ram);
     end
   end
   endgenerate 

   always @ (posedge clk_a)
     begin 
	q_a <= ram[adr_a];
	if (we_a)
	     ram[adr_a] <= d_a;
     end 
   always @ (posedge clk_b)
     begin 
	q_b <= ram[adr_b];
	if (we_b)
	  ram[adr_b] <= d_b;
     end
endmodule

// Content addresable memory, CAM

// FIFO
module vl_fifo_1r1w_fill_level_sync (
    d, wr, fifo_full,
    q, rd, fifo_empty,
    fill_level,
    clk, rst
    );
    
parameter data_width = 18;
parameter addr_width = 4;

// write side
input  [data_width-1:0] d;
input                   wr;
output                  fifo_full;
// read side
output [data_width-1:0] q;
input                   rd;
output                  fifo_empty;
// common
output [addr_width:0]   fill_level;
input rst, clk;

wire [addr_width:1] wadr, radr;

vl_cnt_bin_ce
    # ( .length(addr_width))
    fifo_wr_adr( .cke(wr), .q(wadr), .rst(rst), .clk(clk));
    
vl_cnt_bin_ce
    # (.length(addr_width))
    fifo_rd_adr( .cke(rd), .q(radr), .rst(rst), .clk(clk));

vl_dpram_1r1w
    # (.data_width(data_width), .addr_width(addr_width))
    dpram ( .d_a(d), .adr_a(wadr), .we_a(wr), .clk_a(clk), .q_b(q), .adr_b(radr), .clk_b(clk));

vl_cnt_bin_ce_rew_zq_l1
    # (.length(addr_width+1), .level1_value(1<<addr_width))
    fill_level_cnt( .cke(rd ^ wr), .rew(rd), .q(fill_level), .zq(fifo_empty), .level1(fifo_full), .rst(rst), .clk(clk));

endmodule

// Intended use is two small FIFOs (RX and TX typically) in one FPGA RAM resource
// RAM is supposed to be larger than the two FIFOs
// LFSR counters used adr pointers
module vl_fifo_2r2w_sync_simplex (
    // a side
    a_d, a_wr, a_fifo_full,
    a_q, a_rd, a_fifo_empty,
    a_fill_level,
    // b side
    b_d, b_wr, b_fifo_full,
    b_q, b_rd, b_fifo_empty,
    b_fill_level,
    // common
    clk, rst	
    );
parameter data_width = 8;
parameter addr_width = 5;
parameter fifo_full_level = (1<<addr_width)-1;

// a side
input  [data_width-1:0] a_d;
input                   a_wr;
output                  a_fifo_full;
output [data_width-1:0] a_q;
input                   a_rd;
output                  a_fifo_empty;
output [addr_width-1:0] a_fill_level;

// b side
input  [data_width-1:0] b_d;
input                   b_wr;
output                  b_fifo_full;
output [data_width-1:0] b_q;
input                   b_rd;
output                  b_fifo_empty;
output [addr_width-1:0] b_fill_level;

input                   clk;
input                   rst;

// adr_gen
wire [addr_width:1] a_wadr, a_radr;
wire [addr_width:1] b_wadr, b_radr;
// dpram
wire [addr_width:0] a_dpram_adr, b_dpram_adr;

vl_cnt_lfsr_ce
    # ( .length(addr_width))
    fifo_a_wr_adr( .cke(a_wr), .q(a_wadr), .rst(rst), .clk(clk));
    
vl_cnt_lfsr_ce
    # (.length(addr_width))
    fifo_a_rd_adr( .cke(a_rd), .q(a_radr), .rst(rst), .clk(clk));

vl_cnt_lfsr_ce
    # ( .length(addr_width))
    fifo_b_wr_adr( .cke(b_wr), .q(b_wadr), .rst(rst), .clk(clk));
    
vl_cnt_lfsr_ce
    # (.length(addr_width))
    fifo_b_rd_adr( .cke(b_rd), .q(b_radr), .rst(rst), .clk(clk));

// mux read or write adr to DPRAM
assign a_dpram_adr = (a_wr) ? {1'b0,a_wadr} : {1'b1,a_radr};
assign b_dpram_adr = (b_wr) ? {1'b1,b_wadr} : {1'b0,b_radr};

vl_dpram_2r2w
    # (.data_width(data_width), .addr_width(addr_width+1))
    dpram ( .d_a(a_d), .q_a(a_q), .adr_a(a_dpram_adr), .we_a(a_wr), .clk_a(a_clk), 
            .d_b(b_d), .q_b(b_q), .adr_b(b_dpram_adr), .we_b(b_wr), .clk_b(b_clk));
            
vl_cnt_bin_ce_rew_zq_l1
    # (.length(addr_width+1), .level1_value(fifo_full_level))
    a_fill_level_cnt( .cke(a_rd ^ a_wr), .rew(a_rd), .q(a_fill_level), .zq(a_fifo_empty), .level1(a_fifo_full), .rst(rst), .clk(clk));

vl_cnt_bin_ce_rew_zq_l1
    # (.length(addr_width+1), .level1_value(fifo_full_level))
    b_fill_level_cnt( .cke(b_rd ^ b_wr), .rew(b_rd), .q(b_fill_level), .zq(b_fifo_empty), .level1(b_fifo_full), .rst(rst), .clk(clk));

endmodule

module vl_fifo_cmp_async ( wptr, rptr, fifo_empty, fifo_full, wclk, rclk, rst );

   parameter addr_width = 4;   
   parameter N = addr_width-1;

   parameter Q1 = 2'b00;
   parameter Q2 = 2'b01;
   parameter Q3 = 2'b11;
   parameter Q4 = 2'b10;

   parameter going_empty = 1'b0;
   parameter going_full  = 1'b1;
   
   input [N:0]  wptr, rptr;   
   output 	fifo_empty;
   output       fifo_full;
   input 	wclk, rclk, rst;   

`ifndef GENERATE_DIRECTION_AS_LATCH   
   wire direction;
`endif
`ifdef GENERATE_DIRECTION_AS_LATCH
   reg direction;
`endif
   reg 	direction_set, direction_clr;
   
   wire async_empty, async_full;
   wire fifo_full2;
   wire fifo_empty2;   
   
   // direction_set
   always @ (wptr[N:N-1] or rptr[N:N-1])
     case ({wptr[N:N-1],rptr[N:N-1]})
       {Q1,Q2} : direction_set <= 1'b1;
       {Q2,Q3} : direction_set <= 1'b1;
       {Q3,Q4} : direction_set <= 1'b1;
       {Q4,Q1} : direction_set <= 1'b1;
       default : direction_set <= 1'b0;
     endcase

   // direction_clear
   always @ (wptr[N:N-1] or rptr[N:N-1] or rst)
     if (rst)
       direction_clr <= 1'b1;
     else
       case ({wptr[N:N-1],rptr[N:N-1]})
	 {Q2,Q1} : direction_clr <= 1'b1;
	 {Q3,Q2} : direction_clr <= 1'b1;
	 {Q4,Q3} : direction_clr <= 1'b1;
	 {Q1,Q4} : direction_clr <= 1'b1;
	 default : direction_clr <= 1'b0;
       endcase

`ifndef GENERATE_DIRECTION_AS_LATCH
    vl_dff_sr dff_sr_dir( .aclr(direction_clr), .aset(direction_set), .clock(1'b1), .data(1'b1), .q(direction));
`endif

`ifdef GENERATE_DIRECTION_AS_LATCH
   always @ (posedge direction_set or posedge direction_clr)
     if (direction_clr)
       direction <= going_empty;
     else
       direction <= going_full;
`endif

   assign async_empty = (wptr == rptr) && (direction==going_empty);
   assign async_full  = (wptr == rptr) && (direction==going_full);

    vl_dff_sr dff_sr_empty0( .aclr(rst), .aset(async_full), .clock(wclk), .data(async_full), .q(fifo_full2));
    vl_dff_sr dff_sr_empty1( .aclr(rst), .aset(async_full), .clock(wclk), .data(fifo_full2), .q(fifo_full));

/*
   always @ (posedge wclk or posedge rst or posedge async_full)
     if (rst)
       {fifo_full, fifo_full2} <= 2'b00;
     else if (async_full)
       {fifo_full, fifo_full2} <= 2'b11;
     else
       {fifo_full, fifo_full2} <= {fifo_full2, async_full};
*/
/*   always @ (posedge rclk or posedge async_empty)
     if (async_empty)
       {fifo_empty, fifo_empty2} <= 2'b11;
     else
       {fifo_empty,fifo_empty2} <= {fifo_empty2,async_empty}; */
    vl_dff # ( .reset_value(1'b1)) dff0 ( .d(async_empty), .q(fifo_empty2), .clk(rclk), .rst(async_empty));
    vl_dff # ( .reset_value(1'b1)) dff1 ( .d(fifo_empty2), .q(fifo_empty),  .clk(rclk), .rst(async_empty));

endmodule // async_compb

module vl_fifo_1r1w_async (
    d, wr, fifo_full, wr_clk, wr_rst,
    q, rd, fifo_empty, rd_clk, rd_rst
    );
    
parameter data_width = 18;
parameter addr_width = 4;

// write side
input  [data_width-1:0] d;
input                   wr;
output                  fifo_full;
input                   wr_clk;
input                   wr_rst;
// read side
output [data_width-1:0] q;
input                   rd;
output                  fifo_empty;
input                   rd_clk;
input                   rd_rst;

wire [addr_width:1] wadr, wadr_bin, radr, radr_bin;

vl_cnt_gray_ce_bin
    # ( .length(addr_width))
    fifo_wr_adr( .cke(wr), .q(wadr), .q_bin(wadr_bin), .rst(wr_rst), .clk(wr_clk));
    
vl_cnt_gray_ce_bin
    # (.length(addr_width))
    fifo_rd_adr( .cke(rd), .q(radr), .q_bin(radr_bin), .rst(rd_rst), .clk(rd_clk));

vl_dpram_1r1w
    # (.data_width(data_width), .addr_width(addr_width))
    dpram ( .d_a(d), .adr_a(wadr_bin), .we_a(wr), .clk_a(wr_clk), .q_b(q), .adr_b(radr_bin), .clk_b(rd_clk));

vl_fifo_cmp_async
    # (.addr_width(addr_width))
    cmp ( .wptr(wadr), .rptr(radr), .fifo_empty(fifo_empty), .fifo_full(fifo_full), .wclk(wr_clk), .rclk(rd_clk), .rst(wr_rst) );

endmodule

module vl_fifo_2r2w_async (
    // a side
    a_d, a_wr, a_fifo_full,
    a_q, a_rd, a_fifo_empty, 
    a_clk, a_rst,
    // b side
    b_d, b_wr, b_fifo_full,
    b_q, b_rd, b_fifo_empty, 
    b_clk, b_rst	
    );
    
parameter data_width = 18;
parameter addr_width = 4;

// a side
input  [data_width-1:0] a_d;
input                   a_wr;
output                  a_fifo_full;
output [data_width-1:0] a_q;
input                   a_rd;
output                  a_fifo_empty;
input                   a_clk;
input                   a_rst;

// b side
input  [data_width-1:0] b_d;
input                   b_wr;
output                  b_fifo_full;
output [data_width-1:0] b_q;
input                   b_rd;
output                  b_fifo_empty;
input                   b_clk;
input                   b_rst;

vl_fifo_1r1w_async # (.data_width(data_width), .addr_width(addr_width))
vl_fifo_1r1w_async_a (
    .d(a_d), .wr(a_wr), .fifo_full(a_fifo_full), .wr_clk(a_clk), .wr_rst(a_rst),
    .q(b_q), .rd(b_rd), .fifo_empty(b_fifo_empty), .rd_clk(b_clk), .rd_rst(b_rst)
    );

vl_fifo_1r1w_async # (.data_width(data_width), .addr_width(addr_width))
vl_fifo_1r1w_async_b (
    .d(b_d), .wr(b_wr), .fifo_full(b_fifo_full), .wr_clk(b_clk), .wr_rst(b_rst),
    .q(a_q), .rd(a_rd), .fifo_empty(a_fifo_empty), .rd_clk(a_clk), .rd_rst(a_rst)
    );
    
endmodule

module vl_fifo_2r2w_async_simplex (
    // a side
    a_d, a_wr, a_fifo_full,
    a_q, a_rd, a_fifo_empty, 
    a_clk, a_rst,
    // b side
    b_d, b_wr, b_fifo_full,
    b_q, b_rd, b_fifo_empty, 
    b_clk, b_rst	
    );
    
parameter data_width = 18;
parameter addr_width = 4;

// a side
input  [data_width-1:0] a_d;
input                   a_wr;
output                  a_fifo_full;
output [data_width-1:0] a_q;
input                   a_rd;
output                  a_fifo_empty;
input                   a_clk;
input                   a_rst;

// b side
input  [data_width-1:0] b_d;
input                   b_wr;
output                  b_fifo_full;
output [data_width-1:0] b_q;
input                   b_rd;
output                  b_fifo_empty;
input                   b_clk;
input                   b_rst;

// adr_gen
wire [addr_width:1] a_wadr, a_wadr_bin, a_radr, a_radr_bin;
wire [addr_width:1] b_wadr, b_wadr_bin, b_radr, b_radr_bin;
// dpram
wire [addr_width:0] a_dpram_adr, b_dpram_adr;

vl_cnt_gray_ce_bin
    # ( .length(addr_width))
    fifo_a_wr_adr( .cke(a_wr), .q(a_wadr), .q_bin(a_wadr_bin), .rst(a_rst), .clk(a_clk));
    
vl_cnt_gray_ce_bin
    # (.length(addr_width))
    fifo_a_rd_adr( .cke(a_rd), .q(a_radr), .q_bin(a_radr_bin), .rst(a_rst), .clk(a_clk));

vl_cnt_gray_ce_bin
    # ( .length(addr_width))
    fifo_b_wr_adr( .cke(b_wr), .q(b_wadr), .q_bin(b_wadr_bin), .rst(b_rst), .clk(b_clk));
    
vl_cnt_gray_ce_bin
    # (.length(addr_width))
    fifo_b_rd_adr( .cke(b_rd), .q(b_radr), .q_bin(b_radr_bin), .rst(b_rst), .clk(b_clk));

// mux read or write adr to DPRAM
assign a_dpram_adr = (a_wr) ? {1'b0,a_wadr_bin} : {1'b1,a_radr_bin};
assign b_dpram_adr = (b_wr) ? {1'b1,b_wadr_bin} : {1'b0,b_radr_bin};

vl_dpram_2r2w
    # (.data_width(data_width), .addr_width(addr_width+1))
    dpram ( .d_a(a_d), .q_a(a_q), .adr_a(a_dpram_adr), .we_a(a_wr), .clk_a(a_clk), 
            .d_b(b_d), .q_b(b_q), .adr_b(b_dpram_adr), .we_b(b_wr), .clk_b(b_clk));

vl_fifo_cmp_async
    # (.addr_width(addr_width))
    cmp1 ( .wptr(a_wadr), .rptr(b_radr), .fifo_empty(b_fifo_empty), .fifo_full(a_fifo_full), .wclk(a_clk), .rclk(b_clk), .rst(a_rst) );

vl_fifo_cmp_async
    # (.addr_width(addr_width))
    cmp2 ( .wptr(b_wadr), .rptr(a_radr), .fifo_empty(a_fifo_empty), .fifo_full(b_fifo_full), .wclk(b_clk), .rclk(a_clk), .rst(b_rst) );

endmodule
