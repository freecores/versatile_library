// default SYN_KEEP definition
//////////////////////////////////////////////////////////////////////
////                                                              ////
////  Versatile library, clock and reset                          ////
////                                                              ////
////  Description                                                 ////
////  Logic related to clock and reset                            ////
////                                                              ////
////                                                              ////
////  To Do:                                                      ////
////   - add more different registers                             ////
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
`timescale 1 ns/100 ps
// Global buffer
// usage:
// use to enable global buffers for high fan out signals such as clock and reset
// Version: 8.4 8.4.0.33
module gbuf(GL,CLK);
output GL;
input  CLK;
    wire GND;
    GND GND_1_net(.Y(GND));
    CLKDLY Inst1(.CLK(CLK), .GL(GL), .DLYGL0(GND), .DLYGL1(GND), 
        .DLYGL2(GND), .DLYGL3(GND), .DLYGL4(GND)) /* synthesis black_box */;
endmodule
`timescale 1 ns/1 ns
module vl_gbuf ( i, o);
input i;
output o;
`ifdef SIM_GBUF
assign o=i;
`else
gbuf gbuf_i0 ( .CLK(i), .GL(o));
`endif
endmodule
 //ACTEL
// sync reset
// input active lo async reset, normally from external reset generator and/or switch
// output active high global reset sync with two DFFs 
`timescale 1 ns/100 ps
module vl_sync_rst ( rst_n_i, rst_o, clk);
input rst_n_i, clk;
output rst_o;
reg [1:0] tmp;
always @ (posedge clk or negedge rst_n_i)
if (!rst_n_i)
	tmp <= 2'b11;
