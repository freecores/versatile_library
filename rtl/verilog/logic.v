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

module vl_mux4_andor ( a3, a2, a1, a0, sel, dout);

parameter width = 32;
parameter nr_of_ports = 4;
input [width-1:0] a3, a2, a1, a0;
input [nr_of_ports-1:0] sel;
output [width-1:0] dout;

wire [width-1:0] tmp [nr_of_ports-1:0];
integer i;

// and
assign tmp[0] = {width{sel[0]}} & a0;
assign tmp[1] = {width{sel[1]}} & a1;
assign tmp[2] = {width{sel[2]}} & a2;
assign tmp[3] = {width{sel[3]}} & a3;

// or
assign dout = tmp[3] | tmp[2] | tmp[1] | tmp[0];

endmodule

module vl_mux5_andor ( a4, a3, a2, a1, a0, sel, dout);

parameter width = 32;
parameter nr_of_ports = 5;
input [width-1:0] a4, a3, a2, a1, a0;
input [nr_of_ports-1:0] sel;
output [width-1:0] dout;

wire [width-1:0] tmp [nr_of_ports-1:0];
integer i;

// and
assign tmp[0] = {width{sel[0]}} & a0;
assign tmp[1] = {width{sel[1]}} & a1;
assign tmp[2] = {width{sel[2]}} & a2;
assign tmp[3] = {width{sel[3]}} & a3;
assign tmp[4] = {width{sel[4]}} & a4;

// or
assign dout = tmp[4] | tmp[3] | tmp[2] | tmp[1] | tmp[0];

endmodule

module vl_mux6_andor ( a5, a4, a3, a2, a1, a0, sel, dout);

parameter width = 32;
parameter nr_of_ports = 6;
input [width-1:0] a5, a4, a3, a2, a1, a0;
input [nr_of_ports-1:0] sel;
output [width-1:0] dout;

wire [width-1:0] tmp [nr_of_ports-1:0];
integer i;

// and
assign tmp[0] = {width{sel[0]}} & a0;
assign tmp[1] = {width{sel[1]}} & a1;
assign tmp[2] = {width{sel[2]}} & a2;
assign tmp[3] = {width{sel[3]}} & a3;
assign tmp[4] = {width{sel[4]}} & a4;
assign tmp[5] = {width{sel[5]}} & a5;

// or
assign dout = tmp[5] | tmp[4] | tmp[3] | tmp[2] | tmp[1] | tmp[0];

endmodule
