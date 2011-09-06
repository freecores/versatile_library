//////////////////////////////////////////////////////////////////////
////                                                              ////
////  Versatile library, wishbone stuff                           ////
////                                                              ////
////  Description                                                 ////
////  Wishbone compliant modules                                  ////
////                                                              ////
////                                                              ////
////  To Do:                                                      ////
////   -                                                          ////
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

`ifdef WB_ADR_INC
`timescale 1ns/1ns
`define MODULE wb_adr_inc
module `BASE`MODULE ( cyc_i, stb_i, cti_i, bte_i, adr_i, we_i, ack_o, adr_o, clk, rst);
`undef MODULE
parameter adr_width = 10;
parameter max_burst_width = 4;
input cyc_i, stb_i, we_i;
input [2:0] cti_i;
input [1:0] bte_i;
input [adr_width-1:0] adr_i;
output [adr_width-1:0] adr_o;
output ack_o;
input clk, rst;

reg [adr_width-1:0] adr;
wire [max_burst_width-1:0] to_adr;
reg [max_burst_width-1:0] last_adr;
reg last_cycle;
localparam idle_or_eoc = 1'b0;
localparam cyc_or_ws   = 1'b1;

always @ (posedge clk or posedge rst)
if (rst)
    last_adr <= {max_burst_width{1'b0}};
else
    if (stb_i)
        last_adr <=adr_o[max_burst_width-1:0];

generate
if (max_burst_width==0) begin : inst_0   

        reg ack_o;
        assign adr_o = adr_i;
        always @ (posedge clk or posedge rst)
        if (rst)
            ack_o <= 1'b0;
        else
            ack_o <= cyc_i & stb_i & !ack_o;

end else begin

    always @ (posedge clk or posedge rst)
    if (rst)
        last_cycle <= idle_or_eoc;
    else
        last_cycle <= (!cyc_i) ? idle_or_eoc : //idle
                      (cyc_i & ack_o & (cti_i==3'b000 | cti_i==3'b111)) ? idle_or_eoc : // eoc
                      (cyc_i & !stb_i) ? cyc_or_ws : //ws
                      cyc_or_ws; // cyc
    assign to_adr = (last_cycle==idle_or_eoc) ? adr_i[max_burst_width-1:0] : adr[max_burst_width-1:0];
    assign adr_o[max_burst_width-1:0] = (we_i) ? adr_i[max_burst_width-1:0] :
                                        (!stb_i) ? last_adr :
                                        (last_cycle==idle_or_eoc) ? adr_i[max_burst_width-1:0] :
                                        adr[max_burst_width-1:0];
    assign ack_o = (last_cycle==cyc_or_ws) & stb_i;

end
endgenerate

generate
if (max_burst_width==2) begin : inst_2
    always @ (posedge clk or posedge rst)
    if (rst)
        adr <= 2'h0;
    else
        if (cyc_i & stb_i)
            adr[1:0] <= to_adr[1:0] + 2'd1;
        else
            adr <= to_adr[1:0];
end
endgenerate

generate
if (max_burst_width==3) begin : inst_3    
    always @ (posedge clk or posedge rst)
    if (rst)
        adr <= 3'h0;
    else
        if (cyc_i & stb_i)
            case (bte_i)
            2'b01: adr[2:0] <= {to_adr[2],to_adr[1:0] + 2'd1};
            default: adr[3:0] <= to_adr[2:0] + 3'd1;
            endcase
        else
            adr <= to_adr[2:0];
end
endgenerate

generate
if (max_burst_width==4) begin : inst_4    
    always @ (posedge clk or posedge rst)
    if (rst)
        adr <= 4'h0;
    else
        if (stb_i) // | (!stb_i & last_cycle!=ws)) // for !stb_i restart with adr_i +1, only inc once
            case (bte_i)
            2'b01: adr[3:0] <= {to_adr[3:2],to_adr[1:0] + 2'd1};
            2'b10: adr[3:0] <= {to_adr[3],to_adr[2:0] + 3'd1};
            default: adr[3:0] <= to_adr + 4'd1;
            endcase
        else
            adr <= to_adr[3:0];
end
endgenerate

generate
if (adr_width > max_burst_width) begin : pass_through
    assign adr_o[adr_width-1:max_burst_width] = adr_i[adr_width-1:max_burst_width];
end
endgenerate