else
	tmp <= {1'b0,tmp[1]};
vl_gbuf buf_i0( .i(tmp[0]), .o(rst_o));
endmodule
// vl_pll
///////////////////////////////////////////////////////////////////////////////
`timescale 1 ps/1 ps
module vl_pll ( clk_i, rst_n_i, lock, clk_o, rst_o);
parameter index = 0;
parameter number_of_clk = 1;
parameter period_time_0 = 20000;
parameter period_time_1 = 20000;
parameter period_time_2 = 20000;
parameter lock_delay = 2000000;
input clk_i, rst_n_i;
output lock;
output reg [0:number_of_clk-1] clk_o;
output [0:number_of_clk-1] rst_o;
`ifdef SIM_PLL
always
     #((period_time_0)/2) clk_o[0] <=  (!rst_n_i) ? 0 : ~clk_o[0];
generate if (number_of_clk > 1)
always
     #((period_time_1)/2) clk_o[1] <=  (!rst_n_i) ? 0 : ~clk_o[1];
endgenerate
generate if (number_of_clk > 2)
always
     #((period_time_2)/2) clk_o[2] <=  (!rst_n_i) ? 0 : ~clk_o[2];
endgenerate
genvar i;
generate for (i=0;i<number_of_clk;i=i+1) begin: clock
     vl_sync_rst rst_i0 ( .rst_n_i(rst_n_i | lock), .rst_o(rst_o[i]), .clk(clk_o[i]));
end
endgenerate
assign #lock_delay lock = rst_n_i;
endmodule
`else
generate if (number_of_clk==1 & index==0) begin
	pll0 pll_i0 (.POWERDOWN(1'b1), .CLKA(clk_i), .LOCK(lock), .GLA(clk_o[0]));
end
endgenerate // index==0
generate if (number_of_clk==1 & index==1) begin
	pll1 pll_i0 (.POWERDOWN(1'b1), .CLKA(clk_i), .LOCK(lock), .GLA(clk_o[0]));
end
endgenerate // index==1
generate if (number_of_clk==1 & index==2) begin
	pll2 pll_i0 (.POWERDOWN(1'b1), .CLKA(clk_i), .LOCK(lock), .GLA(clk_o[0]));
end
endgenerate // index==2
generate if (number_of_clk==1 & index==3) begin
	pll3 pll_i0 (.POWERDOWN(1'b1), .CLKA(clk_i), .LOCK(lock), .GLA(clk_o[0]));
end
endgenerate // index==0
generate if (number_of_clk==2 & index==0) begin
	pll0 pll_i0 (.POWERDOWN(1'b1), .CLKA(clk_i), .LOCK(lock), .GLA(clk_o[0]), .GLB(clk_o[1]));
end
endgenerate // index==0
generate if (number_of_clk==2 & index==1) begin
	pll1 pll_i0 (.POWERDOWN(1'b1), .CLKA(clk_i), .LOCK(lock), .GLA(clk_o[0]), .GLB(clk_o[1]));
end
endgenerate // index==1
generate if (number_of_clk==2 & index==2) begin
	pll2 pll_i0 (.POWERDOWN(1'b1), .CLKA(clk_i), .LOCK(lock), .GLA(clk_o[0]), .GLB(clk_o[1]));
end
endgenerate // index==2
generate if (number_of_clk==2 & index==3) begin
	pll3 pll_i0 (.POWERDOWN(1'b1), .CLKA(clk_i), .LOCK(lock), .GLA(clk_o[0]), .GLB(clk_o[1]));
end
endgenerate // index==0
generate if (number_of_clk==3 & index==0) begin
	pll0 pll_i0 (.POWERDOWN(1'b1), .CLKA(clk_i), .LOCK(lock), .GLA(clk_o[0]), .GLB(clk_o[1]), .GLC(clk_o[2]));
end
endgenerate // index==0
generate if (number_of_clk==3 & index==1) begin
	pll1 pll_i0 (.POWERDOWN(1'b1), .CLKA(clk_i), .LOCK(lock), .GLA(clk_o[0]), .GLB(clk_o[1]), .GLC(clk_o[2]));
end
endgenerate // index==1
generate if (number_of_clk==3 & index==2) begin
	pll2 pll_i0 (.POWERDOWN(1'b1), .CLKA(clk_i), .LOCK(lock), .GLA(clk_o[0]), .GLB(clk_o[1]), .GLC(clk_o[2]));
end
endgenerate // index==2
generate if (number_of_clk==3 & index==3) begin
	pll3 pll_i0 (.POWERDOWN(1'b1), .CLKA(clk_i), .LOCK(lock), .GLA(clk_o[0]), .GLB(clk_o[1]), .GLC(clk_o[2]));
end
endgenerate // index==0
genvar i;
generate for (i=0;i<number_of_clk;i=i+1) begin: clock
	vl_sync_rst rst_i0 ( .rst_n_i(rst_n_i | lock), .rst_o(rst_o), .clk(clk_o[i]));
end
endgenerate
endmodule
`endif
///////////////////////////////////////////////////////////////////////////////
 //actel
//////////////////////////////////////////////////////////////////////
////                                                              ////
////  Versatile library, registers                                ////
////                                                              ////
////  Description                                                 ////
////  Different type of registers                                 ////
////                                                              ////
////                                                              ////
////  To Do:                                                      ////
////   - add more different registers                             ////
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
module vl_dff ( d, q, clk, rst);
	parameter width = 1;	
	parameter reset_value = 0;
	input [width-1:0] d; 
	input clk, rst;
	output reg [width-1:0] q;
	always @ (posedge clk or posedge rst)
	if (rst)
		q <= reset_value;
	else
		q <= d;
endmodule
module vl_dff_array ( d, q, clk, rst);
	parameter width = 1;
        parameter depth = 2;
	parameter reset_value = 1'b0;
	input [width-1:0] d; 
	input clk, rst;
	output [width-1:0] q;
        reg  [0:depth-1] q_tmp [width-1:0];
	integer i;
	always @ (posedge clk or posedge rst)
	if (rst) begin
            for (i=0;i<depth;i=i+1)
		q_tmp[i] <= {width{reset_value}};
	end else begin
            q_tmp[0] <= d;
            for (i=1;i<depth;i=i+1)
		q_tmp[i] <= q_tmp[i-1];
        end
    assign q = q_tmp[depth-1];
endmodule
module vl_dff_ce ( d, ce, q, clk, rst);
	parameter width = 1;	
	parameter reset_value = 0;
	input [width-1:0] d; 
	input ce, clk, rst;
	output reg [width-1:0] q;
	always @ (posedge clk or posedge rst)
	if (rst)
		q <= reset_value;
	else
		if (ce)
			q <= d;
endmodule
module vl_dff_ce_clear ( d, ce, clear, q, clk, rst);
	parameter width = 1;	
	parameter reset_value = 0;
	input [width-1:0] d; 
	input ce, clear, clk, rst;
	output reg [width-1:0] q;
	always @ (posedge clk or posedge rst)
	if (rst)
	    q <= reset_value;
	else
            if (ce)
                if (clear)
                    q <= {width{1'b0}};
                else
                    q <= d;
endmodule
module vl_dff_ce_set ( d, ce, set, q, clk, rst);
	parameter width = 1;	
	parameter reset_value = 0;
	input [width-1:0] d; 
	input ce, set, clk, rst;
	output reg [width-1:0] q;
	always @ (posedge clk or posedge rst)
	if (rst)
	    q <= reset_value;
	else
            if (ce)
                if (set)
                    q <= {width{1'b1}};
                else
                    q <= d;
endmodule
module vl_spr ( sp, r, q, clk, rst);
        //parameter width = 1;
        parameter reset_value = 1'b0;
        input sp, r;
        output reg q;
        input clk, rst;
        always @ (posedge clk or posedge rst)
        if (rst)
            q <= reset_value;
        else
            if (sp)
                q <= 1'b1;
            else if (r)
                q <= 1'b0;
endmodule
module vl_srp ( s, rp, q, clk, rst);
        parameter width = 1;
        parameter reset_value = 0;
        input s, rp;
        output reg q;
        input clk, rst;
        always @ (posedge clk or posedge rst)
        if (rst)
            q <= reset_value;
        else
            if (rp)
                q <= 1'b0;
            else if (s)
                q <= 1'b1;
endmodule
module vl_dff_sr ( aclr, aset, clock, data, q);
    input	  aclr;
    input	  aset;
    input	  clock;
    input	  data;
    output reg	  q;
   always @ (posedge clock or posedge aclr or posedge aset)
     if (aclr)
       q <= 1'b0;
     else if (aset)
       q <= 1'b1;
     else
       q <= data;
endmodule
// LATCH
// For targtes not supporting LATCH use dff_sr with clk=1 and data=1
module vl_latch ( d, le, q, clk);
input d, le;
input clk;
always @ (le or d)
if (le)
    d <= q;
endmodule
module vl_shreg ( d, q, clk, rst);
parameter depth = 10;
input d;
output q;
input clk, rst;
reg [1:depth] dffs;
always @ (posedge clk or posedge rst)
if (rst)
    dffs <= {depth{1'b0}};
else
    dffs <= {d,dffs[1:depth-1]};
assign q = dffs[depth];
endmodule
module vl_shreg_ce ( d, ce, q, clk, rst);
parameter depth = 10;
input d, ce;
output q;
input clk, rst;
reg [1:depth] dffs;
always @ (posedge clk or posedge rst)
if (rst)
    dffs <= {depth{1'b0}};
else
    if (ce)
        dffs <= {d,dffs[1:depth-1]};
assign q = dffs[depth];
endmodule
module vl_delay ( d, q, clk, rst);
parameter depth = 10;
input d;
output q;
input clk, rst;
reg [1:depth] dffs;
always @ (posedge clk or posedge rst)
if (rst)
    dffs <= {depth{1'b0}};
else
    dffs <= {d,dffs[1:depth-1]};
assign q = dffs[depth];
endmodule
module vl_delay_emptyflag ( d, q, emptyflag, clk, rst);
parameter depth = 10;
input d;
output q, emptyflag;
input clk, rst;
reg [1:depth] dffs;
always @ (posedge clk or posedge rst)
if (rst)
    dffs <= {depth{1'b0}};
else
    dffs <= {d,dffs[1:depth-1]};
assign q = dffs[depth];
assign emptyflag = !(|dffs);
endmodule
//////////////////////////////////////////////////////////////////////
////                                                              ////
////  Logic functions                                             ////
////                                                              ////
////  Description                                                 ////
////  Logic functions such as multiplexers                        ////
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
module vl_mux_andor ( a, sel, dout);
parameter width = 32;
parameter nr_of_ports = 4;
input [nr_of_ports*width-1:0] a;
input [nr_of_ports-1:0] sel;
output reg [width-1:0] dout;
integer i,j;
always @ (a, sel)
begin
    dout = a[width-1:0] & {width{sel[0]}};
    for (i=1;i<nr_of_ports;i=i+1)
        for (j=0;j<width;j=j+1)
            dout[j] = (a[i*width + j] & sel[i]) | dout[j];
end
endmodule
module vl_mux2_andor ( a1, a0, sel, dout);
parameter width = 32;
localparam nr_of_ports = 2;
input [width-1:0] a1, a0;
input [nr_of_ports-1:0] sel;
output [width-1:0] dout;
vl_mux_andor
    # ( .width(width), .nr_of_ports(nr_of_ports))
    mux0( .a({a1,a0}), .sel(sel), .dout(dout));
endmodule
module vl_mux3_andor ( a2, a1, a0, sel, dout);
parameter width = 32;
localparam nr_of_ports = 3;
input [width-1:0] a2, a1, a0;
input [nr_of_ports-1:0] sel;
output [width-1:0] dout;
vl_mux_andor
    # ( .width(width), .nr_of_ports(nr_of_ports))
    mux0( .a({a2,a1,a0}), .sel(sel), .dout(dout));
endmodule
module vl_mux4_andor ( a3, a2, a1, a0, sel, dout);
parameter width = 32;
localparam nr_of_ports = 4;
input [width-1:0] a3, a2, a1, a0;
input [nr_of_ports-1:0] sel;
output [width-1:0] dout;
vl_mux_andor
    # ( .width(width), .nr_of_ports(nr_of_ports))
    mux0( .a({a3,a2,a1,a0}), .sel(sel), .dout(dout));
endmodule
module vl_mux5_andor ( a4, a3, a2, a1, a0, sel, dout);
parameter width = 32;
localparam nr_of_ports = 5;
input [width-1:0] a4, a3, a2, a1, a0;
input [nr_of_ports-1:0] sel;
output [width-1:0] dout;
vl_mux_andor
    # ( .width(width), .nr_of_ports(nr_of_ports))
    mux0( .a({a4,a3,a2,a1,a0}), .sel(sel), .dout(dout));
endmodule
module vl_mux6_andor ( a5, a4, a3, a2, a1, a0, sel, dout);
parameter width = 32;
localparam nr_of_ports = 6;
input [width-1:0] a5, a4, a3, a2, a1, a0;
input [nr_of_ports-1:0] sel;
output [width-1:0] dout;
vl_mux_andor
    # ( .width(width), .nr_of_ports(nr_of_ports))
    mux0( .a({a5,a4,a3,a2,a1,a0}), .sel(sel), .dout(dout));
endmodule
module vl_parity_generate (data, parity);
parameter word_size = 32;
parameter chunk_size = 8;
parameter parity_type = 1'b0; // 0 - even, 1 - odd parity
input [word_size-1:0] data;
output reg [word_size/chunk_size-1:0] parity;
integer i,j;
always @ (data)
for (i=0;i<word_size/chunk_size;i=i+1) begin
    parity[i] = parity_type;
    for (j=0;j<chunk_size;j=j+1) begin
        parity[i] = data[i*chunk_size+j] ^ parity[i];
    end
end
endmodule
module vl_parity_check( data, parity, parity_error);
parameter word_size = 32;
parameter chunk_size = 8;
parameter parity_type = 1'b0; // 0 - even, 1 - odd parity
input [word_size-1:0] data;
input [word_size/chunk_size-1:0] parity;
output parity_error;
reg [word_size/chunk_size-1:0] error_flag;
integer i,j;
always @ (data or parity)
for (i=0;i<word_size/chunk_size;i=i+1) begin
    error_flag[i] = parity[i] ^ parity_type;
    for (j=0;j<chunk_size;j=j+1) begin
        error_flag[i] = data[i*chunk_size+j] ^ error_flag[i];
    end
end
assign parity_error = |error_flag;
endmodule
//////////////////////////////////////////////////////////////////////
////                                                              ////
////  IO functions                                                ////
////                                                              ////
////  Description                                                 ////
////  IO functions such as IOB flip-flops                         ////
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
`timescale 1ns/1ns
module vl_o_dff (d_i, o_pad, clk, rst);
parameter width = 1;
parameter reset_value = {width{1'b0}};
input  [width-1:0]  d_i;
output [width-1:0] o_pad;
input clk, rst;
wire [width-1:0] d_i_int /*synthesis syn_keep = 1*/;
reg  [width-1:0] o_pad_int;
assign d_i_int = d_i;
genvar i;
generate
for (i=0;i<width;i=i+1) begin
    always @ (posedge clk or posedge rst)
    if (rst)
        o_pad_int[i] <= reset_value[i];
    else
        o_pad_int[i] <= d_i_int[i];
    assign #1 o_pad[i] = o_pad_int[i];
end
endgenerate
endmodule
`timescale 1ns/1ns
module vl_io_dff_oe ( d_i, d_o, oe, io_pad, clk, rst);
parameter width = 1;
input  [width-1:0] d_o;
output reg [width-1:0] d_i;
input oe;
inout [width-1:0] io_pad;
input clk, rst;
wire [width-1:0] oe_d /*synthesis syn_keep = 1*/;
reg [width-1:0] oe_q;
reg [width-1:0] d_o_q;
assign oe_d = {width{oe}};
genvar i;
generate
for (i=0;i<width;i=i+1) begin
    always @ (posedge clk or posedge rst)
    if (rst)
        oe_q[i] <= 1'b0;
    else
        oe_q[i] <= oe_d[i];
    always @ (posedge clk or posedge rst)
    if (rst)
        d_o_q[i] <= 1'b0;
    else
        d_o_q[i] <= d_o[i];
    always @ (posedge clk or posedge rst)
    if (rst)
        d_i[i] <= 1'b0;
    else
        d_i[i] <= io_pad[i];
    assign #1 io_pad[i] = (oe_q[i]) ? d_o_q[i] : 1'bz;
end
endgenerate
endmodule
//////////////////////////////////////////////////////////////////////
////                                                              ////
////  Versatile counter                                           ////
////                                                              ////
////  Description                                                 ////
////  Versatile counter, a reconfigurable binary, gray or LFSR    ////
////  counter                                                     ////
////                                                              ////
////  To Do:                                                      ////
////   - add LFSR with more taps                                  ////
////                                                              ////
////  Author(s):                                                  ////
////      - Michael Unneback, unneback@opencores.org              ////
////        ORSoC AB                                              ////
////                                                              ////
//////////////////////////////////////////////////////////////////////
////                                                              ////
//// Copyright (C) 2009 Authors and OPENCORES.ORG                 ////
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
// binary counter
module vl_cnt_bin_ce (
 cke, q, rst, clk);
   parameter length = 4;
   input cke;
   output [length:1] q;
   input rst;
   input clk;
   parameter clear_value = 0;
   parameter set_value = 1;
   parameter wrap_value = 0;
   parameter level1_value = 15;
   reg  [length:1] qi;
   wire [length:1] q_next;
   assign q_next = qi + {{length-1{1'b0}},1'b1};
   always @ (posedge clk or posedge rst)
     if (rst)
       qi <= {length{1'b0}};
     else
     if (cke)
       qi <= q_next;
   assign q = qi;
endmodule
//////////////////////////////////////////////////////////////////////
////                                                              ////
////  Versatile counter                                           ////
////                                                              ////
////  Description                                                 ////
////  Versatile counter, a reconfigurable binary, gray or LFSR    ////
////  counter                                                     ////
////                                                              ////
////  To Do:                                                      ////
////   - add LFSR with more taps                                  ////
////                                                              ////
////  Author(s):                                                  ////
////      - Michael Unneback, unneback@opencores.org              ////
////        ORSoC AB                                              ////
////                                                              ////
//////////////////////////////////////////////////////////////////////
////                                                              ////
//// Copyright (C) 2009 Authors and OPENCORES.ORG                 ////
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
// binary counter
module vl_cnt_bin_ce_rew_zq_l1 (
 cke, rew, zq, level1, rst, clk);
   parameter length = 4;
   input cke;
   input rew;
   output reg zq;
   output reg level1;
   input rst;
   input clk;
   parameter clear_value = 0;
   parameter set_value = 1;
   parameter wrap_value = 1;
   parameter level1_value = 15;
   wire clear;
   assign clear = 1'b0;
   reg  [length:1] qi;
   wire  [length:1] q_next, q_next_fw, q_next_rew;
   assign q_next_fw  = qi + {{length-1{1'b0}},1'b1};
   assign q_next_rew = qi - {{length-1{1'b0}},1'b1};
   assign q_next = rew ? q_next_rew : q_next_fw;
   always @ (posedge clk or posedge rst)
     if (rst)
       qi <= {length{1'b0}};
     else
     if (cke)
       qi <= q_next;
   always @ (posedge clk or posedge rst)
     if (rst)
       zq <= 1'b1;
     else
     if (cke)
       zq <= q_next == {length{1'b0}};
    always @ (posedge clk or posedge rst)
    if (rst)
        level1 <= 1'b0;
    else
    if (cke)
    if (clear)
        level1 <= 1'b0;
    else if (q_next == level1_value)
        level1 <= 1'b1;
    else if (qi == level1_value & rew)
        level1 <= 1'b0;
endmodule
//////////////////////////////////////////////////////////////////////
////                                                              ////
////  Versatile counter                                           ////
////                                                              ////
////  Description                                                 ////
////  Versatile counter, a reconfigurable binary, gray or LFSR    ////
////  counter                                                     ////
////                                                              ////
////  To Do:                                                      ////
////   - add LFSR with more taps                                  ////
////                                                              ////
////  Author(s):                                                  ////
////      - Michael Unneback, unneback@opencores.org              ////
////        ORSoC AB                                              ////
////                                                              ////
//////////////////////////////////////////////////////////////////////
////                                                              ////
//// Copyright (C) 2009 Authors and OPENCORES.ORG                 ////
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
// binary counter
module vl_cnt_bin_ce_rew_q_zq_l1 (
 cke, rew, q, zq, level1, rst, clk);
   parameter length = 4;
   input cke;
   input rew;
   output [length:1] q;
   output reg zq;
   output reg level1;
   input rst;
   input clk;
   parameter clear_value = 0;
   parameter set_value = 1;
   parameter wrap_value = 1;
   parameter level1_value = 15;
   wire clear;
   assign clear = 1'b0;
   reg  [length:1] qi;
   wire  [length:1] q_next, q_next_fw, q_next_rew;
   assign q_next_fw  = qi + {{length-1{1'b0}},1'b1};
   assign q_next_rew = qi - {{length-1{1'b0}},1'b1};
   assign q_next = rew ? q_next_rew : q_next_fw;
   always @ (posedge clk or posedge rst)
     if (rst)
       qi <= {length{1'b0}};
     else
     if (cke)
       qi <= q_next;
   assign q = qi;
   always @ (posedge clk or posedge rst)
     if (rst)
       zq <= 1'b1;
     else
     if (cke)
       zq <= q_next == {length{1'b0}};
    always @ (posedge clk or posedge rst)
    if (rst)
        level1 <= 1'b0;
    else
    if (cke)
    if (clear)
        level1 <= 1'b0;
    else if (q_next == level1_value)
        level1 <= 1'b1;
    else if (qi == level1_value & rew)
        level1 <= 1'b0;
endmodule
//////////////////////////////////////////////////////////////////////
////                                                              ////
////  Versatile counter                                           ////
////                                                              ////
////  Description                                                 ////
////  Versatile counter, a reconfigurable binary, gray or LFSR    ////
////  counter                                                     ////
////                                                              ////
////  To Do:                                                      ////
////   - add LFSR with more taps                                  ////
////                                                              ////
////  Author(s):                                                  ////
////      - Michael Unneback, unneback@opencores.org              ////
////        ORSoC AB                                              ////
////                                                              ////
//////////////////////////////////////////////////////////////////////
////                                                              ////
//// Copyright (C) 2009 Authors and OPENCORES.ORG                 ////
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
// LFSR counter
module vl_cnt_lfsr_ce (
 cke, zq, rst, clk);
   parameter length = 4;
   input cke;
   output reg zq;
   input rst;
   input clk;
   parameter clear_value = 0;
   parameter set_value = 1;
   parameter wrap_value = 0;
   parameter level1_value = 15;
   reg  [length:1] qi;
   reg lfsr_fb;
   wire [length:1] q_next;
   reg [32:1] polynom;
   integer i;
   always @ (qi)
   begin
        case (length) 
         2: polynom = 32'b11;                               // 0x3
         3: polynom = 32'b110;                              // 0x6
         4: polynom = 32'b1100;                             // 0xC
         5: polynom = 32'b10100;                            // 0x14
         6: polynom = 32'b110000;                           // 0x30
         7: polynom = 32'b1100000;                          // 0x60
         8: polynom = 32'b10111000;                         // 0xb8
         9: polynom = 32'b100010000;                        // 0x110
        10: polynom = 32'b1001000000;                       // 0x240
        11: polynom = 32'b10100000000;                      // 0x500
        12: polynom = 32'b100000101001;                     // 0x829
        13: polynom = 32'b1000000001100;                    // 0x100C
        14: polynom = 32'b10000000010101;                   // 0x2015
        15: polynom = 32'b110000000000000;                  // 0x6000
        16: polynom = 32'b1101000000001000;                 // 0xD008
        17: polynom = 32'b10010000000000000;                // 0x12000
        18: polynom = 32'b100000010000000000;               // 0x20400
        19: polynom = 32'b1000000000000100011;              // 0x40023
        20: polynom = 32'b10010000000000000000;             // 0x90000
        21: polynom = 32'b101000000000000000000;            // 0x140000
        22: polynom = 32'b1100000000000000000000;           // 0x300000
        23: polynom = 32'b10000100000000000000000;          // 0x420000
        24: polynom = 32'b111000010000000000000000;         // 0xE10000
        25: polynom = 32'b1001000000000000000000000;        // 0x1200000
        26: polynom = 32'b10000000000000000000100011;       // 0x2000023
        27: polynom = 32'b100000000000000000000010011;      // 0x4000013
        28: polynom = 32'b1100100000000000000000000000;     // 0xC800000
        29: polynom = 32'b10100000000000000000000000000;    // 0x14000000
        30: polynom = 32'b100000000000000000000000101001;   // 0x20000029
        31: polynom = 32'b1001000000000000000000000000000;  // 0x48000000
        32: polynom = 32'b10000000001000000000000000000011; // 0x80200003
        default: polynom = 32'b0;
        endcase
        lfsr_fb = qi[length];
        for (i=length-1; i>=1; i=i-1) begin
            if (polynom[i])
                lfsr_fb = lfsr_fb  ~^ qi[i];
        end
    end
   assign q_next = (qi == wrap_value) ? {length{1'b0}} :{qi[length-1:1],lfsr_fb};
   always @ (posedge clk or posedge rst)
     if (rst)
       qi <= {length{1'b0}};
     else
     if (cke)
       qi <= q_next;
   always @ (posedge clk or posedge rst)
     if (rst)
       zq <= 1'b1;
     else
     if (cke)
       zq <= q_next == {length{1'b0}};
endmodule
//////////////////////////////////////////////////////////////////////
////                                                              ////
////  Versatile counter                                           ////
////                                                              ////
////  Description                                                 ////
////  Versatile counter, a reconfigurable binary, gray or LFSR    ////
////  counter                                                     ////
////                                                              ////
////  To Do:                                                      ////
////   - add LFSR with more taps                                  ////
////                                                              ////
////  Author(s):                                                  ////
////      - Michael Unneback, unneback@opencores.org              ////
////        ORSoC AB                                              ////
////                                                              ////
//////////////////////////////////////////////////////////////////////
////                                                              ////
//// Copyright (C) 2009 Authors and OPENCORES.ORG                 ////
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
// GRAY counter
module vl_cnt_gray_ce_bin (
 cke, q, q_bin, rst, clk);
   parameter length = 4;
   input cke;
   output reg [length:1] q;
   output [length:1] q_bin;
   input rst;
   input clk;
   parameter clear_value = 0;
   parameter set_value = 1;
   parameter wrap_value = 8;
   parameter level1_value = 15;
   reg  [length:1] qi;
   wire [length:1] q_next;
   assign q_next = qi + {{length-1{1'b0}},1'b1};
   always @ (posedge clk or posedge rst)
     if (rst)
       qi <= {length{1'b0}};
     else
     if (cke)
       qi <= q_next;
   always @ (posedge clk or posedge rst)
     if (rst)
       q <= {length{1'b0}};
     else
       if (cke)
         q <= (q_next>>1) ^ q_next;
   assign q_bin = qi;
endmodule
//////////////////////////////////////////////////////////////////////
////                                                              ////
////  Versatile library, counters                                 ////
////                                                              ////
////  Description                                                 ////
////  counters                                                    ////
////                                                              ////
////                                                              ////
////  To Do:                                                      ////
////   - add more counters                                        ////
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
module vl_cnt_shreg_wrap ( q, rst, clk);
   parameter length = 4;
   output reg [0:length-1] q;
   input rst;
   input clk;
    always @ (posedge clk or posedge rst)
    if (rst)
        q <= {1'b1,{length-1{1'b0}}};
    else
        q <= {q[length-1],q[0:length-2]};
endmodule
module vl_cnt_shreg_ce_wrap ( cke, q, rst, clk);
   parameter length = 4;
   input cke;
   output reg [0:length-1] q;
   input rst;
   input clk;
    always @ (posedge clk or posedge rst)
    if (rst)
        q <= {1'b1,{length-1{1'b0}}};
    else
        if (cke)
            q <= {q[length-1],q[0:length-2]};
endmodule
module vl_cnt_shreg_ce_clear ( cke, clear, q, rst, clk);
   parameter length = 4;
   input cke, clear;
   output reg [0:length-1] q;
   input rst;
   input clk;
    always @ (posedge clk or posedge rst)
    if (rst)
        q <= {1'b1,{length-1{1'b0}}};
    else
        if (cke)
            if (clear)
                q <= {1'b1,{length-1{1'b0}}};
            else
                q <= q >> 1;
endmodule
module vl_cnt_shreg_ce_clear_wrap ( cke, clear, q, rst, clk);
   parameter length = 4;
   input cke, clear;
   output reg [0:length-1] q;
   input rst;
   input clk;
    always @ (posedge clk or posedge rst)
    if (rst)
        q <= {1'b1,{length-1{1'b0}}};
    else
        if (cke)
            if (clear)
                q <= {1'b1,{length-1{1'b0}}};
            else
            q <= {q[length-1],q[0:length-2]};
endmodule
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
   parameter mem_size = 1<<addr_width;
   input [(addr_width-1):0] 	 adr;
   output reg [(data_width-1):0] q;
   input 			 clk;
   reg [data_width-1:0] rom [mem_size-1:0];
   parameter memory_file = "vl_rom.vmem";
   initial
     begin
	$readmemh(memory_file, rom);
     end
   always @ (posedge clk)
     q <= rom[adr];
endmodule
// Single port RAM
module vl_ram ( d, adr, we, q, clk);
   parameter data_width = 32;
   parameter addr_width = 8;
   parameter mem_size = 1<<addr_width;
   input [(data_width-1):0]      d;
   input [(addr_width-1):0] 	 adr;
   input 			 we;
   output reg [(data_width-1):0] q;
   input 			 clk;
   reg [data_width-1:0] ram [mem_szie-1:0];
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
   parameter addr_width = 6;
   parameter mem_size = 1<<addr_width;
   input [(data_width-1):0]      d;
   input [(addr_width-1):0] 	 adr;
   input [(data_width/8)-1:0]    be;
   input 			 we;
   output reg [(data_width-1):0] q;
   input 			 clk;
`ifdef SYSTEMVERILOG
   logic [data_width/8-1:0][7:0] ram[0:mem_size-1];// # words = 1 << address width
`else
    reg [data_width-1:0] ram [mem_size-1:0];
    wire [data_width/8-1:0] cke;
`endif
   parameter memory_init = 0;
   parameter memory_file = "vl_ram.vmem";
   generate if (memory_init) begin : init_mem
   initial
     begin
	$readmemh(memory_file, ram);
     end
   end
   endgenerate 
`ifdef SYSTEMVERILOG
// use a multi-dimensional packed array
//to model individual bytes within the word
always_ff@(posedge clk)
begin
    if(we) begin // note: we should have a for statement to support any bus width
        if(be[3]) ram[adr][3] <= d[31:24];
        if(be[2]) ram[adr][2] <= d[23:16];
        if(be[1]) ram[adr][1] <= d[15:8];
        if(be[0]) ram[adr][0] <= d[7:0];
    end
        q <= ram[adr];
end
`else
assign cke = {data_width/8{we}} & be;
   genvar i;
   generate for (i=0;i<data_width/8;i=i+1) begin : be_ram
      always @ (posedge clk)
      if (cke[i])
        ram[adr][(i+1)*8-1:i*8] <= d[(i+1)*8-1:i*8];
   end
   endgenerate
   always @ (posedge clk)
      q <= ram[adr];
`endif
   // Function to access RAM (for use by Verilator).
   function [31:0] get_mem;
      // verilator public
      input [addr_width-1:0] 		addr;
      get_mem = ram[addr];
   endfunction // get_mem
   // Function to write RAM (for use by Verilator).
   function set_mem;
      // verilator public
      input [addr_width-1:0] 		addr;
      input [data_width-1:0] 		data;
      ram[addr] = data;
   endfunction // set_mem
endmodule
        // ACTEL FPGA should not use logic to handle rw collision
module vl_dpram_1r1w ( d_a, adr_a, we_a, clk_a, q_b, adr_b, clk_b );
   parameter data_width = 32;
   parameter addr_width = 8;
   parameter mem_size = 1<<addr_width;
   input [(data_width-1):0]      d_a;
   input [(addr_width-1):0] 	 adr_a;
   input [(addr_width-1):0] 	 adr_b;
   input 			 we_a;
   output [(data_width-1):0] 	 q_b;
   input 			 clk_a, clk_b;
   reg [(addr_width-1):0] 	 adr_b_reg;
   reg [data_width-1:0] ram [mem_szie-1:0] /*synthesis syn_ramstyle = "no_rw_check"*/;
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
   parameter mem_size = 1<<addr_width;
   input [(data_width-1):0]      d_a;
   input [(addr_width-1):0] 	 adr_a;
   input [(addr_width-1):0] 	 adr_b;
   input 			 we_a;
   output [(data_width-1):0] 	 q_b;
   output reg [(data_width-1):0] q_a;
   input 			 clk_a, clk_b;
   reg [(data_width-1):0] 	 q_b;   
   reg [data_width-1:0] ram [mem_szie-1:0] /*synthesis syn_ramstyle = "no_rw_check"*/;
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
   parameter mem_size = 1<<addr_width;
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
   reg [data_width-1:0] ram [mem_size-1:0] /*synthesis syn_ramstyle = "no_rw_check"*/;
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
module vl_dpram_be_2r2w ( d_a, q_a, adr_a, be_a, we_a, clk_a, d_b, q_b, adr_b, be_b, we_b, clk_b );
   parameter a_data_width = 32;
   parameter a_addr_width = 8;
   parameter b_data_width = a_data_width;
   localparam b_addr_width = a_data_width * a_addr_width / b_data_width;
   parameter mem_size = (a_addr_width>b_addr_width) ? (1<<a_addr_width) : (1<<b_addr_width);
   input [(a_data_width-1):0]      d_a;
   input [(a_addr_width-1):0] 	   adr_a;
   input [(a_data_width/8-1):0]    be_a;
   input 			   we_a;
   output reg [(a_data_width-1):0] q_a;
   input [(b_data_width-1):0] 	   d_b;
   input [(b_addr_width-1):0] 	   adr_b;
   input [(b_data_width/8-1):0]    be_b;
   input 			   we_b;
   output reg [(b_data_width-1):0] 	   q_b;
   input 			   clk_a, clk_b;
`ifdef SYSTEMVERILOG
// use a multi-dimensional packed array
//to model individual bytes within the word
generate
if (a_data_width==32 & b_data_width==32) begin : dpram_3232
   logic [3:0][7:0] ram [0:mem_size-1];
    always_ff@(posedge clk_a)
    begin
        if(we_a) begin
            if(be_a[3]) ram[adr_a][3] <= d_a[31:24];
            if(be_a[2]) ram[adr_a][2] <= d_a[23:16];
            if(be_a[1]) ram[adr_a][1] <= d_a[15:8];
            if(be_a[0]) ram[adr_a][0] <= d_a[7:0];
        end
    end
    always@(posedge clk_a)
        q_a = ram[adr_a];
    always_ff@(posedge clk_b)
    begin
        if(we_b) begin
            if(be_b[3]) ram[adr_b][3] <= d_b[31:24];
            if(be_b[2]) ram[adr_b][2] <= d_b[23:16];
            if(be_b[1]) ram[adr_b][1] <= d_b[15:8];
            if(be_b[0]) ram[adr_b][0] <= d_b[7:0];
        end
    end
    always@(posedge clk_b)
        q_b = ram[adr_b];
end
endgenerate
`else
    // This modules requires SystemVerilog
`endif
endmodule
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
vl_cnt_bin_ce_rew_q_zq_l1
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
    # (.length(addr_width), .level1_value(fifo_full_level))
    a_fill_level_cnt( .cke(a_rd ^ a_wr), .rew(a_rd), .q(a_fill_level), .zq(a_fifo_empty), .level1(a_fifo_full), .rst(rst), .clk(clk));
vl_cnt_bin_ce_rew_zq_l1
    # (.length(addr_width), .level1_value(fifo_full_level))
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
   wire direction;
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
    vl_dff_sr dff_sr_dir( .aclr(direction_clr), .aset(direction_set), .clock(1'b1), .data(1'b1), .q(direction));
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
module vl_reg_file (
    a1, a2, a3, wd3, we3, rd1, rd2, clk
);
parameter data_width = 32;
parameter addr_width = 5;
input [addr_width-1:0] a1, a2, a3;
input [data_width-1:0] wd3;
input we3;
output [data_width-1:0] rd1, rd2;
input clk;
reg [data_width-1:0] wd3_reg;
reg [addr_width-1:0] a1_reg, a2_reg, a3_reg;
reg we3_reg;
reg [data_width-1:0] ram1 [(1<<addr_width)-1:0] /*synthesis syn_ramstyle = "no_rw_check"*/;
reg [data_width-1:0] ram2 [(1<<addr_width)-1:0] /*synthesis syn_ramstyle = "no_rw_check"*/;
always @ (posedge clk or posedge rst)
if (rst)
    {wd3_reg, a3_reg, we3_reg} <= {(data_width+addr_width+1){1'b0}};
else
    {wd3_reg, a3_reg, we3_reg} <= {wd3,a3,wd3};
    always @ (negedge clk)
    if (we3_reg)
        ram1[a3_reg] <= wd3;
    always @ (posedge clk)
        a1_reg <= a1;   
    assign rd1 = ram1[a1_reg];
    always @ (negedge clk)
    if (we3_reg)
        ram2[a3_reg] <= wd3;
    always @ (posedge clk)
        a2_reg <= a2;   
    assign rd2 = ram2[a2_reg];
endmodule
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
// async wb3 - wb3 bridge
`timescale 1ns/1ns
module vl_wb_adr_inc ( cyc_i, stb_i, cti_i, bte_i, adr_i, we_i, ack_o, adr_o, clk, rst);
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
// async wb3 - wb3 bridge
`timescale 1ns/1ns
module vl_wb3wb3_bridge ( 
	// wishbone slave side
	wbs_dat_i, wbs_adr_i, wbs_sel_i, wbs_bte_i, wbs_cti_i, wbs_we_i, wbs_cyc_i, wbs_stb_i, wbs_dat_o, wbs_ack_o, wbs_clk, wbs_rst,
	// wishbone master side
	wbm_dat_o, wbm_adr_o, wbm_sel_o, wbm_bte_o, wbm_cti_o, wbm_we_o, wbm_cyc_o, wbm_stb_o, wbm_dat_i, wbm_ack_i, wbm_clk, wbm_rst);
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
parameter addr_width = 4;
// bte
parameter linear       = 2'b00;
parameter wrap4        = 2'b01;
parameter wrap8        = 2'b10;
parameter wrap16       = 2'b11;
// cti
parameter classic      = 3'b000;
parameter incburst     = 3'b010;
parameter endofburst   = 3'b111;
parameter wbs_adr  = 1'b0;
parameter wbs_data = 1'b1;
parameter wbm_adr0      = 2'b00;
parameter wbm_adr1      = 2'b01;
parameter wbm_data      = 2'b10;
parameter wbm_data_wait = 2'b11;
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
assign wbs_eoc_alert = (wbs_bte_reg==wrap4 & wbs_count[3]) | (wbs_bte_reg==wrap8 & wbs_count[7]) | (wbs_bte_reg==wrap16 & wbs_count[15]);
always @ (posedge wbs_clk or posedge wbs_rst)
if (wbs_rst)
	wbs_eoc <= 1'b0;
else
	if (wbs==wbs_adr & wbs_stb_i & !a_fifo_full)
		wbs_eoc <= (wbs_bte_i==linear) | (wbs_cti_i==3'b111);
	else if (wbs_eoc_alert & (a_rd | a_wr))
		wbs_eoc <= 1'b1;
vl_cnt_shreg_ce_clear # ( .length(16))
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
		wbm_eoc <= b_q[4:3] == linear;
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
vl_dff dff1 ( .d(b_rd_data), .q(b_rd_data_reg), .clk(wbm_clk), .rst(wbm_rst));
vl_dff_ce # ( .width(36)) dff2 ( .d(b_q), .ce(b_rd_data_reg), .q(temp), .clk(wbm_clk), .rst(wbm_rst));
assign {wbm_dat_o,wbm_sel_o} = (b_rd_data_reg) ? b_q : temp;
vl_cnt_shreg_ce_clear # ( .length(16))
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
vl_fifo_2r2w_async_simplex
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
module vl_wb3avalon_bridge ( 
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
vl_wb3wb3_bridge wbwb3inst (
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
module vl_wb3_arbiter_type1 (
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
    vl_spr sr0( .sp(select[i]), .r(eoc[i]), .q(state[i]), .clk(wb_clk), .rst(wb_rst));
end
endgenerate
    assign sel = select | state;
    vl_mux_andor # ( .nr_of_ports(nr_of_ports), .width(32)) mux0 ( .a(wbm_dat_o), .sel(sel), .dout(wbs_dat_i));
    vl_mux_andor # ( .nr_of_ports(nr_of_ports), .width(adr_size-adr_lo)) mux1 ( .a(wbm_adr_o), .sel(sel), .dout(wbs_adr_i));
    vl_mux_andor # ( .nr_of_ports(nr_of_ports), .width(sel_size)) mux2 ( .a(wbm_sel_o), .sel(sel), .dout(wbs_sel_i));
    vl_mux_andor # ( .nr_of_ports(nr_of_ports), .width(3)) mux3 ( .a(wbm_cti_o), .sel(sel), .dout(wbs_cti_i));
    vl_mux_andor # ( .nr_of_ports(nr_of_ports), .width(2)) mux4 ( .a(wbm_bte_o), .sel(sel), .dout(wbs_bte_i));
    vl_mux_andor # ( .nr_of_ports(nr_of_ports), .width(1)) mux5 ( .a(wbm_we_o), .sel(sel), .dout(wbs_we_i));
    vl_mux_andor # ( .nr_of_ports(nr_of_ports), .width(1)) mux6 ( .a(wbm_stb_o), .sel(sel), .dout(wbs_stb_i));
    assign wbs_cyc_i = |sel;
    assign wbm_dat_i = {nr_of_ports{wbs_dat_o}};
    assign wbm_ack_i = {nr_of_ports{wbs_ack_o}} & sel;
    assign wbm_err_i = {nr_of_ports{wbs_err_o}} & sel;
    assign wbm_rty_i = {nr_of_ports{wbs_rty_o}} & sel;
endmodule
// WB RAM with byte enable
module vl_wb_b3_ram_be (
    wbs_dat_i, wbs_adr_i, wbs_cti_i, wbs_bte_i, wbs_sel_i, wbs_we_i, wbs_stb_i, wbs_cyc_i, 
    wbs_dat_o, wbs_ack_o, wb_clk, wb_rst);
parameter adr_size = 16;
parameter mem_size = 1<<adr_size;
parameter dat_size = 32;
parameter max_burst_width = 4;
parameter memory_init = 1;
parameter memory_file = "vl_ram.vmem";
localparam aw = (adr_size);
localparam dw = dat_size;
localparam sw = dat_size/8;
localparam cw = 3;
localparam bw = 2;
input [dw-1:0] wbs_dat_i;
input [aw-1:0] wbs_adr_i;
input [cw-1:0] wbs_cti_i;
input [bw-1:0] wbs_bte_i;
input [sw-1:0] wbs_sel_i;
input wbs_we_i, wbs_stb_i, wbs_cyc_i;
output [dw-1:0] wbs_dat_o;
output wbs_ack_o;
input wb_clk, wb_rst;
wire [aw-1:0] adr;
vl_ram_be # (
    .data_width(dat_size),
    .addr_width(aw),
    .mem_size(mem_size),
    .memory_init(memory_init),
    .memory_file(memory_file))
ram0(
    .d(wbs_dat_i),
    .adr(adr),
    .be(wbs_sel_i),
    .we(wbs_we_i & wbs_ack_o),
    .q(wbs_dat_o),
    .clk(wb_clk)
);
vl_wb_adr_inc # ( .adr_width(aw), .max_burst_width(max_burst_width)) adr_inc0 (
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
endmodule
// WB RAM with byte enable
module vl_wb_b4_ram_be (
    wb_dat_i, wb_adr_i, wb_sel_i, wb_we_i, wb_stb_i, wb_cyc_i, 
    wb_dat_o, wb_stall_o, wb_ack_o, wb_clk, wb_rst);
    parameter dat_width = 32;
    parameter adr_width = 8;
input [dat_width-1:0] wb_dat_i;
input [adr_width-1:0] wb_adr_i;
input [dat_width/8-1:0] wb_sel_i;
input wb_we_i, wb_stb_i, wb_cyc_i;
output [dat_width-1:0] wb_dat_o;
reg [dat_width-1:0] wb_dat_o;
output wb_stall_o;
output wb_ack_o;
reg wb_ack_o;
input wb_clk, wb_rst;
wire [dat_width/8-1:0] cke;
generate
if (dat_width==32) begin
reg [7:0] ram3 [1<<(adr_width-2)-1:0];
reg [7:0] ram2 [1<<(adr_width-2)-1:0];
reg [7:0] ram1 [1<<(adr_width-2)-1:0];
reg [7:0] ram0 [1<<(adr_width-2)-1:0];
assign cke = wb_sel_i & {(dat_width/8){wb_we_i}};
    always @ (posedge wb_clk)
    begin
        if (cke[3]) ram3[wb_adr_i[adr_width-1:2]] <= wb_dat_i[31:24];
        if (cke[2]) ram2[wb_adr_i[adr_width-1:2]] <= wb_dat_i[23:16];
        if (cke[1]) ram1[wb_adr_i[adr_width-1:2]] <= wb_dat_i[15:8];
        if (cke[0]) ram0[wb_adr_i[adr_width-1:2]] <= wb_dat_i[7:0];
    end
    always @ (posedge wb_clk or posedge wb_rst)
    begin
        if (wb_rst)
            wb_dat_o <= 32'h0;
        else
            wb_dat_o <= {ram3[wb_adr_i[adr_width-1:2]],ram2[wb_adr_i[adr_width-1:2]],ram1[wb_adr_i[adr_width-1:2]],ram0[wb_adr_i[adr_width-1:2]]};
    end
end
endgenerate
always @ (posedge wb_clk or posedge wb_rst)
if (wb_rst)
    wb_ack_o <= 1'b0;
else
    wb_ack_o <= wb_stb_i & wb_cyc_i;
assign wb_stall_o = 1'b0;
endmodule
// WB ROM
module vl_wb_b4_rom (
    wb_adr_i, wb_stb_i, wb_cyc_i, 
    wb_dat_o, stall_o, wb_ack_o, wb_clk, wb_rst);
    parameter dat_width = 32;
    parameter dat_default = 32'h15000000;
    parameter adr_width = 32;
/*
`ifndef ROM
`define ROM "rom.v"
`endif
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
`ifdef ROM
`include `ROM
`endif
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
// WB ROM
module vl_wb_boot_rom (
    wb_adr_i, wb_stb_i, wb_cyc_i, 
    wb_dat_o, wb_ack_o, hit_o, wb_clk, wb_rst);
    parameter adr_hi = 31;
    parameter adr_lo = 28;
    parameter adr_sel = 4'hf;
    parameter addr_width = 5;
/*
`ifndef BOOT_ROM
`define BOOT_ROM "boot_rom.v"
`endif
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
`ifdef BOOT_ROM
`include `BOOT_ROM
`endif
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
//////////////////////////////////////////////////////////////////////
////                                                              ////
////  Arithmetic functions                                        ////
////                                                              ////
////  Description                                                 ////
////  Arithmetic functions for ALU and DSP                        ////
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
// signed multiplication
module vl_mults (a,b,p);
parameter operand_a_width = 18;
parameter operand_b_width = 18;
parameter result_hi = 35;
parameter result_lo = 0;
input [operand_a_width-1:0] a;
input [operand_b_width-1:0] b;
output [result_hi:result_lo] p;
wire signed [operand_a_width-1:0] ai;
wire signed [operand_b_width-1:0] bi;
wire signed [operand_a_width+operand_b_width-1:0] result;
    assign ai = a;
    assign bi = b;
    assign result = ai * bi;
    assign p = result[result_hi:result_lo];
endmodule
module vl_mults18x18 (a,b,p);
input [17:0] a,b;
output [35:0] p;
vl_mult
    # (.operand_a_width(18), .operand_b_width(18))
    mult0 (.a(a), .b(b), .p(p));
endmodule
// unsigned multiplication
module vl_mult (a,b,p);
parameter operand_a_width = 18;
parameter operand_b_width = 18;
parameter result_hi = 35;
parameter result_lo = 0;
input [operand_a_width-1:0] a;
input [operand_b_width-1:0] b;
output [result_hi:result_hi] p;
wire [operand_a_width+operand_b_width-1:0] result;
    assign result = a * b;
    assign p = result[result_hi:result_lo];
endmodule
// shift unit
// supporting the following shift functions
//   SLL
//   SRL
//   SRA
module vl_shift_unit_32( din, s, dout, opcode);
input [31:0] din; // data in operand
input [4:0] s; // shift operand
input [1:0] opcode;
output [31:0] dout;
parameter opcode_sll = 2'b00;
//parameter opcode_srl = 2'b01;
parameter opcode_sra = 2'b10;
//parameter opcode_ror = 2'b11;
wire sll, sra;
assign sll = opcode == opcode_sll;
assign sra = opcode == opcode_sra;
wire [15:1] s1;
wire [3:0] sign;
wire [7:0] tmp [0:3];
// first stage is multiplier based
// shift operand as fractional 8.7
assign s1[15] = sll & s[2:0]==3'd7;
assign s1[14] = sll & s[2:0]==3'd6;
assign s1[13] = sll & s[2:0]==3'd5;
assign s1[12] = sll & s[2:0]==3'd4;
assign s1[11] = sll & s[2:0]==3'd3;
assign s1[10] = sll & s[2:0]==3'd2;
assign s1[ 9] = sll & s[2:0]==3'd1;
assign s1[ 8] = s[2:0]==3'd0;
assign s1[ 7] = !sll & s[2:0]==3'd1;
assign s1[ 6] = !sll & s[2:0]==3'd2;
assign s1[ 5] = !sll & s[2:0]==3'd3;
assign s1[ 4] = !sll & s[2:0]==3'd4;
assign s1[ 3] = !sll & s[2:0]==3'd5;
assign s1[ 2] = !sll & s[2:0]==3'd6;
assign s1[ 1] = !sll & s[2:0]==3'd7;
assign sign[3] = din[31] & sra;
assign sign[2] = sign[3] & (&din[31:24]);
assign sign[1] = sign[2] & (&din[23:16]);
assign sign[0] = sign[1] & (&din[15:8]);
vl_mults # ( .operand_a_width(25), .operand_b_width(16), .result_hi(14), .result_lo(7)) mult_byte3 ( .a({sign[3], {8{sign[3]}},din[31:24], din[23:16]}), .b({1'b0,s1}), .p(tmp[3]));
vl_mults # ( .operand_a_width(25), .operand_b_width(16), .result_hi(14), .result_lo(7)) mult_byte2 ( .a({sign[2], din[31:24]  ,din[23:16],  din[15:8]}), .b({1'b0,s1}), .p(tmp[2]));
vl_mults # ( .operand_a_width(25), .operand_b_width(16), .result_hi(14), .result_lo(7)) mult_byte1 ( .a({sign[1], din[23:16]  ,din[15:8],   din[7:0]}), .b({1'b0,s1}), .p(tmp[1]));
vl_mults # ( .operand_a_width(25), .operand_b_width(16), .result_hi(14), .result_lo(7)) mult_byte0 ( .a({sign[0], din[15:8]   ,din[7:0],    8'h00}),      .b({1'b0,s1}), .p(tmp[0]));
// second stage is multiplexer based
// shift on byte level
// mux byte 3
assign dout[31:24] = (s[4:3]==2'b00) ? tmp[3] :
                     (sll & s[4:3]==2'b01) ? tmp[2] :
                     (sll & s[4:3]==2'b10) ? tmp[1] :
                     (sll & s[4:3]==2'b11) ? tmp[0] :
                     {8{sign[3]}};
// mux byte 2
assign dout[23:16] = (s[4:3]==2'b00) ? tmp[2] :
                     (sll & s[4:3]==2'b01) ? tmp[1] :
                     (sll & s[4:3]==2'b10) ? tmp[0] :
                     (sll & s[4:3]==2'b11) ? {8{1'b0}} :
                     (s[4:3]==2'b01) ? tmp[3] :
                     {8{sign[3]}};
// mux byte 1
assign dout[15:8]  = (s[4:3]==2'b00) ? tmp[1] :
                     (sll & s[4:3]==2'b01) ? tmp[0] :
                     (sll & s[4:3]==2'b10) ? {8{1'b0}} :
                     (sll & s[4:3]==2'b11) ? {8{1'b0}} :
                     (s[4:3]==2'b01) ? tmp[2] :
                     (s[4:3]==2'b10) ? tmp[3] :
                     {8{sign[3]}};
// mux byte 0
assign dout[7:0]   = (s[4:3]==2'b00) ? tmp[0] :
                     (sll) ?  {8{1'b0}}:
                     (s[4:3]==2'b01) ? tmp[1] :
                     (s[4:3]==2'b10) ? tmp[2] :
                     tmp[3];
endmodule
// logic unit
// supporting the following logic functions
//    a and b
//    a or  b
//    a xor b
//    not b
module vl_logic_unit( a, b, result, opcode);
parameter width = 32;
parameter opcode_and = 2'b00;
parameter opcode_or  = 2'b01;
parameter opcode_xor = 2'b10;
input [width-1:0] a,b;
output [width-1:0] result;
input [1:0] opcode;
assign result = (opcode==opcode_and) ? a & b :
                (opcode==opcode_or)  ? a | b :
                (opcode==opcode_xor) ? a ^ b :
                b;
endmodule
