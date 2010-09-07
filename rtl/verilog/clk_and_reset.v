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

`define EXPAND_TO_IFDEF `ifdef
`define EXPAND_TO_ELSE `else
`define EXPAND_TO_ENDIF `endif
// Global buffer
// usage:
// use to enable global buffers for high fan out signal such as clock and reset

`ifdef ACTEL

`timescale 1 ns/100 ps
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
gbuf gbuf_i0 ( .CLK(i), .GL(o));
endmodule
`else
`ifdef ALTERA 
altera
`else

`timescale 1 ns/1 ns
module vl_gbuf ( i, o);
input i;
output o;
assign o = i;
endmodule
`endif // ALTERA
`endif //ACTEL

// sync reset
// input active lo async reset, normally from external reset generetaor and/or switch
// output active high global reset sync with two DFFs 
`timescale 1 ns/1 ns
module vl_sync_rst ( rst_n_i, rst_o, clk);
input rst_n_i, clk;
output rst_o;
reg [0:1] tmp;
always @ (posedge clk or negedge rst_n_i)
if (!rst_n_i)
	tmp <= 2'b00;
else
	tmp <= {1'b1,tmp[0]};
vl_gbuf buf_i0( .i(tmp[1]), .o(rst_o));
endmodule

// vl_pll
`ifdef ACTEL
module vl_pll ( clk_i, rst_n_i, lock, clk_o, rst_o);
parameter index = 0;
parameter number_of_clk = 3;
parameter clk_i_period_time = 20;
parameter [0:number_of_clk-1] mult = {32'd1,32'd2,32'd2};
parameter [0:number_of_clk-1] div  = {32'd1,32'd3,32'd3};
parameter lock_delay = 200;
input clk_i, rst_n_i;
output lock;
output reg [0:number_of_clk-1] clk_o;
output [0:number_of_clk-1] rst_o;

//E2_ifdef SIM_PLL

genvar i;
generate for (i=0;i<number_of_clk;i=i+1) begin: clock
always
     #((clk_i_period_time*div[i]/mult[i])/2) clk_o[i] <=  (!rst_n_i) ? 0 : ~clk_o[i];
     vl_sync_rst rst_i0 ( .rst_n_i(rst_n_i | lock), .rst_o(rst_o[i]), .clk(clk_o[i]));
end
endgenerate

assign #lock_delay lock = rst_n_i;

endmodule
//E2_else
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
//E2_endif

`else

`ifdef ALTERA

`else

// generic PLL
module vl_pll ( clk_i, rst_n_i, lock, clk_o, rst_o);
parameter index = 0;
parameter number_of_clk = 3;
parameter clk_i_period_time = 20;
parameter clk0_feedthrough = 0;
parameter mult = 1;
parameter div  = 1;
parameter [0:number_of_clk-1] post_div  = {32'd1,32'd3,32'd3};
parameter lock_delay = 2000;
input clk_i, rst_n_i;
output lock;
output reg [0:number_of_clk-1] clk_o;
output [0:number_of_clk-1] rst_o;

genvar i;
generate if (clk0_feedthrough==1) begin: clk0_feedthrough
	always #(clk_i_period_time/2+0.200) clk_o[0] <= (!rst_n_i) ? 0 : ~clk_o[0];
generate for (i=clk0_feedthrough;i<number_of_clk;i=i+1) begin: clock
always
     #((clk_i_period_time*div/mult*post_div[i])/2) clk_o[i] <=  (!rst_n_i) ? 0 : ~clk_o[i];
     vl_sync_rst rst_i0 ( .rst_n_i(rst_n_i | lock), .rst_o(rst_o[i]), .clk(clk_o[i]));
end
endgenerate

assign #lock_delay lock = rst_n_i;
	
endmodule

`endif //altera
`endif //actel