endmodule
`endif

`ifdef WB3WB3_BRIDGE
// async wb3 - wb3 bridge
`timescale 1ns/1ns
`define MODULE wb3wb3_bridge
module `BASE`MODULE ( 
`undef MODULE
	// wishbone slave side
	wbs_dat_i, wbs_adr_i, wbs_sel_i, wbs_bte_i, wbs_cti_i, wbs_we_i, wbs_cyc_i, wbs_stb_i, wbs_dat_o, wbs_ack_o, wbs_clk, wbs_rst,
	// wishbone master side
	wbm_dat_o, wbm_adr_o, wbm_sel_o, wbm_bte_o, wbm_cti_o, wbm_we_o, wbm_cyc_o, wbm_stb_o, wbm_dat_i, wbm_ack_i, wbm_clk, wbm_rst);

parameter style = "FIFO"; // valid: simple, FIFO
parameter addr_width = 4;

input [31:0] wbs_dat_i;
input [31:2] wbs_adr_i;
input [3:0]  wbs_sel_i;
input [1:0]  wbs_bte_i;
input [2:0]  wbs_cti_i;
input wbs_we_i, wbs_cyc_i, wbs_stb_i;
output [31:0] wbs_dat_o;
output wbs_ack_o;
input wbs_clk, wbs_rst;

output [31:0] wbm_dat_o;
output reg [31:2] wbm_adr_o;
output [3:0]  wbm_sel_o;
output reg [1:0]  wbm_bte_o;
output reg [2:0]  wbm_cti_o;
output reg wbm_we_o;
output wbm_cyc_o;
output wbm_stb_o;
input [31:0]  wbm_dat_i;
input wbm_ack_i;
input wbm_clk, wbm_rst;

// bte
parameter linear       = 2'b00;
parameter wrap4        = 2'b01;
parameter wrap8        = 2'b10;
parameter wrap16       = 2'b11;
// cti
parameter classic      = 3'b000;
parameter incburst     = 3'b010;
parameter endofburst   = 3'b111;

localparam wbs_adr  = 1'b0;
localparam wbs_data = 1'b1;

localparam wbm_adr0      = 2'b00;
localparam wbm_adr1      = 2'b01;
localparam wbm_data      = 2'b10;
localparam wbm_data_wait = 2'b11;

reg [1:0] wbs_bte_reg;
reg wbs;
wire wbs_eoc_alert, wbm_eoc_alert;
reg wbs_eoc, wbm_eoc;
reg [1:0] wbm;

wire [1:16] wbs_count, wbm_count;

wire [35:0] a_d, a_q, b_d, b_q;
wire a_wr, a_rd, a_fifo_full, a_fifo_empty, b_wr, b_rd, b_fifo_full, b_fifo_empty;
reg a_rd_reg;
wire b_rd_adr, b_rd_data;
wire b_rd_data_reg;
wire [35:0] temp;

`define WE 5
`define BTE 4:3
`define CTI 2:0  

assign wbs_eoc_alert = (wbs_bte_reg==wrap4 & wbs_count[3]) | (wbs_bte_reg==wrap8 & wbs_count[7]) | (wbs_bte_reg==wrap16 & wbs_count[15]);
always @ (posedge wbs_clk or posedge wbs_rst)
if (wbs_rst)
	wbs_eoc <= 1'b0;
else
	if (wbs==wbs_adr & wbs_stb_i & !a_fifo_full)
		wbs_eoc <= (wbs_bte_i==linear) | (wbs_cti_i==3'b111);
	else if (wbs_eoc_alert & (a_rd | a_wr))
		wbs_eoc <= 1'b1;

`define MODULE cnt_shreg_ce_clear
`BASE`MODULE # ( .length(16))
`undef MODULE
    cnt0 (
        .cke(wbs_ack_o),
        .clear(wbs_eoc),
        .q(wbs_count),
        .rst(wbs_rst),
        .clk(wbs_clk));

always @ (posedge wbs_clk or posedge wbs_rst)
if (wbs_rst)
	wbs <= wbs_adr;
else
	if ((wbs==wbs_adr) & wbs_cyc_i & wbs_stb_i & a_fifo_empty)
		wbs <= wbs_data;
	else if (wbs_eoc & wbs_ack_o)
		wbs <= wbs_adr;

// wbs FIFO
assign a_d = (wbs==wbs_adr) ? {wbs_adr_i[31:2],wbs_we_i,((wbs_cti_i==3'b111) ? {2'b00,3'b000} : {wbs_bte_i,wbs_cti_i})} : {wbs_dat_i,wbs_sel_i};
assign a_wr = (wbs==wbs_adr)  ? wbs_cyc_i & wbs_stb_i & a_fifo_empty :
              (wbs==wbs_data) ? wbs_we_i  & wbs_stb_i & !a_fifo_full :
              1'b0;
assign a_rd = !a_fifo_empty;
always @ (posedge wbs_clk or posedge wbs_rst)
if (wbs_rst)
	a_rd_reg <= 1'b0;
else
	a_rd_reg <= a_rd;
assign wbs_ack_o = a_rd_reg | (a_wr & wbs==wbs_data);

assign wbs_dat_o = a_q[35:4];
	
always @ (posedge wbs_clk or posedge wbs_rst)
if (wbs_rst)
	wbs_bte_reg <= 2'b00;
else
	wbs_bte_reg <= wbs_bte_i;

// wbm FIFO
assign wbm_eoc_alert = (wbm_bte_o==wrap4 & wbm_count[3]) | (wbm_bte_o==wrap8 & wbm_count[7]) | (wbm_bte_o==wrap16 & wbm_count[15]);
always @ (posedge wbm_clk or posedge wbm_rst)
if (wbm_rst)
	wbm_eoc <= 1'b0;
else
	if (wbm==wbm_adr0 & !b_fifo_empty)
		wbm_eoc <= b_q[`BTE] == linear;
	else if (wbm_eoc_alert & wbm_ack_i)
		wbm_eoc <= 1'b1;
	
always @ (posedge wbm_clk or posedge wbm_rst)
if (wbm_rst)
	wbm <= wbm_adr0;
else
/*
    if ((wbm==wbm_adr0 & !b_fifo_empty) |
        (wbm==wbm_adr1 & !b_fifo_empty & wbm_we_o) |
        (wbm==wbm_adr1 & !wbm_we_o) |
        (wbm==wbm_data & wbm_ack_i & wbm_eoc))
        wbm <= {wbm[0],!(wbm[1] ^ wbm[0])};  // count sequence 00,01,10
*/
    case (wbm)
    wbm_adr0:
        if (!b_fifo_empty)
            wbm <= wbm_adr1;
    wbm_adr1:
        if (!wbm_we_o | (!b_fifo_empty & wbm_we_o))
            wbm <= wbm_data;
    wbm_data:
        if (wbm_ack_i & wbm_eoc)
            wbm <= wbm_adr0;
        else if (b_fifo_empty & wbm_we_o & wbm_ack_i)
            wbm <= wbm_data_wait;
    wbm_data_wait:
        if (!b_fifo_empty)
            wbm <= wbm_data;
    endcase

assign b_d = {wbm_dat_i,4'b1111};
assign b_wr = !wbm_we_o & wbm_ack_i;
assign b_rd_adr  = (wbm==wbm_adr0 & !b_fifo_empty);
assign b_rd_data = (wbm==wbm_adr1 & !b_fifo_empty & wbm_we_o) ? 1'b1 : // b_q[`WE]
                   (wbm==wbm_data & !b_fifo_empty & wbm_we_o & wbm_ack_i & !wbm_eoc) ? 1'b1 :
                   (wbm==wbm_data_wait & !b_fifo_empty) ? 1'b1 : 
                   1'b0;
assign b_rd = b_rd_adr | b_rd_data;

`define MODULE dff
`BASE`MODULE dff1 ( .d(b_rd_data), .q(b_rd_data_reg), .clk(wbm_clk), .rst(wbm_rst));
`undef MODULE
`define MODULE dff_ce
`BASE`MODULE # ( .width(36)) dff2 ( .d(b_q), .ce(b_rd_data_reg), .q(temp), .clk(wbm_clk), .rst(wbm_rst));
`undef MODULE

assign {wbm_dat_o,wbm_sel_o} = (b_rd_data_reg) ? b_q : temp;

`define MODULE cnt_shreg_ce_clear
`BASE`MODULE # ( .length(16))
`undef MODULE
    cnt1 (
        .cke(wbm_ack_i),
        .clear(wbm_eoc),
        .q(wbm_count),
        .rst(wbm_rst),
        .clk(wbm_clk));

assign wbm_cyc_o = (wbm==wbm_data | wbm==wbm_data_wait);
assign wbm_stb_o = (wbm==wbm_data);

always @ (posedge wbm_clk or posedge wbm_rst)
if (wbm_rst)
	{wbm_adr_o,wbm_we_o,wbm_bte_o,wbm_cti_o} <= {30'h0,1'b0,linear,classic};
else begin
	if (wbm==wbm_adr0 & !b_fifo_empty)
		{wbm_adr_o,wbm_we_o,wbm_bte_o,wbm_cti_o} <= b_q;
	else if (wbm_eoc_alert & wbm_ack_i)
		wbm_cti_o <= endofburst;
end	

//async_fifo_dw_simplex_top
`define MODULE fifo_2r2w_async_simplex
`BASE`MODULE
`undef MODULE
# ( .data_width(36), .addr_width(addr_width))
fifo (
    // a side
    .a_d(a_d), 
    .a_wr(a_wr), 
    .a_fifo_full(a_fifo_full),
    .a_q(a_q),
    .a_rd(a_rd),
    .a_fifo_empty(a_fifo_empty), 
    .a_clk(wbs_clk), 
    .a_rst(wbs_rst),
    // b side
    .b_d(b_d), 
    .b_wr(b_wr), 
    .b_fifo_full(b_fifo_full),
    .b_q(b_q), 
    .b_rd(b_rd), 
    .b_fifo_empty(b_fifo_empty), 
    .b_clk(wbm_clk), 
    .b_rst(wbm_rst)	
    );
    
endmodule
`undef WE
`undef BTE
`undef CTI
`endif

`ifdef WB3AVALON_BRIDGE
`define MODULE wb3avalon_bridge
module `BASE`MODULE ( 
`undef MODULE
	// wishbone slave side
	wbs_dat_i, wbs_adr_i, wbs_sel_i, wbs_bte_i, wbs_cti_i, wbs_we_i, wbs_cyc_i, wbs_stb_i, wbs_dat_o, wbs_ack_o, wbs_clk, wbs_rst,
	// avalon master side
	readdata, readdatavalid, address, read, be, write, burstcount, writedata, waitrequest, beginbursttransfer, clk, rst);

parameter linewrapburst = 1'b0;

input [31:0] wbs_dat_i;
input [31:2] wbs_adr_i;
input [3:0]  wbs_sel_i;
input [1:0]  wbs_bte_i;
input [2:0]  wbs_cti_i;
input wbs_we_i;
input wbs_cyc_i;
input wbs_stb_i;
output [31:0] wbs_dat_o;
output wbs_ack_o;
input wbs_clk, wbs_rst;

input [31:0] readdata;
output [31:0] writedata;
output [31:2] address;
output [3:0]  be;
output write;
output read;
output beginbursttransfer;
output [3:0] burstcount;
input readdatavalid;
input waitrequest;
input clk;
input rst;

wire [1:0] wbm_bte_o;
wire [2:0] wbm_cti_o;
wire wbm_we_o, wbm_cyc_o, wbm_stb_o, wbm_ack_i;
reg last_cyc;
reg [3:0] counter;
reg read_busy;

always @ (posedge clk or posedge rst)
if (rst)
    last_cyc <= 1'b0;
else
    last_cyc <= wbm_cyc_o;

always @ (posedge clk or posedge rst)
if (rst)
    read_busy <= 1'b0;
else
    if (read & !waitrequest)
        read_busy <= 1'b1;
    else if (wbm_ack_i & wbm_cti_o!=3'b010)
        read_busy <= 1'b0;
assign read = wbm_cyc_o & wbm_stb_o & !wbm_we_o & !read_busy;

assign beginbursttransfer = (!last_cyc & wbm_cyc_o) & wbm_cti_o==3'b010;
assign burstcount = (wbm_bte_o==2'b01) ? 4'd4 :
                    (wbm_bte_o==2'b10) ? 4'd8 :
                    (wbm_bte_o==2'b11) ? 4'd16:
                    4'd1;
assign wbm_ack_i = (readdatavalid) | (write & !waitrequest);

always @ (posedge clk or posedge rst)
if (rst) begin
    counter <= 4'd0;
end else
    if (wbm_we_o) begin
        if (!waitrequest & !last_cyc & wbm_cyc_o) begin
            counter <= burstcount -4'd1;
        end else if (waitrequest & !last_cyc & wbm_cyc_o) begin
            counter <= burstcount;
        end else if (!waitrequest & wbm_stb_o) begin
            counter <= counter - 4'd1;
        end
    end 
assign write = wbm_cyc_o & wbm_stb_o & wbm_we_o & counter!=4'd0;

`define MODULE wb3wb3_bridge
`BASE`MODULE wbwb3inst (
`undef MODULE
    // wishbone slave side
    .wbs_dat_i(wbs_dat_i),
    .wbs_adr_i(wbs_adr_i),
    .wbs_sel_i(wbs_sel_i),
    .wbs_bte_i(wbs_bte_i),
    .wbs_cti_i(wbs_cti_i),
    .wbs_we_i(wbs_we_i),
    .wbs_cyc_i(wbs_cyc_i),
    .wbs_stb_i(wbs_stb_i),
    .wbs_dat_o(wbs_dat_o),
    .wbs_ack_o(wbs_ack_o),
    .wbs_clk(wbs_clk),
    .wbs_rst(wbs_rst),
    // wishbone master side
    .wbm_dat_o(writedata),
    .wbm_adr_o(address),
    .wbm_sel_o(be),
    .wbm_bte_o(wbm_bte_o),
    .wbm_cti_o(wbm_cti_o),
    .wbm_we_o(wbm_we_o),
    .wbm_cyc_o(wbm_cyc_o),
    .wbm_stb_o(wbm_stb_o),
    .wbm_dat_i(readdata),
    .wbm_ack_i(wbm_ack_i),
    .wbm_clk(clk),
    .wbm_rst(rst));


endmodule
`endif

`ifdef WB3_ARBITER_TYPE1
`define MODULE wb3_arbiter_type1
module `BASE`MODULE (
`undef MODULE
    wbm_dat_o, wbm_adr_o, wbm_sel_o, wbm_cti_o, wbm_bte_o, wbm_we_o, wbm_stb_o, wbm_cyc_o,
    wbm_dat_i, wbm_ack_i, wbm_err_i, wbm_rty_i,
    wbs_dat_i, wbs_adr_i, wbs_sel_i, wbs_cti_i, wbs_bte_i, wbs_we_i, wbs_stb_i, wbs_cyc_i,
    wbs_dat_o, wbs_ack_o, wbs_err_o, wbs_rty_o,
    wb_clk, wb_rst
);

parameter nr_of_ports = 3;
parameter adr_size = 26;
parameter adr_lo   = 2;
parameter dat_size = 32;
parameter sel_size = dat_size/8;

localparam aw = (adr_size - adr_lo) * nr_of_ports;
localparam dw = dat_size * nr_of_ports;
localparam sw = sel_size * nr_of_ports;
localparam cw = 3 * nr_of_ports;
localparam bw = 2 * nr_of_ports;

input  [dw-1:0] wbm_dat_o;
input  [aw-1:0] wbm_adr_o;
input  [sw-1:0] wbm_sel_o;
input  [cw-1:0] wbm_cti_o;
input  [bw-1:0] wbm_bte_o;
input  [nr_of_ports-1:0] wbm_we_o, wbm_stb_o, wbm_cyc_o;
output [dw-1:0] wbm_dat_i;
output [nr_of_ports-1:0] wbm_ack_i, wbm_err_i, wbm_rty_i;

output [dat_size-1:0] wbs_dat_i;
output [adr_size-1:adr_lo] wbs_adr_i;
output [sel_size-1:0] wbs_sel_i;
output [2:0] wbs_cti_i;
output [1:0] wbs_bte_i;
output wbs_we_i, wbs_stb_i, wbs_cyc_i;
input  [dat_size-1:0] wbs_dat_o;
input  wbs_ack_o, wbs_err_o, wbs_rty_o;

input wb_clk, wb_rst;

reg  [nr_of_ports-1:0] select;
wire [nr_of_ports-1:0] state;
wire [nr_of_ports-1:0] eoc; // end-of-cycle
wire [nr_of_ports-1:0] sel;
wire idle;

genvar i;

assign idle = !(|state);

generate
if (nr_of_ports == 2) begin

    wire [2:0] wbm1_cti_o, wbm0_cti_o;

    assign {wbm1_cti_o,wbm0_cti_o} = wbm_cti_o;
    
    //assign select = (idle) ? {wbm_cyc_o[1],!wbm_cyc_o[1] & wbm_cyc_o[0]} : {nr_of_ports{1'b0}};
    
    always @ (idle or wbm_cyc_o)
    if (idle)
        casex (wbm_cyc_o)
        2'b1x : select = 2'b10;
        2'b01 : select = 2'b01;
        default : select = {nr_of_ports{1'b0}};
        endcase
    else
        select = {nr_of_ports{1'b0}};
        
    assign eoc[1] = (wbm_ack_i[1] & (wbm1_cti_o == 3'b000 | wbm1_cti_o == 3'b111)) | !wbm_cyc_o[1];
    assign eoc[0] = (wbm_ack_i[0] & (wbm0_cti_o == 3'b000 | wbm0_cti_o == 3'b111)) | !wbm_cyc_o[0];
    
end
endgenerate

generate
if (nr_of_ports == 3) begin

    wire [2:0] wbm2_cti_o, wbm1_cti_o, wbm0_cti_o;

    assign {wbm2_cti_o,wbm1_cti_o,wbm0_cti_o} = wbm_cti_o;
    
    always @ (idle or wbm_cyc_o)
    if (idle)
        casex (wbm_cyc_o)
        3'b1xx : select = 3'b100;
        3'b01x : select = 3'b010;
        3'b001 : select = 3'b001;
        default : select = {nr_of_ports{1'b0}};
        endcase
    else
        select = {nr_of_ports{1'b0}};

//    assign select = (idle) ? {wbm_cyc_o[2],!wbm_cyc_o[2] & wbm_cyc_o[1],wbm_cyc_o[2:1]==2'b00 & wbm_cyc_o[0]} : {nr_of_ports{1'b0}};
    assign eoc[2] = (wbm_ack_i[2] & (wbm2_cti_o == 3'b000 | wbm2_cti_o == 3'b111)) | !wbm_cyc_o[2];
    assign eoc[1] = (wbm_ack_i[1] & (wbm1_cti_o == 3'b000 | wbm1_cti_o == 3'b111)) | !wbm_cyc_o[1];
    assign eoc[0] = (wbm_ack_i[0] & (wbm0_cti_o == 3'b000 | wbm0_cti_o == 3'b111)) | !wbm_cyc_o[0];
    
end
endgenerate

generate
if (nr_of_ports == 4) begin

    wire [2:0] wbm3_cti_o, wbm2_cti_o, wbm1_cti_o, wbm0_cti_o;

    assign {wbm3_cti_o, wbm2_cti_o,wbm1_cti_o,wbm0_cti_o} = wbm_cti_o;
    
    //assign select = (idle) ? {wbm_cyc_o[3],!wbm_cyc_o[3] & wbm_cyc_o[2],wbm_cyc_o[3:2]==2'b00 & wbm_cyc_o[1],wbm_cyc_o[3:1]==3'b000 & wbm_cyc_o[0]} : {nr_of_ports{1'b0}};
    
    always @ (idle or wbm_cyc_o)
    if (idle)
        casex (wbm_cyc_o)
        4'b1xxx : select = 4'b1000;
        4'b01xx : select = 4'b0100;
        4'b001x : select = 4'b0010;
        4'b0001 : select = 4'b0001;
        default : select = {nr_of_ports{1'b0}};
        endcase
    else
        select = {nr_of_ports{1'b0}};
    
    assign eoc[3] = (wbm_ack_i[3] & (wbm3_cti_o == 3'b000 | wbm3_cti_o == 3'b111)) | !wbm_cyc_o[3];
    assign eoc[2] = (wbm_ack_i[2] & (wbm2_cti_o == 3'b000 | wbm2_cti_o == 3'b111)) | !wbm_cyc_o[2];
    assign eoc[1] = (wbm_ack_i[1] & (wbm1_cti_o == 3'b000 | wbm1_cti_o == 3'b111)) | !wbm_cyc_o[1];
    assign eoc[0] = (wbm_ack_i[0] & (wbm0_cti_o == 3'b000 | wbm0_cti_o == 3'b111)) | !wbm_cyc_o[0];
    
end
endgenerate

generate
if (nr_of_ports == 5) begin

    wire [2:0] wbm4_cti_o, wbm3_cti_o, wbm2_cti_o, wbm1_cti_o, wbm0_cti_o;

    assign {wbm4_cti_o, wbm3_cti_o, wbm2_cti_o,wbm1_cti_o,wbm0_cti_o} = wbm_cti_o;
    
    //assign select = (idle) ? {wbm_cyc_o[3],!wbm_cyc_o[3] & wbm_cyc_o[2],wbm_cyc_o[3:2]==2'b00 & wbm_cyc_o[1],wbm_cyc_o[3:1]==3'b000 & wbm_cyc_o[0]} : {nr_of_ports{1'b0}};
    
    always @ (idle or wbm_cyc_o)
    if (idle)
        casex (wbm_cyc_o)
        5'b1xxxx : select = 5'b10000;
        5'b01xxx : select = 5'b01000;
        5'b001xx : select = 5'b00100;
        5'b0001x : select = 5'b00010;
        5'b00001 : select = 5'b00001;
        default : select = {nr_of_ports{1'b0}};
        endcase
    else
        select = {nr_of_ports{1'b0}};
    
    assign eoc[4] = (wbm_ack_i[4] & (wbm4_cti_o == 3'b000 | wbm4_cti_o == 3'b111)) | !wbm_cyc_o[4];
    assign eoc[3] = (wbm_ack_i[3] & (wbm3_cti_o == 3'b000 | wbm3_cti_o == 3'b111)) | !wbm_cyc_o[3];
    assign eoc[2] = (wbm_ack_i[2] & (wbm2_cti_o == 3'b000 | wbm2_cti_o == 3'b111)) | !wbm_cyc_o[2];
    assign eoc[1] = (wbm_ack_i[1] & (wbm1_cti_o == 3'b000 | wbm1_cti_o == 3'b111)) | !wbm_cyc_o[1];
    assign eoc[0] = (wbm_ack_i[0] & (wbm0_cti_o == 3'b000 | wbm0_cti_o == 3'b111)) | !wbm_cyc_o[0];
    
end
endgenerate

generate
if (nr_of_ports == 6) begin

    wire [2:0] wbm5_cti_o, wbm4_cti_o, wbm3_cti_o, wbm2_cti_o, wbm1_cti_o, wbm0_cti_o;

    assign {wbm5_cti_o, wbm4_cti_o, wbm3_cti_o, wbm2_cti_o,wbm1_cti_o,wbm0_cti_o} = wbm_cti_o;
    
    //assign select = (idle) ? {wbm_cyc_o[3],!wbm_cyc_o[3] & wbm_cyc_o[2],wbm_cyc_o[3:2]==2'b00 & wbm_cyc_o[1],wbm_cyc_o[3:1]==3'b000 & wbm_cyc_o[0]} : {nr_of_ports{1'b0}};
    
    always @ (idle or wbm_cyc_o)
    if (idle)
        casex (wbm_cyc_o)
        6'b1xxxxx : select = 6'b100000;
        6'b01xxxx : select = 6'b010000;
        6'b001xxx : select = 6'b001000;
        6'b0001xx : select = 6'b000100;
        6'b00001x : select = 6'b000010;
        6'b000001 : select = 6'b000001;
        default : select = {nr_of_ports{1'b0}};
        endcase
    else
        select = {nr_of_ports{1'b0}};
    
    assign eoc[5] = (wbm_ack_i[5] & (wbm5_cti_o == 3'b000 | wbm5_cti_o == 3'b111)) | !wbm_cyc_o[5];
    assign eoc[4] = (wbm_ack_i[4] & (wbm4_cti_o == 3'b000 | wbm4_cti_o == 3'b111)) | !wbm_cyc_o[4];
    assign eoc[3] = (wbm_ack_i[3] & (wbm3_cti_o == 3'b000 | wbm3_cti_o == 3'b111)) | !wbm_cyc_o[3];
    assign eoc[2] = (wbm_ack_i[2] & (wbm2_cti_o == 3'b000 | wbm2_cti_o == 3'b111)) | !wbm_cyc_o[2];
    assign eoc[1] = (wbm_ack_i[1] & (wbm1_cti_o == 3'b000 | wbm1_cti_o == 3'b111)) | !wbm_cyc_o[1];
    assign eoc[0] = (wbm_ack_i[0] & (wbm0_cti_o == 3'b000 | wbm0_cti_o == 3'b111)) | !wbm_cyc_o[0];
    
end
endgenerate

generate
if (nr_of_ports == 7) begin

    wire [2:0] wbm6_cti_o, wbm5_cti_o, wbm4_cti_o, wbm3_cti_o, wbm2_cti_o, wbm1_cti_o, wbm0_cti_o;

    assign {wbm6_cti_o, wbm5_cti_o, wbm4_cti_o, wbm3_cti_o, wbm2_cti_o,wbm1_cti_o,wbm0_cti_o} = wbm_cti_o;
    
    //assign select = (idle) ? {wbm_cyc_o[3],!wbm_cyc_o[3] & wbm_cyc_o[2],wbm_cyc_o[3:2]==2'b00 & wbm_cyc_o[1],wbm_cyc_o[3:1]==3'b000 & wbm_cyc_o[0]} : {nr_of_ports{1'b0}};
    
    always @ (idle or wbm_cyc_o)
    if (idle)
        casex (wbm_cyc_o)
        7'b1xxxxxx : select = 7'b1000000;
        7'b01xxxxx : select = 7'b0100000;
        7'b001xxxx : select = 7'b0010000;
        7'b0001xxx : select = 7'b0001000;
        7'b00001xx : select = 7'b0000100;
        7'b000001x : select = 7'b0000010;
        7'b0000001 : select = 7'b0000001;
        default : select = {nr_of_ports{1'b0}};
        endcase
    else
        select = {nr_of_ports{1'b0}};
    
    assign eoc[6] = (wbm_ack_i[6] & (wbm6_cti_o == 3'b000 | wbm6_cti_o == 3'b111)) | !wbm_cyc_o[6];
    assign eoc[5] = (wbm_ack_i[5] & (wbm5_cti_o == 3'b000 | wbm5_cti_o == 3'b111)) | !wbm_cyc_o[5];
    assign eoc[4] = (wbm_ack_i[4] & (wbm4_cti_o == 3'b000 | wbm4_cti_o == 3'b111)) | !wbm_cyc_o[4];
    assign eoc[3] = (wbm_ack_i[3] & (wbm3_cti_o == 3'b000 | wbm3_cti_o == 3'b111)) | !wbm_cyc_o[3];
    assign eoc[2] = (wbm_ack_i[2] & (wbm2_cti_o == 3'b000 | wbm2_cti_o == 3'b111)) | !wbm_cyc_o[2];
    assign eoc[1] = (wbm_ack_i[1] & (wbm1_cti_o == 3'b000 | wbm1_cti_o == 3'b111)) | !wbm_cyc_o[1];
    assign eoc[0] = (wbm_ack_i[0] & (wbm0_cti_o == 3'b000 | wbm0_cti_o == 3'b111)) | !wbm_cyc_o[0];
    
end
endgenerate

generate
if (nr_of_ports == 8) begin

    wire [2:0] wbm7_cti_o, wbm6_cti_o, wbm5_cti_o, wbm4_cti_o, wbm3_cti_o, wbm2_cti_o, wbm1_cti_o, wbm0_cti_o;

    assign {wbm7_cti_o, wbm6_cti_o, wbm5_cti_o, wbm4_cti_o, wbm3_cti_o, wbm2_cti_o,wbm1_cti_o,wbm0_cti_o} = wbm_cti_o;
    
    //assign select = (idle) ? {wbm_cyc_o[3],!wbm_cyc_o[3] & wbm_cyc_o[2],wbm_cyc_o[3:2]==2'b00 & wbm_cyc_o[1],wbm_cyc_o[3:1]==3'b000 & wbm_cyc_o[0]} : {nr_of_ports{1'b0}};
    
    always @ (idle or wbm_cyc_o)
    if (idle)
        casex (wbm_cyc_o)
        8'b1xxxxxxx : select = 8'b10000000;
        8'b01xxxxxx : select = 8'b01000000;
        8'b001xxxxx : select = 8'b00100000;
        8'b0001xxxx : select = 8'b00010000;
        8'b00001xxx : select = 8'b00001000;
        8'b000001xx : select = 8'b00000100;
        8'b0000001x : select = 8'b00000010;
        8'b00000001 : select = 8'b00000001;
        default : select = {nr_of_ports{1'b0}};
        endcase
    else
        select = {nr_of_ports{1'b0}};
    
    assign eoc[7] = (wbm_ack_i[7] & (wbm7_cti_o == 3'b000 | wbm7_cti_o == 3'b111)) | !wbm_cyc_o[7];
    assign eoc[6] = (wbm_ack_i[6] & (wbm6_cti_o == 3'b000 | wbm6_cti_o == 3'b111)) | !wbm_cyc_o[6];
    assign eoc[5] = (wbm_ack_i[5] & (wbm5_cti_o == 3'b000 | wbm5_cti_o == 3'b111)) | !wbm_cyc_o[5];
    assign eoc[4] = (wbm_ack_i[4] & (wbm4_cti_o == 3'b000 | wbm4_cti_o == 3'b111)) | !wbm_cyc_o[4];
    assign eoc[3] = (wbm_ack_i[3] & (wbm3_cti_o == 3'b000 | wbm3_cti_o == 3'b111)) | !wbm_cyc_o[3];
    assign eoc[2] = (wbm_ack_i[2] & (wbm2_cti_o == 3'b000 | wbm2_cti_o == 3'b111)) | !wbm_cyc_o[2];
    assign eoc[1] = (wbm_ack_i[1] & (wbm1_cti_o == 3'b000 | wbm1_cti_o == 3'b111)) | !wbm_cyc_o[1];
    assign eoc[0] = (wbm_ack_i[0] & (wbm0_cti_o == 3'b000 | wbm0_cti_o == 3'b111)) | !wbm_cyc_o[0];
    
end
endgenerate

generate
for (i=0;i<nr_of_ports;i=i+1) begin : spr0
`define MODULE spr
    `BASE`MODULE sr0( .sp(select[i]), .r(eoc[i]), .q(state[i]), .clk(wb_clk), .rst(wb_rst));
`undef MODULE
end
endgenerate

    assign sel = select | state;

`define MODULE mux_andor
    `BASE`MODULE # ( .nr_of_ports(nr_of_ports), .width(32)) mux0 ( .a(wbm_dat_o), .sel(sel), .dout(wbs_dat_i));
    `BASE`MODULE # ( .nr_of_ports(nr_of_ports), .width(adr_size-adr_lo)) mux1 ( .a(wbm_adr_o), .sel(sel), .dout(wbs_adr_i));
    `BASE`MODULE # ( .nr_of_ports(nr_of_ports), .width(sel_size)) mux2 ( .a(wbm_sel_o), .sel(sel), .dout(wbs_sel_i));
    `BASE`MODULE # ( .nr_of_ports(nr_of_ports), .width(3)) mux3 ( .a(wbm_cti_o), .sel(sel), .dout(wbs_cti_i));
    `BASE`MODULE # ( .nr_of_ports(nr_of_ports), .width(2)) mux4 ( .a(wbm_bte_o), .sel(sel), .dout(wbs_bte_i));
    `BASE`MODULE # ( .nr_of_ports(nr_of_ports), .width(1)) mux5 ( .a(wbm_we_o), .sel(sel), .dout(wbs_we_i));
    `BASE`MODULE # ( .nr_of_ports(nr_of_ports), .width(1)) mux6 ( .a(wbm_stb_o), .sel(sel), .dout(wbs_stb_i));
`undef MODULE
    assign wbs_cyc_i = |sel;
    
    assign wbm_dat_i = {nr_of_ports{wbs_dat_o}};
    assign wbm_ack_i = {nr_of_ports{wbs_ack_o}} & sel;
    assign wbm_err_i = {nr_of_ports{wbs_err_o}} & sel;
    assign wbm_rty_i = {nr_of_ports{wbs_rty_o}} & sel;

endmodule
`endif

`ifdef WB_RAM
// WB RAM with byte enable
`define MODULE wb_ram
module `BASE`MODULE (
`undef MODULE
    wbs_dat_i, wbs_adr_i, wbs_cti_i, wbs_bte_i, wbs_sel_i, wbs_we_i, wbs_stb_i, wbs_cyc_i, 
    wbs_dat_o, wbs_ack_o, wbs_stall_o, wb_clk, wb_rst);

parameter adr_width = 16;
parameter mem_size = 1<<adr_width;
parameter dat_width = 32;
parameter max_burst_width = 4; // only used for B3
parameter mode = "B3"; // valid options: B3, B4
parameter memory_init = 1;
parameter memory_file = "vl_ram.vmem";

input [dat_width-1:0] wbs_dat_i;
input [adr_width-1:0] wbs_adr_i;
input [2:0] wbs_cti_i;
input [1:0] wbs_bte_i;
input [dat_width/8-1:0] wbs_sel_i;
input wbs_we_i, wbs_stb_i, wbs_cyc_i;
output [dat_width-1:0] wbs_dat_o;
output wbs_ack_o;
output wbs_stall_o;
input wb_clk, wb_rst;

wire [adr_width-1:0] adr;
wire we;

generate
if (mode=="B3") begin : B3_inst
`define MODULE wb_adr_inc 
`BASE`MODULE # ( .adr_width(adr_width), .max_burst_width(max_burst_width)) adr_inc0 (
    .cyc_i(wbs_cyc_i),
    .stb_i(wbs_stb_i),
    .cti_i(wbs_cti_i),
    .bte_i(wbs_bte_i),
    .adr_i(wbs_adr_i),
    .we_i(wbs_we_i),
    .ack_o(wbs_ack_o),
    .adr_o(adr),
    .clk(wb_clk),
    .rst(wb_rst));
`undef MODULE
assign we = wbs_we_i & wbs_ack_o;
end else if (mode=="B4") begin : B4_inst
reg wbs_ack_o_reg;
always @ (posedge wb_clk or posedge wb_rst)
    if (wb_rst)
        wbs_ack_o_reg <= 1'b0;
    else
        wbs_ack_o_reg <= wbs_stb_i & wbs_cyc_i;
assign wbs_ack_o = wbs_ack_o_reg;
assign wbs_stall_o = 1'b0;
assign adr = wbs_adr_i;
assign we = wbs_we_i & wbs_cyc_i & wbs_stb_i;
end
endgenerate

`define MODULE ram_be
`BASE`MODULE # (
    .data_width(dat_width),
    .addr_width(adr_width),
    .mem_size(mem_size),
    .memory_init(memory_init),
    .memory_file(memory_file))
ram0(
`undef MODULE
    .d(wbs_dat_i),
    .adr(adr),
    .be(wbs_sel_i),
    .we(we),
    .q(wbs_dat_o),
    .clk(wb_clk)
);

endmodule
`endif

`ifdef WB_B4_ROM
// WB ROM
`define MODULE wb_b4_rom
module `BASE`MODULE (
`undef MODULE
    wb_adr_i, wb_stb_i, wb_cyc_i, 
    wb_dat_o, stall_o, wb_ack_o, wb_clk, wb_rst);

    parameter dat_width = 32;
    parameter dat_default = 32'h15000000;
    parameter adr_width = 32;

/*
//E2_ifndef ROM
//E2_define ROM "rom.v"
//E2_endif
*/   
    input [adr_width-1:2]   wb_adr_i;
    input 		    wb_stb_i;
    input 		    wb_cyc_i;
    output [dat_width-1:0]  wb_dat_o;
    reg [dat_width-1:0]     wb_dat_o;
    output  		    wb_ack_o;
    reg                     wb_ack_o;
    output                  stall_o;
    input 		    wb_clk;
    input 		    wb_rst;

always @ (posedge wb_clk or posedge wb_rst)
    if (wb_rst)
        wb_dat_o <= {dat_width{1'b0}};
    else
	 case (wb_adr_i[adr_width-1:2])
//E2_ifdef ROM
//E2_include `ROM
//E2_endif
	   default:
	     wb_dat_o <= dat_default;
	     
	 endcase // case (wb_adr_i)

   
always @ (posedge wb_clk or posedge wb_rst)
    if (wb_rst)
        wb_ack_o <= 1'b0;
    else
        wb_ack_o <= wb_stb_i & wb_cyc_i;

assign stall_o = 1'b0;

endmodule
`endif


`ifdef WB_BOOT_ROM
// WB ROM
`define MODULE wb_boot_rom
module `BASE`MODULE (
`undef MODULE
    wb_adr_i, wb_stb_i, wb_cyc_i, 
    wb_dat_o, wb_ack_o, hit_o, wb_clk, wb_rst);

    parameter adr_hi = 31;
    parameter adr_lo = 28;
    parameter adr_sel = 4'hf;
    parameter addr_width = 5;
/*
//E2_ifndef BOOT_ROM
//E2_define BOOT_ROM "boot_rom.v"
//E2_endif
*/   
    input [adr_hi:2]    wb_adr_i;
    input 		wb_stb_i;
    input 		wb_cyc_i;
    output [31:0] 	wb_dat_o;
    output  		wb_ack_o;
    output              hit_o;
    input 		wb_clk;
    input 		wb_rst;

    wire hit;
    reg [31:0] wb_dat;
    reg wb_ack;
    
assign hit = wb_adr_i[adr_hi:adr_lo] == adr_sel;
   
always @ (posedge wb_clk or posedge wb_rst)
    if (wb_rst)
        wb_dat <= 32'h15000000;
    else
	 case (wb_adr_i[addr_width-1:2])
//E2_ifdef BOOT_ROM
//E2_include `BOOT_ROM
//E2_endif
	   /*	 
	    // Zero r0 and jump to 0x00000100
	    0 : wb_dat <= 32'h18000000;
	    1 : wb_dat <= 32'hA8200000;
	    2 : wb_dat <= 32'hA8C00100;
	    3 : wb_dat <= 32'h44003000;
	    4 : wb_dat <= 32'h15000000;
	    */
	   default:
	     wb_dat <= 32'h00000000;
	     
	 endcase // case (wb_adr_i)

   
always @ (posedge wb_clk or posedge wb_rst)
    if (wb_rst)
        wb_ack <= 1'b0;
    else
        wb_ack <= wb_stb_i & wb_cyc_i & hit & !wb_ack;

assign hit_o = hit;
assign wb_dat_o = wb_dat & {32{wb_ack}};
assign wb_ack_o = wb_ack;

endmodule
`endif

`ifdef WB_B3_DPRAM
`define MODULE wb_b3_dpram
module `BASE`MODULE ( 
`undef MODULE
	// wishbone slave side a
	wbsa_dat_i, wbsa_adr_i, wbsa_sel_i, wbsa_cti_i, wbsa_bte_i, wbsa_we_i, wbsa_cyc_i, wbsa_stb_i, wbsa_dat_o, wbsa_ack_o,
        wbsa_clk, wbsa_rst,
	// wishbone slave side b
	wbsb_dat_i, wbsb_adr_i, wbsb_sel_i, wbsb_cti_i, wbsb_bte_i, wbsb_we_i, wbsb_cyc_i, wbsb_stb_i, wbsb_dat_o, wbsb_ack_o,
        wbsb_clk, wbsb_rst);

parameter data_width_a = 32;
parameter data_width_b = data_width_a;
parameter addr_width_a = 8;
localparam addr_width_b = data_width_a * addr_width_a / data_width_b;
parameter mem_size = (addr_width_a>addr_width_b) ? (1<<addr_width_a) : (1<<addr_width_b);
parameter max_burst_width_a = 4;
parameter max_burst_width_b = max_burst_width_a;
parameter mode = "B3";
input [data_width_a-1:0] wbsa_dat_i;
input [addr_width_a-1:0] wbsa_adr_i;
input [data_width_a/8-1:0] wbsa_sel_i;
input [2:0] wbsa_cti_i;
input [1:0] wbsa_bte_i;
input wbsa_we_i, wbsa_cyc_i, wbsa_stb_i;
output [data_width_a-1:0] wbsa_dat_o;
output wbsa_ack_o;
input wbsa_clk, wbsa_rst;

input [data_width_b-1:0] wbsb_dat_i;
input [addr_width_b-1:0] wbsb_adr_i;
input [data_width_b/8-1:0] wbsb_sel_i;
input [2:0] wbsb_cti_i;
input [1:0] wbsb_bte_i;
input wbsb_we_i, wbsb_cyc_i, wbsb_stb_i;
output [data_width_b-1:0] wbsb_dat_o;
output wbsb_ack_o;
input wbsb_clk, wbsb_rst;

wire [addr_width_a-1:0] adr_a;
wire [addr_width_b-1:0] adr_b;
wire we_a, we_b;
generate
if (mode=="B3") begin : b3_inst
`define MODULE wb_adr_inc 
`BASE`MODULE # ( .adr_width(addr_width_a), .max_burst_width(max_burst_width_a)) adr_inc0 (
    .cyc_i(wbsa_cyc_i),
    .stb_i(wbsa_stb_i),
    .cti_i(wbsa_cti_i),
    .bte_i(wbsa_bte_i),
    .adr_i(wbsa_adr_i),
    .we_i(wbsa_we_i),
    .ack_o(wbsa_ack_o),
    .adr_o(adr_a),
    .clk(wbsa_clk),
    .rst(wbsa_rst));
assign we_a = wbsa_we_i & wbsa_ack_o;
`BASE`MODULE # ( .adr_width(addr_width_b), .max_burst_width(max_burst_width_b)) adr_inc1 (
    .cyc_i(wbsb_cyc_i),
    .stb_i(wbsb_stb_i),
    .cti_i(wbsb_cti_i),
    .bte_i(wbsb_bte_i),
    .adr_i(wbsb_adr_i),
    .we_i(wbsb_we_i),
    .ack_o(wbsb_ack_o),
    .adr_o(adr_b),
    .clk(wbsb_clk),
    .rst(wbsb_rst));
`undef MODULE
assign we_b = wbsb_we_i & wbsb_ack_o;
end else if (mode=="B4") begin : b4_inst
always @ (posedge wbsa_clk or posedge wbsa_rst)
    if (wbsa_rst)
        wbsa_ack_o <= 1'b0;
    else
        wbsa_ack_o <= wbsa_stb_i & wbsa_cyc_i;
assign wbsa_stall_o = 1'b0;
assign we_a = wbsa_we_i & wbsa_cyc_i & wbsa_stb_i;
always @ (posedge wbsb_clk or posedge wbsb_rst)
    if (wbsb_rst)
        wbsb_ack_o <= 1'b0;
    else
        wbsb_ack_o <= wbsb_stb_i & wbsb_cyc_i;
assign wbsb_stall_o = 1'b0;
assign we_b = wbsb_we_i & wbsb_cyc_i & wbsb_stb_i;
end
endgenerate

`define MODULE dpram_be_2r2w
`BASE`MODULE # ( .a_data_width(data_width_a), .a_addr_width(addr_width_a), .mem_size(mem_size))
`undef MODULE
ram_i (
    .d_a(wbsa_dat_i),
    .q_a(wbsa_dat_o),
    .adr_a(adr_a),
    .be_a(wbsa_sel_i),
    .we_a(we_a),
    .clk_a(wbsa_clk),
    .d_b(wbsb_dat_i),
    .q_b(wbsb_dat_o),
    .adr_b(adr_b),
    .be_b(wbsb_sel_i),
    .we_b(we_b),
    .clk_b(wbsb_clk) );

endmodule
`endif

`ifdef WB_CACHE
`define MODULE wb_cache
module `BASE`MODULE (
    wbs_dat_i, wbs_adr_i, wbs_sel_i, wbs_cti_i, wbs_bte_i, wbs_we_i, wbs_stb_i, wbs_cyc_i, wbs_dat_o, wbs_ack_o, wbs_clk, wbs_rst,
    wbm_dat_o, wbm_adr_o, wbm_sel_o, wbm_cti_o, wbm_bte_o, wbm_we_o, wbm_stb_o, wbm_cyc_o, wbm_dat_i, wbm_ack_i, wbm_stall_i, wbm_clk, wbm_rst
);
`undef MODULE

parameter dw_s = 32;
parameter aw_s = 24;
parameter dw_m = dw_s;
localparam aw_m = dw_s * aw_s / dw_m;
parameter wbs_max_burst_width = 4;

parameter async = 1; // wbs_clk != wbm_clk

parameter nr_of_ways = 1;
parameter aw_offset = 4; // 4 => 16 words per cache line
parameter aw_slot = 10;

parameter valid_mem = 0;
parameter debug = 0;

localparam aw_b_offset = aw_offset * dw_s / dw_m;
localparam aw_tag = aw_s - aw_slot - aw_offset;
parameter wbm_burst_size = 4; // valid options 4,8,16
localparam bte = (wbm_burst_size==4) ? 2'b01 : (wbm_burst_size==8) ? 2'b10 : 2'b11;
`define SIZE2WIDTH wbm_burst_size
localparam wbm_burst_width `SIZE2WIDTH_EXPR
`undef SIZE2WIDTH
localparam nr_of_wbm_burst = ((1<<aw_offset)/wbm_burst_size) * dw_s / dw_m; 
`define SIZE2WIDTH nr_of_wbm_burst
localparam nr_of_wbm_burst_width `SIZE2WIDTH_EXPR
`undef SIZE2WIDTH

input [dw_s-1:0] wbs_dat_i;
input [aw_s-1:0] wbs_adr_i; // dont include a1,a0
input [dw_s/8-1:0] wbs_sel_i;
input [2:0] wbs_cti_i;
input [1:0] wbs_bte_i;
input wbs_we_i, wbs_stb_i, wbs_cyc_i;
output [dw_s-1:0] wbs_dat_o;
output wbs_ack_o;
input wbs_clk, wbs_rst;

output [dw_m-1:0] wbm_dat_o;
output [aw_m-1:0] wbm_adr_o;
output [dw_m/8-1:0] wbm_sel_o;
output [2:0] wbm_cti_o;
output [1:0] wbm_bte_o;
output wbm_stb_o, wbm_cyc_o, wbm_we_o;
input [dw_m-1:0] wbm_dat_i;
input wbm_ack_i;
input wbm_stall_i;
input wbm_clk, wbm_rst;

wire valid, dirty, hit;
wire [aw_tag-1:0] tag;
wire tag_mem_we;
wire [aw_tag-1:0] wbs_adr_tag;
wire [aw_slot-1:0] wbs_adr_slot;
wire [aw_offset-1:0] wbs_adr_word;
wire [aw_s-1:0] wbs_adr;

reg [1:0] state;
localparam idle = 2'h0;
localparam rdwr = 2'h1;
localparam push = 2'h2;
localparam pull = 2'h3;
wire eoc;

// cdc
wire done, mem_alert, mem_done;

// wbm side
reg [aw_m-1:0] wbm_radr;
reg [aw_m-1:0] wbm_wadr;
wire [aw_slot-1:0] wbm_adr;
wire wbm_radr_cke, wbm_wadr_cke;

reg [2:0] phase;
// phase = {we,stb,cyc}
localparam wbm_wait     = 3'b000;
localparam wbm_wr       = 3'b111;
localparam wbm_wr_drain = 3'b101;
localparam wbm_rd       = 3'b011;
localparam wbm_rd_drain = 3'b001;

assign {wbs_adr_tag, wbs_adr_slot, wbs_adr_word} = wbs_adr_i;
assign eoc = (wbs_cti_i==3'b000 | wbs_cti_i==3'b111) & wbs_ack_o;

generate
if (valid_mem==0) begin : no_valid_mem
assign valid = 1'b1;
end else begin : valid_mem_inst
`define MODULE dpram_1r1w
`BASE`MODULE
    # ( .data_width(1), .addr_width(aw_slot), .memory_init(2), .debug(debug))
    valid_mem ( .d_a(1'b1), .adr_a(wbs_adr_slot), .we_a(mem_done), .clk_a(wbm_clk),
                .q_b(valid), .adr_b(wbs_adr_slot), .clk_b(wbs_clk));
`undef MODULE
end
endgenerate

`define MODULE dpram_1r1w
`BASE`MODULE
    # ( .data_width(aw_tag), .addr_width(aw_slot), .memory_init(2), .debug(debug))
    tag_mem ( .d_a(wbs_adr_tag), .adr_a(wbs_adr_slot), .we_a(mem_done), .clk_a(wbm_clk),
              .q_b(tag), .adr_b(wbs_adr_slot), .clk_b(wbs_clk));
assign hit = wbs_adr_tag == tag;
`undef MODULE

`define MODULE dpram_1r2w
`BASE`MODULE
    # ( .data_width(1), .addr_width(aw_slot), .memory_init(2), .debug(debug))
    dirty_mem (
        .d_a(1'b1), .q_a(dirty), .adr_a(wbs_adr_slot), .we_a(wbs_cyc_i & wbs_we_i & wbs_ack_o), .clk_a(wbs_clk),
        .d_b(1'b0), .adr_b(wbs_adr_slot), .we_b(mem_done), .clk_b(wbm_clk));
`undef MODULE

`define MODULE wb_adr_inc 
`BASE`MODULE # ( .adr_width(aw_s), .max_burst_width(wbs_max_burst_width)) adr_inc0 (
    .cyc_i(wbs_cyc_i & (state==rdwr) & hit & valid),
    .stb_i(wbs_stb_i & (state==rdwr) & hit & valid), // throttle depending on valid
    .cti_i(wbs_cti_i),
    .bte_i(wbs_bte_i),
    .adr_i(wbs_adr_i),
    .we_i (wbs_we_i),
    .ack_o(wbs_ack_o),
    .adr_o(wbs_adr),
    .clk(wbs_clk),
    .rst(wbs_rst));
`undef MODULE

`define MODULE dpram_be_2r2w
`BASE`MODULE
    # ( .a_data_width(dw_s), .a_addr_width(aw_slot+aw_offset), .b_data_width(dw_m), .debug(debug))
    cache_mem ( .d_a(wbs_dat_i), .adr_a(wbs_adr[aw_slot+aw_offset-1:0]),   .be_a(wbs_sel_i), .we_a(wbs_cyc_i &  wbs_we_i & wbs_ack_o), .q_a(wbs_dat_o), .clk_a(wbs_clk),
                .d_b(wbm_dat_i), .adr_b(wbm_adr_o[aw_slot+aw_offset-1:0]), .be_b(wbm_sel_o), .we_b(wbm_cyc_o & !wbm_we_o & wbs_ack_i), .q_b(wbm_dat_o), .clk_b(wbm_clk));
//                .d_b(wbm_dat_i), .adr_b(wbm_adr), .be_b(wbm_sel_o), .we_b(wbm_cyc_o & !wbm_we_o & wbs_ack_i), .q_b(wbm_dat_o), .clk_b(wbm_clk));
`undef MODULE    

always @ (posedge wbs_clk or posedge wbs_rst)
if (wbs_rst)
    state <= idle;
else
    case (state)
    idle:
        if (wbs_cyc_i)
            state <= rdwr;
    rdwr:
        casex ({valid, hit, dirty, eoc})
        4'b0xxx: state <= pull;
        4'b11x1: state <= idle;
        4'b101x: state <= push;
        4'b100x: state <= pull;
        endcase
    push:
        if (done)
            state <= rdwr;
    pull:
        if (done)
            state <= rdwr;
    default: state <= idle;
    endcase

// cdc
generate
if (async==1) begin : cdc0
`define MODULE cdc
`BASE`MODULE cdc0 ( .start_pl(state==rdwr & (!valid | !hit)), .take_it_pl(mem_alert), .take_it_grant_pl(mem_done), .got_it_pl(done), .clk_src(wbs_clk), .rst_src(wbs_rst), .clk_dst(wbm_clk), .rst_dst(wbm_rst));
`undef MODULE
end
else begin : nocdc
    assign mem_alert = state==rdwr & (!valid | !hit);
    assign done = mem_done;
end
endgenerate

// FSM generating a number of burts 4 cycles
// actual number depends on data width ratio
// nr_of_wbm_burst
reg [nr_of_wbm_burst_width+wbm_burst_width-1:0]       cnt_rw, cnt_ack;

always @ (posedge wbm_clk or posedge wbm_rst)
if (wbm_rst)
    cnt_rw <= {wbm_burst_width{1'b0}};
else
    if (wbm_cyc_o & wbm_stb_o & !wbm_stall_i)
        cnt_rw <= cnt_rw + 1;

always @ (posedge wbm_clk or posedge wbm_rst)
if (wbm_rst)
    cnt_ack <= {wbm_burst_width{1'b0}};
else
    if (wbm_ack_i)
        cnt_ack <= cnt_ack + 1;

generate
if (nr_of_wbm_burst==1) begin : one_burst

always @ (posedge wbm_clk or posedge wbm_rst)
if (wbm_rst)
    phase <= wbm_wait;
else
    case (phase)
    wbm_wait:
        if (mem_alert)
            if (state==push)
                phase <= wbm_wr;
            else
                phase <= wbm_rd;
    wbm_wr:
        if (&cnt_rw)
            phase <= wbm_wr_drain;
    wbm_wr_drain:
        if (&cnt_ack)
            phase <= wbm_rd;
    wbm_rd:
        if (&cnt_rw)
            phase <= wbm_rd_drain;
    wbm_rd_drain:
        if (&cnt_ack)
            phase <= wbm_wait;
    default: phase <= wbm_wait;
    endcase

end else begin : multiple_burst

always @ (posedge wbm_clk or posedge wbm_rst)
if (wbm_rst)
    phase <= wbm_wait;
else
    case (phase)
    wbm_wait:
        if (mem_alert)
            if (state==push)
                phase <= wbm_wr;
            else
                phase <= wbm_rd;
    wbm_wr:
        if (&cnt_rw[wbm_burst_width-1:0])
            phase <= wbm_wr_drain;
    wbm_wr_drain:
        if (&cnt_ack)
            phase <= wbm_rd;
        else if (&cnt_ack[wbm_burst_width-1:0])
            phase <= wbm_wr;
    wbm_rd:
        if (&cnt_rw[wbm_burst_width-1:0])
            phase <= wbm_rd_drain;
    wbm_rd_drain:
        if (&cnt_ack)
            phase <= wbm_wait;
        else if (&cnt_ack[wbm_burst_width-1:0])
            phase <= wbm_rd;
    default: phase <= wbm_wait;
    endcase


end
endgenerate

assign mem_done = phase==wbm_rd_drain & (&cnt_ack) & wbm_ack_i;

assign wbm_adr_o = (phase[2]) ? {tag, wbs_adr_slot, cnt_rw} : {wbs_adr_tag, wbs_adr_slot, cnt_rw};
assign wbm_adr   = (phase[2]) ? {wbs_adr_slot, cnt_rw} : {wbs_adr_slot, cnt_rw};
assign wbm_sel_o = {dw_m/8{1'b1}};
assign wbm_cti_o = (&cnt_rw | !wbm_stb_o) ? 3'b111 : 3'b010;
assign wbm_bte_o = bte;
assign {wbm_we_o, wbm_stb_o, wbm_cyc_o}  = phase;

endmodule
`endif
