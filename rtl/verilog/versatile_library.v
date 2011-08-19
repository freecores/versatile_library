`ifndef BASE
`define BASE vl_
`endif
 
// default SYN_KEEP definition
`define SYN_KEEP /*synthesis syn_keep = 1*/

`ifdef ACTEL
`undef SYN_KEEP
`define SYN_KEEP /*synthesis syn_keep = 1*/
`endif

`ifdef ALL

`define GBUF
`define SYNC_RST
`define PLL

`define MULTS
`define MULTS18X18
`define MULT
`define SHIFT_UNIT_32
`define LOGIC_UNIT

`define CNT_SHREG_WRAP
`define CNT_SHREG_CE_WRAP
`define CNT_SHREG_CE_CLEAR
`define CNT_SHREG_CE_CLEAR_WRAP

`define MUX_ANDOR
`define MUX2_ANDOR
`define MUX3_ANDOR
`define MUX4_ANDOR
`define MUX5_ANDOR
`define MUX6_ANDOR
`define PARITY

`define ROM_INIT
`define RAM
`define RAM_BE
`define DPRAM_1R1W
`define DPRAM_2R1W
`define DPRAM_2R2W
`define DPRAM_BE_2R2W
`define FIFO_1R1W_FILL_LEVEL_SYNC
`define FIFO_2R2W_SYNC_SIMPLEX
`define FIFO_CMP_ASYNC
`define FIFO_1R1W_ASYNC
`define FIFO_2R2W_ASYNC
`define FIFO_2R2W_ASYNC_SIMPLEX
`define REG_FILE

`define DFF
`define DFF_ARRAY
`define DFF_CE
`define DFF_CE_CLEAR
`define DF_CE_SET
`define SPR
`define SRP
`define DFF_SR
`define LATCH
`define SHREG
`define SHREG_CE
`define DELAY
`define DELAY_EMPTYFLAG

`define WB3AVALON_BRIDGE
`define WB3WB3_BRIDGE
`define WB3_ARBITER_TYPE1
`define WB_B3_RAM_BE
`define WB_B4_RAM_BE
`define WB_B4_ROM
`define WB_BOOT_ROM
`define WB_DPRAM

`define IO_DFF_OE
`define O_DFF

`endif

`ifdef PLL
`ifndef SYNC_RST
`define SYNC_RST
`endif
`endif

`ifdef SYNC_RST
`ifndef GBUF
`define GBUF
`endif
`endif

`ifdef WB_DPRAM
`ifndef DPRAM_2R2W
`define DPRAM_2R2W
`endif
`ifndef SPR
`define SPR
`endif
`endif

`ifdef WB_B3_RAM_BE
`ifndef WB3_ARBITER_TYPE1
`define WB3_ARBITER_TYPE1
`endif
`ifndef RAM_BE
`define RAM_BE
`endif
`endif

`ifdef WB3_ARBITER_TYPE1
`ifndef SPR
`define SPR
`endif
`ifndef MUX_ANDOR
`define MUX_ANDOR
`endif
`endif

`ifdef WB3AVALON_BRIDGE
`ifndef WB3WB3_BRIDGE
`define WB3WB3_BRIDGE
`endif
`endif

`ifdef WB3WB3_BRIDGE
`ifndef CNT_SHREG_CE_CLEAR
`define CNT_SHREG_CE_CLEAR
`endif
`ifndef DFF
`define DFF
`endif
`ifndef DFF_CE
`define DFF_CE
`endif
`ifndef CNT_SHREG_CE_CLEAR
`define CNT_SHREG_CE_CLEAR
`endif
`ifndef FIFO_2R2W_ASYNC_SIMPLEX
`define FIFO_2R2W_ASYNC_SIMPLEX
`endif
`endif

`ifdef MULTS18X18
`ifndef MULTS
`define MULTS
`endif
`endif

`ifdef SHIFT_UNIT_32
`ifndef MULTS
`define MULTS
`endif
`endif

`ifdef MUX2_ANDOR
`ifndef MUX_ANDOR
`define MUX_ANDOR
`endif
`endif

`ifdef MUX3_ANDOR
`ifndef MUX_ANDOR
`define MUX_ANDOR
`endif
`endif

`ifdef MUX4_ANDOR
`ifndef MUX_ANDOR
`define MUX_ANDOR
`endif
`endif

`ifdef MUX5_ANDOR
`ifndef MUX_ANDOR
`define MUX_ANDOR
`endif
`endif

`ifdef MUX6_ANDOR
`ifndef MUX_ANDOR
`define MUX_ANDOR
`endif
`endif

`ifdef FIFO_1R1W_FILL_LEVEL_SYNC
`ifndef CNT_BIN_CE
`define CNT_BIN_CE
`endif
`ifndef DPRAM_1R1W
`define DPRAM_1R1W
`endif
`ifndef CNT_BIN_CE_REW_Q_ZQ_L1
`define CNT_BIN_CE_REW_Q_ZQ_L1
`endif
`endif

`ifdef FIFO_1R1W_FILL_LEVEL_SYNC
`ifndef CNT_LFSR_CE
`define CNT_LFSR_CE
`endif
`ifndef DPRAM_2R2W
`define DPRAM_2R2W
`endif
`ifndef CNT_BIN_CE_REW_ZQ_L1
`define CNT_BIN_CE_REW_ZQ_L1
`endif
`endif

`ifdef FIFO_2R2W_ASYNC_SIMPLEX
`ifndef CNT_GRAY_CE_BIN
`define CNT_GRAY_CE_BIN
`endif
`ifndef DPRAM_2R2W
`define DPRAM_2R2W
`endif
`ifndef FIFO_CMP_ASYNC
`define FIFO_CMP_ASYNC
`endif
`endif

`ifdef FIFO_2R2W_ASYNC
`ifndef FIFO_1R1W_ASYNC
`define FIFO_1R1W_ASYNC
`endif
`endif

`ifdef FIFO_1R1W_ASYNC
`ifndef CNT_GRAY_CE_BIN
`define CNT_GRAY_CE_BIN
`endif
`ifndef DPRAM_1R1W
`define DPRAM_1R1W
`endif
`ifndef FIFO_CMP_ASYNC
`define FIFO_CMP_ASYNC
`endif
`endif

`ifdef FIFO_CMP_ASYNC
`ifndef DFF_SR
`define DFF_SR
`endif
`ifndef DFF
`define DFF
`endif
`endif

`ifdef REG_FILE
`ifndef DPRAM_1R1W
`define DPRAM_1R1W
`endif
`endif
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

`ifdef ACTEL
`ifdef GBUF
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
`define MODULE gbuf
module `BASE`MODULE ( i, o);
`undef MODULE
input i;
output o;
`ifdef SIM_GBUF
assign o=i;
`else
gbuf gbuf_i0 ( .CLK(i), .GL(o));
`endif
endmodule
`endif

`else

`ifdef ALTERA
`ifdef GBUF
//altera
`define MODULE gbuf
module `BASE`MODULE ( i, o);
`undef MODULE
input i;
output o;
assign o = i;
endmodule
`endif

`else

`ifdef GBUF
`timescale 1 ns/100 ps
`define MODULE
module `BASE`MODULE ( i, o);
`undef MODULE
input i;
output o;
assign o = i;
endmodule
`endif
`endif // ALTERA
`endif //ACTEL

`ifdef SYNC_RST
// sync reset
// input active lo async reset, normally from external reset generator and/or switch
// output active high global reset sync with two DFFs 
`timescale 1 ns/100 ps
`define MODULE sync_rst
module `BASE`MODULE ( rst_n_i, rst_o, clk);
`undef MODULE
input rst_n_i, clk;
output rst_o;
reg [1:0] tmp;
always @ (posedge clk or negedge rst_n_i)
if (!rst_n_i)
	tmp <= 2'b11;
else
	tmp <= {1'b0,tmp[1]};
`define MODULE gbuf
`BASE`MODULE buf_i0( .i(tmp[0]), .o(rst_o));
`undef MODULE
endmodule
`endif

`ifdef PLL
// vl_pll
`ifdef ACTEL
///////////////////////////////////////////////////////////////////////////////
`timescale 1 ps/1 ps
`define MODULE pll
module `BASE`MODULE ( clk_i, rst_n_i, lock, clk_o, rst_o);
`undef MODULE
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
`define MODULE sync_rst
	`BASE`MODULE rst_i0 ( .rst_n_i(rst_n_i | lock), .rst_o(rst_o), .clk(clk_o[i]));
`undef MODULE
end
endgenerate
endmodule
`endif
///////////////////////////////////////////////////////////////////////////////

`else

///////////////////////////////////////////////////////////////////////////////
`ifdef ALTERA

`timescale 1 ps/1 ps
`define MODULE pll
module `BASE`MODULE ( clk_i, rst_n_i, lock, clk_o, rst_o);
`undef MODULE
parameter index = 0;
parameter number_of_clk = 1;
parameter period_time_0 = 20000;
parameter period_time_1 = 20000;
parameter period_time_2 = 20000;
parameter period_time_3 = 20000;
parameter period_time_4 = 20000;
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

generate if (number_of_clk > 3)
always
     #((period_time_3)/2) clk_o[3] <=  (!rst_n_i) ? 0 : ~clk_o[3];
endgenerate

generate if (number_of_clk > 4)
always
     #((period_time_4)/2) clk_o[4] <=  (!rst_n_i) ? 0 : ~clk_o[4];
endgenerate

genvar i;
generate for (i=0;i<number_of_clk;i=i+1) begin: clock
     vl_sync_rst rst_i0 ( .rst_n_i(rst_n_i | lock), .rst_o(rst_o[i]), .clk(clk_o[i]));
end
endgenerate

//assign #lock_delay lock = rst_n_i;
assign lock = rst_n_i;
	
endmodule
`else

`ifdef VL_PLL0
`ifdef VL_PLL0_CLK1
    pll0 pll0_i0 (.areset(rst_n_i), .inclk0(clk_i), .locked(lock), .c0(clk_o[0]));
`endif
`ifdef VL_PLL0_CLK2
    pll0 pll0_i0 (.areset(rst_n_i), .inclk0(clk_i), .locked(lock), .c0(clk_o[0]), .c1(clk_o[1]));
`endif
`ifdef VL_PLL0_CLK3
    pll0 pll0_i0 (.areset(rst_n_i), .inclk0(clk_i), .locked(lock), .c0(clk_o[0]), .c1(clk_o[1]), .c2(clk_o[2]));
`endif
`ifdef VL_PLL0_CLK4
    pll0 pll0_i0 (.areset(rst_n_i), .inclk0(clk_i), .locked(lock), .c0(clk_o[0]), .c1(clk_o[1]), .c2(clk_o[2]), .c3(clk_o[3]));
`endif
`ifdef VL_PLL0_CLK5
    pll0 pll0_i0 (.areset(rst_n_i), .inclk0(clk_i), .locked(lock), .c0(clk_o[0]), .c1(clk_o[1]), .c2(clk_o[2]), .c3(clk_o[3]), .c4(clk_o[4]));
`endif
`endif

`ifdef VL_PLL1
`ifdef VL_PLL1_CLK1
    pll1 pll1_i0 (.areset(rst_n_i), .inclk0(clk_i), .locked(lock), .c0(clk_o[0]));
`endif
`ifdef VL_PLL1_CLK2
    pll1 pll1_i0 (.areset(rst_n_i), .inclk0(clk_i), .locked(lock), .c0(clk_o[0]), .c1(clk_o[1]));
`endif
`ifdef VL_PLL1_CLK3
    pll1 pll1_i0 (.areset(rst_n_i), .inclk0(clk_i), .locked(lock), .c0(clk_o[0]), .c1(clk_o[1]), .c2(clk_o[2]));
`endif
`ifdef VL_PLL1_CLK4
    pll1 pll1_i0 (.areset(rst_n_i), .inclk0(clk_i), .locked(lock), .c0(clk_o[0]), .c1(clk_o[1]), .c2(clk_o[2]), .c3(clk_o[3]));
`endif
`ifdef VL_PLL1_CLK5
    pll1 pll1_i0 (.areset(rst_n_i), .inclk0(clk_i), .locked(lock), .c0(clk_o[0]), .c1(clk_o[1]), .c2(clk_o[2]), .c3(clk_o[3]), .c4(clk_o[4]));
`endif
`endif

`ifdef VL_PLL2
`ifdef VL_PLL2_CLK1
    pll2 pll2_i0 (.areset(rst_n_i), .inclk0(clk_i), .locked(lock), .c0(clk_o[0]));
`endif
`ifdef VL_PLL2_CLK2
    pll2 pll2_i0 (.areset(rst_n_i), .inclk0(clk_i), .locked(lock), .c0(clk_o[0]), .c1(clk_o[1]));
`endif
`ifdef VL_PLL2_CLK3
    pll2 pll2_i0 (.areset(rst_n_i), .inclk0(clk_i), .locked(lock), .c0(clk_o[0]), .c1(clk_o[1]), .c2(clk_o[2]));
`endif
`ifdef VL_PLL2_CLK4
    pll2 pll2_i0 (.areset(rst_n_i), .inclk0(clk_i), .locked(lock), .c0(clk_o[0]), .c1(clk_o[1]), .c2(clk_o[2]), .c3(clk_o[3]));
`endif
`ifdef VL_PLL2_CLK5
    pll2 pll2_i0 (.areset(rst_n_i), .inclk0(clk_i), .locked(lock), .c0(clk_o[0]), .c1(clk_o[1]), .c2(clk_o[2]), .c3(clk_o[3]), .c4(clk_o[4]));
`endif
`endif

`ifdef VL_PLL3
`ifdef VL_PLL3_CLK1
    pll3 pll3_i0 (.areset(rst_n_i), .inclk0(clk_i), .locked(lock), .c0(clk_o[0]));
`endif
`ifdef VL_PLL3_CLK2
    pll3 pll3_i0 (.areset(rst_n_i), .inclk0(clk_i), .locked(lock), .c0(clk_o[0]), .c1(clk_o[1]));
`endif
`ifdef VL_PLL3_CLK3
    pll3 pll3_i0 (.areset(rst_n_i), .inclk0(clk_i), .locked(lock), .c0(clk_o[0]), .c1(clk_o[1]), .c2(clk_o[2]));
`endif
`ifdef VL_PLL3_CLK4
    pll3 pll3_i0 (.areset(rst_n_i), .inclk0(clk_i), .locked(lock), .c0(clk_o[0]), .c1(clk_o[1]), .c2(clk_o[2]), .c3(clk_o[3]));
`endif
`ifdef VL_PLL3_CLK5
    pll3 pll3_i0 (.areset(rst_n_i), .inclk0(clk_i), .locked(lock), .c0(clk_o[0]), .c1(clk_o[1]), .c2(clk_o[2]), .c3(clk_o[3]), .c4(clk_o[4]));
`endif
`endif

genvar i;
generate for (i=0;i<number_of_clk;i=i+1) begin: clock
`define MODULE sync_rst
	`BASE`MODULE rst_i0 ( .rst_n_i(rst_n_i | lock), .rst_o(rst_o[i]), .clk(clk_o[i]));
`undef MODULE
end
endgenerate
endmodule
`endif
///////////////////////////////////////////////////////////////////////////////

`else

// generic PLL
`timescale 1 ps/1 ps
`define MODULE pll
module `BASE`MODULE ( clk_i, rst_n_i, lock, clk_o, rst_o);
`undef MODULE
parameter index = 0;
parameter number_of_clk = 1;
parameter period_time_0 = 20000;
parameter period_time_1 = 20000;
parameter period_time_2 = 20000;
parameter lock_delay = 2000;
input clk_i, rst_n_i;
output lock;
output reg [0:number_of_clk-1] clk_o;
output [0:number_of_clk-1] rst_o;

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
`define MODULE sync_rst
     `BASE`MODULE rst_i0 ( .rst_n_i(rst_n_i | lock), .rst_o(rst_o[i]), .clk(clk_o[i]));
`undef MODULE
end
endgenerate

assign #lock_delay lock = rst_n_i;
	
endmodule

`endif //altera
`endif //actel
`undef MODULE
`endif//////////////////////////////////////////////////////////////////////
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

`ifdef DFF
`define MODULE dff
module `BASE`MODULE ( d, q, clk, rst);
`undef MODULE
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
`endif

`ifdef DFF_ARRAY
`define MODULE dff_array
module `BASE`MODULE ( d, q, clk, rst);
`undef MODULE

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
`endif

`ifdef DFF_CE
`define MODULE dff_ce
module `BASE`MODULE ( d, ce, q, clk, rst);
`undef MODULE

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
`endif

`ifdef DFF_CE_CLEAR
`define MODULE dff_ce_clear
module `BASE`MODULE ( d, ce, clear, q, clk, rst);
`undef MODULE

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
`endif

`ifdef DF_CE_SET
`define MODULE dff_ce_set
module `BASE`MODULE ( d, ce, set, q, clk, rst);
`undef MODULE

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
`endif

`ifdef SPR
`define MODULE spr
module `BASE`MODULE ( sp, r, q, clk, rst);
`undef MODULE

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
`endif

`ifdef SRP
`define MODULE srp
module `BASE`MODULE ( s, rp, q, clk, rst);
`undef MODULE

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
`endif

`ifdef ALTERA

`ifdef DFF_SR
// megafunction wizard: %LPM_FF%
// GENERATION: STANDARD
// VERSION: WM1.0
// MODULE: lpm_ff 

// ============================================================
// File Name: dff_sr.v
// Megafunction Name(s):
// 			lpm_ff
//
// Simulation Library Files(s):
// 			lpm
// ============================================================
// ************************************************************
// THIS IS A WIZARD-GENERATED FILE. DO NOT EDIT THIS FILE!
//
// 9.1 Build 304 01/25/2010 SP 1 SJ Full Version
// ************************************************************


//Copyright (C) 1991-2010 Altera Corporation
//Your use of Altera Corporation's design tools, logic functions 
//and other software and tools, and its AMPP partner logic 
//functions, and any output files from any of the foregoing 
//(including device programming or simulation files), and any 
//associated documentation or information are expressly subject 
//to the terms and conditions of the Altera Program License 
//Subscription Agreement, Altera MegaCore Function License 
//Agreement, or other applicable license agreement, including, 
//without limitation, that your use is for the sole purpose of 
//programming logic devices manufactured by Altera and sold by 
//Altera or its authorized distributors.  Please refer to the 
//applicable agreement for further details.


// synopsys translate_off
`timescale 1 ps / 1 ps
// synopsys translate_on
`define MODULE dff_sr
module `BASE`MODULE (
`undef MODULE

	aclr,
	aset,
	clock,
	data,
	q);

	input	  aclr;
	input	  aset;
	input	  clock;
	input	  data;
	output	  q;

	wire [0:0] sub_wire0;
	wire [0:0] sub_wire1 = sub_wire0[0:0];
	wire  q = sub_wire1;
	wire  sub_wire2 = data;
	wire  sub_wire3 = sub_wire2;

	lpm_ff	lpm_ff_component (
				.aclr (aclr),
				.clock (clock),
				.data (sub_wire3),
				.aset (aset),
				.q (sub_wire0)
				// synopsys translate_off
				,
				.aload (),
				.enable (),
				.sclr (),
				.sload (),
				.sset ()
				// synopsys translate_on
				);
	defparam
		lpm_ff_component.lpm_fftype = "DFF",
		lpm_ff_component.lpm_type = "LPM_FF",
		lpm_ff_component.lpm_width = 1;


endmodule

// ============================================================
// CNX file retrieval info
// ============================================================
// Retrieval info: PRIVATE: ACLR NUMERIC "1"
// Retrieval info: PRIVATE: ALOAD NUMERIC "0"
// Retrieval info: PRIVATE: ASET NUMERIC "1"
// Retrieval info: PRIVATE: ASET_ALL1 NUMERIC "1"
// Retrieval info: PRIVATE: CLK_EN NUMERIC "0"
// Retrieval info: PRIVATE: DFF NUMERIC "1"
// Retrieval info: PRIVATE: INTENDED_DEVICE_FAMILY STRING "Cyclone IV E"
// Retrieval info: PRIVATE: SCLR NUMERIC "0"
// Retrieval info: PRIVATE: SLOAD NUMERIC "0"
// Retrieval info: PRIVATE: SSET NUMERIC "0"
// Retrieval info: PRIVATE: SSET_ALL1 NUMERIC "1"
// Retrieval info: PRIVATE: SYNTH_WRAPPER_GEN_POSTFIX STRING "0"
// Retrieval info: PRIVATE: UseTFFdataPort NUMERIC "0"
// Retrieval info: PRIVATE: nBit NUMERIC "1"
// Retrieval info: CONSTANT: LPM_FFTYPE STRING "DFF"
// Retrieval info: CONSTANT: LPM_TYPE STRING "LPM_FF"
// Retrieval info: CONSTANT: LPM_WIDTH NUMERIC "1"
// Retrieval info: USED_PORT: aclr 0 0 0 0 INPUT NODEFVAL aclr
// Retrieval info: USED_PORT: aset 0 0 0 0 INPUT NODEFVAL aset
// Retrieval info: USED_PORT: clock 0 0 0 0 INPUT NODEFVAL clock
// Retrieval info: USED_PORT: data 0 0 0 0 INPUT NODEFVAL data
// Retrieval info: USED_PORT: q 0 0 0 0 OUTPUT NODEFVAL q
// Retrieval info: CONNECT: @clock 0 0 0 0 clock 0 0 0 0
// Retrieval info: CONNECT: q 0 0 0 0 @q 0 0 1 0
// Retrieval info: CONNECT: @aclr 0 0 0 0 aclr 0 0 0 0
// Retrieval info: CONNECT: @aset 0 0 0 0 aset 0 0 0 0
// Retrieval info: CONNECT: @data 0 0 1 0 data 0 0 0 0
// Retrieval info: LIBRARY: lpm lpm.lpm_components.all
// Retrieval info: GEN_FILE: TYPE_NORMAL dff_sr.v TRUE
// Retrieval info: GEN_FILE: TYPE_NORMAL dff_sr.inc FALSE
// Retrieval info: GEN_FILE: TYPE_NORMAL dff_sr.cmp FALSE
// Retrieval info: GEN_FILE: TYPE_NORMAL dff_sr.bsf FALSE
// Retrieval info: GEN_FILE: TYPE_NORMAL dff_sr_inst.v FALSE
// Retrieval info: GEN_FILE: TYPE_NORMAL dff_sr_bb.v FALSE
// Retrieval info: LIB_FILE: lpm
`endif

`else

`ifdef DFF_SR
`define MODULE dff_sr
module `BASE`MODULE ( aclr, aset, clock, data, q);
`undef MODULE

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
`endif

`endif

// LATCH
// For targtes not supporting LATCH use dff_sr with clk=1 and data=1
`ifdef ALTERA

`ifdef LATCH
`define MODULE latch
module `BASE`MODULE ( d, le, q, clk);
`undef MODULE
input d, le;
output q;
input clk;
dff_sr i0 (.aclr(), .aset(), .clock(1'b1), .data(1'b1), .q(q));
endmodule
`endif

`else

`ifdef LATCH
`define MODULE latch
module `BASE`MODULE ( d, le, q, clk);
`undef MODULE
input d, le;
input clk;
always @ (le or d)
if (le)
    d <= q;
endmodule
`endif

`endif

`ifdef SHREG
`define MODULE shreg
module `BASE`MODULE ( d, q, clk, rst);
`undef MODULE

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
`endif

`ifdef SHREG_CE
`define MODULE shreg_ce
module `BASE`MODULE ( d, ce, q, clk, rst);
`undef MODULE
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
`endif

`ifdef DELAY
`define MODULE delay
module `BASE`MODULE ( d, q, clk, rst);
`undef MODULE
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
`endif

`ifdef DELAY_EMPTYFLAG
`define MODULE delay_emptyflag
module `BASE`MODULE ( d, q, emptyflag, clk, rst);
`undef MODULE
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
`endif

`ifdef ASYNC_REG_REQ_ACK
`define MODULE async_reg_req_ack
module `BASE`MODULE ( d, q, req_i, req_o, ack_i, ack_o, clk_a, rst_a, clk_b, rst_b);
`undef MODULE
parameter data_width = 8;
input [data_width-1:0] d;
output [data_width-1:0] q;
input req_i;
output req_o;
input ack_i;
output ack_o;
input clk_a, rst_a, clk_b, rst_b;

reg [3:0] reqi; // 3: last req in clk_a, 2: input dff, 1-0: sync
wire rst;

always @ (posedge clk_a or rst_a)
if (rst_a)
    q <= {data_width{1'b0}};
else
    if (req_i)
        q <= d;
    
assign rst = ack_i | rst_a;
always @ (posedge clk_a or posedge rst)
if (rst)
    req[2] <= 1'b0;
else
    req[2] <= req_i & !ack_o;

always @ (posedge clk_a or posedge rst_a)
if (rst_a)
    req[3] <= 1'b0;
else
    req[3] <= req[2];

always @ (posedge clk_b or posedge rst_b)
if (rst_b)
    req[1:0] <= 2'b00;
else
    if (ack_i)
        req[1:0] <= 2'b00;
    else
        req[1:0] <= req[2:1];
assign req_o = req[0];

always @ (posedge clk_a or posedge rst_a)
if (rst_a)
    ack_o <= 1'b0;
else
    ack_o <= req[3] & req[2];

endmodule
`endif
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
`ifdef MUX_ANDOR
`define MODULE mux_andor
module `BASE`MODULE ( a, sel, dout);
`undef MODULE

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
`endif

`ifdef MUX2_ANDOR
`define MODULE mux2_andor
module `BASE`MODULE ( a1, a0, sel, dout);
`undef MODULE

parameter width = 32;
localparam nr_of_ports = 2;
input [width-1:0] a1, a0;
input [nr_of_ports-1:0] sel;
output [width-1:0] dout;

`define MODULE mux_andor
`BASE`MODULE
    # ( .width(width), .nr_of_ports(nr_of_ports))
    mux0( .a({a1,a0}), .sel(sel), .dout(dout));
`undef MODULE

endmodule
`endif

`ifdef MUX3_ANDOR
`define MODULE mux3_andor
module `BASE`MODULE ( a2, a1, a0, sel, dout);
`undef MODULE

parameter width = 32;
localparam nr_of_ports = 3;
input [width-1:0] a2, a1, a0;
input [nr_of_ports-1:0] sel;
output [width-1:0] dout;

`define MODULE mux_andor
`BASE`MODULE
    # ( .width(width), .nr_of_ports(nr_of_ports))
    mux0( .a({a2,a1,a0}), .sel(sel), .dout(dout));
`undef MODULE    
endmodule
`endif

`ifdef MUX4_ANDOR
`define MODULE mux4_andor
module `BASE`MODULE ( a3, a2, a1, a0, sel, dout);
`undef MODULE

parameter width = 32;
localparam nr_of_ports = 4;
input [width-1:0] a3, a2, a1, a0;
input [nr_of_ports-1:0] sel;
output [width-1:0] dout;

`define MODULE mux_andor
`BASE`MODULE
    # ( .width(width), .nr_of_ports(nr_of_ports))
    mux0( .a({a3,a2,a1,a0}), .sel(sel), .dout(dout));
`undef MODULE

endmodule
`endif

`ifdef MUX5_ANDOR
`define MODULE mux5_andor
module `BASE`MODULE ( a4, a3, a2, a1, a0, sel, dout);
`undef MODULE

parameter width = 32;
localparam nr_of_ports = 5;
input [width-1:0] a4, a3, a2, a1, a0;
input [nr_of_ports-1:0] sel;
output [width-1:0] dout;

`define MODULE mux_andor
`BASE`MODULE
    # ( .width(width), .nr_of_ports(nr_of_ports))
    mux0( .a({a4,a3,a2,a1,a0}), .sel(sel), .dout(dout));
`undef MODULE

endmodule
`endif

`ifdef MUX6_ANDOR
`define MODULE mux6_andor
module `BASE`MODULE ( a5, a4, a3, a2, a1, a0, sel, dout);
`undef MODULE

parameter width = 32;
localparam nr_of_ports = 6;
input [width-1:0] a5, a4, a3, a2, a1, a0;
input [nr_of_ports-1:0] sel;
output [width-1:0] dout;

`define MODULE mux_andor
`BASE`MODULE
    # ( .width(width), .nr_of_ports(nr_of_ports))
    mux0( .a({a5,a4,a3,a2,a1,a0}), .sel(sel), .dout(dout));
`undef MODULE

endmodule
`endif

`ifdef PARITY

`define MODULE parity_generate
module `BASE`MODULE (data, parity);
`undef MODULE
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

`define MODULE parity_check
module `BASE`MODULE( data, parity, parity_error);
`undef MODULE
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

`endif//////////////////////////////////////////////////////////////////////
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
`ifdef O_DFF
`define MODULE o_dff
module `BASE`MODULE (d_i, o_pad, clk, rst);
`undef MODULE
parameter width = 1;
parameter reset_value = {width{1'b0}};
input  [width-1:0]  d_i;
output [width-1:0] o_pad;
input clk, rst;
wire [width-1:0] d_i_int `SYN_KEEP;
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
`endif

`timescale 1ns/1ns
`ifdef IO_DFF_OE
`define MODULE io_dff_oe
module `BASE`MODULE ( d_i, d_o, oe, io_pad, clk, rst);
`undef MODULE
parameter width = 1;
input  [width-1:0] d_o;
output reg [width-1:0] d_i;
input oe;
inout [width-1:0] io_pad;
input clk, rst;
wire [width-1:0] oe_d `SYN_KEEP;
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
`endif
`ifdef CNT_BIN
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

`define MODULE cnt_bin
module `BASE`MODULE (
`undef MODULE
 q, rst, clk);

   parameter length = 4;
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
       qi <= q_next;

   assign q = qi;

endmodule
`endif
`ifdef CNT_BIN_CLEAR
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

`define MODULE cnt_bin_clear
module `BASE`MODULE (
`undef MODULE
 clear, q, rst, clk);

   parameter length = 4;
   input clear;
   output [length:1] q;
   input rst;
   input clk;

   parameter clear_value = 0;
   parameter set_value = 1;
   parameter wrap_value = 0;
   parameter level1_value = 15;

   reg  [length:1] qi;
   wire [length:1] q_next;
   assign q_next =  clear ? {length{1'b0}} :qi + {{length-1{1'b0}},1'b1};

   always @ (posedge clk or posedge rst)
     if (rst)
       qi <= {length{1'b0}};
     else
       qi <= q_next;

   assign q = qi;

endmodule
`endif
`ifdef CNT_BIN_CE
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

`define MODULE cnt_bin_ce
module `BASE`MODULE (
`undef MODULE
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
`endif
`ifdef CNT_BIN_CE_CLEAR
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

`define MODULE cnt_bin_ce_clear
module `BASE`MODULE (
`undef MODULE
 clear, cke, q, rst, clk);

   parameter length = 4;
   input clear;
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
   assign q_next =  clear ? {length{1'b0}} :qi + {{length-1{1'b0}},1'b1};

   always @ (posedge clk or posedge rst)
     if (rst)
       qi <= {length{1'b0}};
     else
     if (cke)
       qi <= q_next;

   assign q = qi;

endmodule
`endif
`ifdef CNT_BIN_CE_CLEAR_L1_L2
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

`define MODULE cnt_bin_ce_clear_l1_l2
module `BASE`MODULE (
`undef MODULE
 clear, cke, q, level1, level2, rst, clk);

   parameter length = 4;
   input clear;
   input cke;
   output [length:1] q;
   output reg level1;
   output reg level2;
   input rst;
   input clk;

   parameter clear_value = 0;
   parameter set_value = 1;
   parameter wrap_value = 15;
   parameter level1_value = 8;
   parameter level2_value = 15;

   wire rew;
   assign rew = 1'b0;
   reg  [length:1] qi;
   wire [length:1] q_next;
   assign q_next =  clear ? {length{1'b0}} :qi + {{length-1{1'b0}},1'b1};

   always @ (posedge clk or posedge rst)
     if (rst)
       qi <= {length{1'b0}};
     else
     if (cke)
       qi <= q_next;

   assign q = qi;


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

    always @ (posedge clk or posedge rst)
    if (rst)
        level2 <= 1'b0;
    else
    if (cke)
    if (clear)
        level2 <= 1'b0;
    else if (q_next == level2_value)
        level2 <= 1'b1;
    else if (qi == level2_value & rew)
        level2 <= 1'b0;
endmodule
`endif
`ifdef CNT_BIN_CE_CLEAR_SET_REW
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

`define MODULE cnt_bin_ce_clear_set_rew
module `BASE`MODULE (
`undef MODULE
 clear, set, cke, rew, q, rst, clk);

   parameter length = 4;
   input clear;
   input set;
   input cke;
   input rew;
   output [length:1] q;
   input rst;
   input clk;

   parameter clear_value = 0;
   parameter set_value = 1;
   parameter wrap_value = 0;
   parameter level1_value = 15;

   reg  [length:1] qi;
   wire  [length:1] q_next, q_next_fw, q_next_rew;
   assign q_next_fw  =  clear ? {length{1'b0}} : set ? set_value :qi + {{length-1{1'b0}},1'b1};
   assign q_next_rew =  clear ? clear_value : set ? set_value :qi - {{length-1{1'b0}},1'b1};
   assign q_next = rew ? q_next_rew : q_next_fw;

   always @ (posedge clk or posedge rst)
     if (rst)
       qi <= {length{1'b0}};
     else
     if (cke)
       qi <= q_next;

   assign q = qi;

endmodule
`endif
`ifdef CNT_BIN_CE_REW_L1
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

`define MODULE cnt_bin_ce_rew_l1
module `BASE`MODULE (
`undef MODULE
 cke, rew, level1, rst, clk);

   parameter length = 4;
   input cke;
   input rew;
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
`endif
`ifdef CNT_BIN_CE_REW_ZQ_L1
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

`define MODULE cnt_bin_ce_rew_zq_l1
module `BASE`MODULE (
`undef MODULE
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
`endif
`ifdef CNT_BIN_CE_REW_Q_ZQ_L1
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

`define MODULE cnt_bin_ce_rew_q_zq_l1
module `BASE`MODULE (
`undef MODULE
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
`endif
`ifdef CNT_LFSR_ZQ
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

`define MODULE cnt_lfsr_zq
module `BASE`MODULE (
`undef MODULE
 zq, rst, clk);

   parameter length = 4;
   output reg zq;
   input rst;
   input clk;

   parameter clear_value = 0;
   parameter set_value = 1;
   parameter wrap_value = 8;
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
       qi <= q_next;



   always @ (posedge clk or posedge rst)
     if (rst)
       zq <= 1'b1;
     else
       zq <= q_next == {length{1'b0}};
endmodule
`endif
`ifdef CNT_LFSR_CE
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

`define MODULE cnt_lfsr_ce
module `BASE`MODULE (
`undef MODULE
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
`endif
`ifdef CNT_LFSR_CE_ZQ
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

`define MODULE cnt_lfsr_ce_zq
module `BASE`MODULE (
`undef MODULE
 cke, zq, rst, clk);

   parameter length = 4;
   input cke;
   output reg zq;
   input rst;
   input clk;

   parameter clear_value = 0;
   parameter set_value = 1;
   parameter wrap_value = 8;
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
`endif
`ifdef CNT_LFSR_CE_Q
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

`define MODULE cnt_lfsr_ce_q
module `BASE`MODULE (
`undef MODULE
 cke, q, rst, clk);

   parameter length = 4;
   input cke;
   output [length:1] q;
   input rst;
   input clk;

   parameter clear_value = 0;
   parameter set_value = 1;
   parameter wrap_value = 8;
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

   assign q = qi;

endmodule
`endif
`ifdef CNT_LFSR_CE_CLEAR_Q
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

`define MODULE cnt_lfsr_ce_clear_q
module `BASE`MODULE (
`undef MODULE
 clear, cke, q, rst, clk);

   parameter length = 4;
   input clear;
   input cke;
   output [length:1] q;
   input rst;
   input clk;

   parameter clear_value = 0;
   parameter set_value = 1;
   parameter wrap_value = 8;
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
   assign q_next =  clear ? {length{1'b0}} :(qi == wrap_value) ? {length{1'b0}} :{qi[length-1:1],lfsr_fb};

   always @ (posedge clk or posedge rst)
     if (rst)
       qi <= {length{1'b0}};
     else
     if (cke)
       qi <= q_next;

   assign q = qi;

endmodule
`endif
`ifdef CNT_LFSR_CE_Q_ZQ
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

`define MODULE cnt_lfsr_ce_q_zq
module `BASE`MODULE (
`undef MODULE
 cke, q, zq, rst, clk);

   parameter length = 4;
   input cke;
   output [length:1] q;
   output reg zq;
   input rst;
   input clk;

   parameter clear_value = 0;
   parameter set_value = 1;
   parameter wrap_value = 8;
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

   assign q = qi;


   always @ (posedge clk or posedge rst)
     if (rst)
       zq <= 1'b1;
     else
     if (cke)
       zq <= q_next == {length{1'b0}};
endmodule
`endif
`ifdef CNT_LFSR_CE_REW_L1
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

`define MODULE cnt_lfsr_ce_rew_l1
module `BASE`MODULE (
`undef MODULE
 cke, rew, level1, rst, clk);

   parameter length = 4;
   input cke;
   input rew;
   output reg level1;
   input rst;
   input clk;

   parameter clear_value = 0;
   parameter set_value = 1;
   parameter wrap_value = 8;
   parameter level1_value = 15;

   wire clear;
   assign clear = 1'b0;
   reg  [length:1] qi;
   reg lfsr_fb, lfsr_fb_rew;
   wire  [length:1] q_next, q_next_fw, q_next_rew;
   reg [32:1] polynom_rew;
   integer j;
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
   assign q_next_fw  = (qi == wrap_value) ? {length{1'b0}} :{qi[length-1:1],lfsr_fb};
   always @ (qi)
   begin
        case (length) 
         2: polynom_rew = 32'b11;
         3: polynom_rew = 32'b110;
         4: polynom_rew = 32'b1100;
         5: polynom_rew = 32'b10100;
         6: polynom_rew = 32'b110000;
         7: polynom_rew = 32'b1100000;
         8: polynom_rew = 32'b10111000;
         9: polynom_rew = 32'b100010000;
        10: polynom_rew = 32'b1001000000;
        11: polynom_rew = 32'b10100000000;
        12: polynom_rew = 32'b100000101001;
        13: polynom_rew = 32'b1000000001100;
        14: polynom_rew = 32'b10000000010101;
        15: polynom_rew = 32'b110000000000000;
        16: polynom_rew = 32'b1101000000001000;
        17: polynom_rew = 32'b10010000000000000;
        18: polynom_rew = 32'b100000010000000000;
        19: polynom_rew = 32'b1000000000000100011;
        20: polynom_rew = 32'b10000010000000000000;
        21: polynom_rew = 32'b101000000000000000000;
        22: polynom_rew = 32'b1100000000000000000000;
        23: polynom_rew = 32'b10000100000000000000000;
        24: polynom_rew = 32'b111000010000000000000000;
        25: polynom_rew = 32'b1001000000000000000000000;
        26: polynom_rew = 32'b10000000000000000000100011;
        27: polynom_rew = 32'b100000000000000000000010011;
        28: polynom_rew = 32'b1100100000000000000000000000;
        29: polynom_rew = 32'b10100000000000000000000000000;
        30: polynom_rew = 32'b100000000000000000000000101001;
        31: polynom_rew = 32'b1001000000000000000000000000000;
        32: polynom_rew = 32'b10000000001000000000000000000011;
        default: polynom_rew = 32'b0;
        endcase
        // rotate left
        polynom_rew[length:1] = { polynom_rew[length-2:1],polynom_rew[length] };
        lfsr_fb_rew = qi[length];
        for (i=length-1; i>=1; i=i-1) begin
            if (polynom_rew[i])
                lfsr_fb_rew = lfsr_fb_rew  ~^ qi[i];
        end
    end
   assign q_next_rew = (qi == wrap_value) ? {length{1'b0}} :{lfsr_fb_rew,qi[length:2]};
   assign q_next = rew ? q_next_rew : q_next_fw;

   always @ (posedge clk or posedge rst)
     if (rst)
       qi <= {length{1'b0}};
     else
     if (cke)
       qi <= q_next;



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
`endif
`ifdef CNT_GRAY
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

`define MODULE cnt_gray
module `BASE`MODULE (
`undef MODULE
 q, rst, clk);

   parameter length = 4;
   output reg [length:1] q;
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
       qi <= q_next;

   always @ (posedge clk or posedge rst)
     if (rst)
       q <= {length{1'b0}};
     else
         q <= (q_next>>1) ^ q_next;

endmodule
`endif
`ifdef CNT_GRAY_CE
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

`define MODULE cnt_gray_ce
module `BASE`MODULE (
`undef MODULE
 cke, q, rst, clk);

   parameter length = 4;
   input cke;
   output reg [length:1] q;
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

endmodule
`endif
`ifdef CNT_GRAY_CE_BIN
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

`define MODULE cnt_gray_ce_bin
module `BASE`MODULE (
`undef MODULE
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
`endif
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

`ifdef CNT_SHREG_WRAP
`define MODULE cnt_shreg_wrap
module `BASE`MODULE ( q, rst, clk);
`undef MODULE

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
`endif

`ifdef CNT_SHREG_CE_WRAP
`define MODULE cnt_shreg_ce_wrap
module `BASE`MODULE ( cke, q, rst, clk);
`undef MODULE

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
`endif

`ifdef CNT_SHREG_CE_CLEAR
`define MODULE cnt_shreg_ce_clear
module `BASE`MODULE ( cke, clear, q, rst, clk);
`undef MODULE

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
`endif

`ifdef CNT_SHREG_CE_CLEAR_WRAP
`define MODULE cnt_shreg_ce_clear_wrap
module `BASE`MODULE ( cke, clear, q, rst, clk);
`undef MODULE

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
`endif
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

`ifdef ROM_INIT
/// ROM
`define MODULE rom_init
module `BASE`MODULE ( adr, q, clk);
`undef MODULE

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
`endif

`ifdef RAM
`define MODULE ram
// Single port RAM
module `BASE`MODULE ( d, adr, we, q, clk);
`undef MODULE

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
`endif

`ifdef RAM_BE
`define MODULE ram_be
module `BASE`MODULE ( d, adr, be, we, q, clk);
`undef MODULE

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
        if(be[3]) ram[adr[addr_width-2:0]][3] <= d[31:24];
        if(be[2]) ram[adr[addr_width-2:0]][2] <= d[23:16];
        if(be[1]) ram[adr[addr_width-2:0]][1] <= d[15:8];
        if(be[0]) ram[adr[addr_width-2:0]][0] <= d[7:0];
    end
    q <= ram[adr];
end

`else

   genvar i;
   generate for (i=0;i<addr_width/4;i=i+1) begin : be_ram
      always @ (posedge clk)
      if (we & be[i])
        ram[adr][(i+1)*8-1:i*8] <= d[(i+1)*8-1:i*8];
   end
   endgenerate

   always @ (posedge clk)
      q <= ram[adr];

`endif

endmodule
`endif

`ifdef ACTEL
        // ACTEL FPGA should not use logic to handle rw collision
	`define SYN /*synthesis syn_ramstyle = "no_rw_check"*/
`else
        `define SYN 
`endif

`ifdef DPRAM_1R1W
`define MODULE dpram_1r1w
module `BASE`MODULE ( d_a, adr_a, we_a, clk_a, q_b, adr_b, clk_b );
`undef MODULE
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
   reg [data_width-1:0] ram [mem_szie-1:0] `SYN;

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
`endif

`ifdef DPRAM_2R1W
`define MODULE dpram_2r1w
module `BASE`MODULE ( d_a, q_a, adr_a, we_a, clk_a, q_b, adr_b, clk_b );
`undef MODULE

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
   reg [data_width-1:0] ram [mem_szie-1:0] `SYN;

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
`endif

`ifdef DPRAM_2R2W
`define MODULE dpram_2r2w
module `BASE`MODULE ( d_a, q_a, adr_a, we_a, clk_a, d_b, q_b, adr_b, we_b, clk_b );
`undef MODULE

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
   reg [data_width-1:0] ram [mem_size-1:0] `SYN;

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
`endif

`ifdef DPRAM_BE_2R2W
`define MODULE dpram_be_2r2w
module `BASE`MODULE ( d_a, q_a, adr_a, be_a, we_a, clk_a, d_b, q_b, adr_b, be_b, we_b, clk_b );
`undef MODULE

   parameter a_data_width = 32;
   parameter a_addr_width = 8;
   parameter b_data_width = 64;
   parameter b_addr_width = 7;
   //parameter mem_size = (a_addr_width>b_addr_width) ? (1<<a_addr_width) : (1<<b_addr_width);
   parameter mem_size = 1024;
   input [(a_data_width-1):0]      d_a;
   input [(a_addr_width-1):0] 	 adr_a;
   input [(b_addr_width-1):0] 	 adr_b;
   input [(a_data_width/4-1):0]    be_a;
   input 			 we_a;
   output [(b_data_width-1):0] 	 q_b;
   input [(b_data_width-1):0] 	 d_b;
   output reg [(a_data_width-1):0] q_a;
   input [(b_data_width/4-1):0]    be_b;
   input 			 we_b;
   input 			 clk_a, clk_b;
   reg [(b_data_width-1):0] 	 q_b;   

generate
if (a_data_width==32 & b_data_width==64) begin : inst32to64

    wire [63:0] tmp;
    `define MODULE dpram_2r2w
    `BASE`MODULE
    # (.data_width(8), .addr_width(b_addr_width-3))
    ram0 (
        .d_a(d_a[7:0]),
        .q_a(tmp[7:0]),
        .adr_a(adr_a[a_addr_width-3-1:0]),
        .we_a(we_a & be_a[0] & !adr_a[0]),
        .clk_a(clk_a),
        .d_b(d_b[7:0]),
        .q_b(q_b[7:0]),
        .adr_b(adr_b[b_addr_width-3-1:0]),
        .we_b(we_b),
        .clk_b(clk_b) );
    `BASE`MODULE
    # (.data_width(8), .addr_width(b_addr_width-3))
    ram1 (
        .d_a(d_a[7:0]),
        .q_a(tmp[7:0]),
        .adr_a(adr_a[a_addr_width-3-1:0]),
        .we_a(we_a),
        .clk_a(clk_a),
        .d_b(d_b[7:0]),
        .q_b(q_b[7:0]),
        .adr_b(adr_b[b_addr_width-3-1:0]),
        .we_b(we_b),
        .clk_b(clk_b) );
    `BASE`MODULE
    # (.data_width(8), .addr_width(b_addr_width-3))
    ram2 (
        .d_a(d_a[15:8]),
        .q_a(tmp[7:0]),
        .adr_a(adr_a[a_addr_width-3-1:0]),
        .we_a(we_a),
        .clk_a(clk_a),
        .d_b(d_b[7:0]),
        .q_b(q_b[7:0]),
        .adr_b(adr_b[b_addr_width-3-1:0]),
        .we_b(we_b),
        .clk_b(clk_b) );
    `BASE`MODULE
    # (.data_width(8), .addr_width(b_addr_width-3))
    ram3 (
        .d_a(d_a[15:8]),
        .q_a(tmp[7:0]),
        .adr_a(adr_a[a_addr_width-3-1:0]),
        .we_a(we_a),
        .clk_a(clk_a),
        .d_b(d_b[7:0]),
        .q_b(q_b[7:0]),
        .adr_b(adr_b[b_addr_width-3-1:0]),
        .we_b(we_b),
        .clk_b(clk_b) );
    `BASE`MODULE
    # (.data_width(8), .addr_width(b_addr_width-3))
    ram4 (
        .d_a(d_a[23:16]),
        .q_a(tmp[7:0]),
        .adr_a(adr_a[a_addr_width-3-1:0]),
        .we_a(we_a),
        .clk_a(clk_a),
        .d_b(d_b[7:0]),
        .q_b(q_b[7:0]),
        .adr_b(adr_b[b_addr_width-3-1:0]),
        .we_b(we_b),
        .clk_b(clk_b) );
    `BASE`MODULE
    # (.data_width(8), .addr_width(b_addr_width-3))
    ram5 (
        .d_a(d_a[23:16]),
        .q_a(tmp[7:0]),
        .adr_a(adr_a[a_addr_width-3-1:0]),
        .we_a(we_a),
        .clk_a(clk_a),
        .d_b(d_b[7:0]),
        .q_b(q_b[7:0]),
        .adr_b(adr_b[b_addr_width-3-1:0]),
        .we_b(we_b),
        .clk_b(clk_b) );
    `BASE`MODULE
    # (.data_width(8), .addr_width(b_addr_width-3))
    ram6 (
        .d_a(d_a[31:24]),
        .q_a(tmp[7:0]),
        .adr_a(adr_a[a_addr_width-3-1:0]),
        .we_a(we_a),
        .clk_a(clk_a),
        .d_b(d_b[7:0]),
        .q_b(q_b[7:0]),
        .adr_b(adr_b[b_addr_width-3-1:0]),
        .we_b(we_b),
        .clk_b(clk_b) );
    `BASE`MODULE
    # (.data_width(8), .addr_width(b_addr_width-3))
    ram7 (
        .d_a(d_a[31:24]),
        .q_a(tmp[7:0]),
        .adr_a(adr_a[a_addr_width-3-1:0]),
        .we_a(we_a),
        .clk_a(clk_a),
        .d_b(d_b[7:0]),
        .q_b(q_b[7:0]),
        .adr_b(adr_b[b_addr_width-3-1:0]),
        .we_b(we_b),
        .clk_b(clk_b) );
`undef MODULE
/*
   reg [7:0] ram0 [mem_size/8-1:0];
   wire [7:0] wea, web;
   assign wea = we_a & be_a[0];
   assign web = we_b & be_b[0];
   always @ (posedge clk_a)
    if (wea)
        ram0[adr_a] <= d_a[7:0];
    always @ (posedge clk_a)
        q_a[7:0] <= ram0[adr_a];
   always @ (posedge clk_a)
    if (web)
        ram0[adr_b] <= d_b[7:0];
    always @ (posedge clk_b)
        q_b[7:0] <= ram0[adr_b];
*/
end
endgenerate
/*
   generate for (i=0;i<addr_width/4;i=i+1) begin : be_rama
      always @ (posedge clk_a)
      if (we_a & be_a[i])
        ram[adr_a][(i+1)*8-1:i*8] <= d_a[(i+1)*8-1:i*8];
   end
   endgenerate

   always @ (posedge clk_a)
      q_a <= ram[adr_a];

   genvar i;
   generate for (i=0;i<addr_width/4;i=i+1) begin : be_ramb
      always @ (posedge clk_a)
      if (we_b & be_b[i])
        ram[adr_b][(i+1)*8-1:i*8] <= d_b[(i+1)*8-1:i*8];
   end
   endgenerate

   always @ (posedge clk_b)
      q_b <= ram[adr_b];
*/
/*
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
*/
endmodule
`endif

// Content addresable memory, CAM

`ifdef FIFO_1R1W_FILL_LEVEL_SYNC
// FIFO
`define MODULE fifo_1r1w_fill_level_sync
module `BASE`MODULE (
`undef MODULE
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

`define MODULE cnt_bin_ce
`BASE`MODULE
    # ( .length(addr_width))
    fifo_wr_adr( .cke(wr), .q(wadr), .rst(rst), .clk(clk));
`BASE`MODULE
    # (.length(addr_width))
    fifo_rd_adr( .cke(rd), .q(radr), .rst(rst), .clk(clk));
`undef MODULE

`define MODULE dpram_1r1w
`BASE`MODULE
    # (.data_width(data_width), .addr_width(addr_width))
    dpram ( .d_a(d), .adr_a(wadr), .we_a(wr), .clk_a(clk), .q_b(q), .adr_b(radr), .clk_b(clk));
`undef MODULE

`define MODULE cnt_bin_ce_rew_q_zq_l1
`BASE`MODULE
    # (.length(addr_width+1), .level1_value(1<<addr_width))
    fill_level_cnt( .cke(rd ^ wr), .rew(rd), .q(fill_level), .zq(fifo_empty), .level1(fifo_full), .rst(rst), .clk(clk));
`undef MODULE
endmodule
`endif

`ifdef FIFO_2R2W_SYNC_SIMPLEX
// Intended use is two small FIFOs (RX and TX typically) in one FPGA RAM resource
// RAM is supposed to be larger than the two FIFOs
// LFSR counters used adr pointers
`define MODULE fifo_2r2w_sync_simplex
module `BASE`MODULE (
`undef MODULE
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

`define MODULE cnt_lfsr_ce
`BASE`MODULE
    # ( .length(addr_width))
    fifo_a_wr_adr( .cke(a_wr), .q(a_wadr), .rst(rst), .clk(clk));
    
`BASE`MODULE
    # (.length(addr_width))
    fifo_a_rd_adr( .cke(a_rd), .q(a_radr), .rst(rst), .clk(clk));

`BASE`MODULE
    # ( .length(addr_width))
    fifo_b_wr_adr( .cke(b_wr), .q(b_wadr), .rst(rst), .clk(clk));
    
`BASE`MODULE
    # (.length(addr_width))
    fifo_b_rd_adr( .cke(b_rd), .q(b_radr), .rst(rst), .clk(clk));
`undef MODULE

// mux read or write adr to DPRAM
assign a_dpram_adr = (a_wr) ? {1'b0,a_wadr} : {1'b1,a_radr};
assign b_dpram_adr = (b_wr) ? {1'b1,b_wadr} : {1'b0,b_radr};

`define MODULE dpram_2r2w
`BASE`MODULE
    # (.data_width(data_width), .addr_width(addr_width+1))
    dpram ( .d_a(a_d), .q_a(a_q), .adr_a(a_dpram_adr), .we_a(a_wr), .clk_a(a_clk), 
            .d_b(b_d), .q_b(b_q), .adr_b(b_dpram_adr), .we_b(b_wr), .clk_b(b_clk));
`undef MODULE

`define MODULE cnt_bin_ce_rew_zq_l1
`BASE`MODULE
    # (.length(addr_width), .level1_value(fifo_full_level))
    a_fill_level_cnt( .cke(a_rd ^ a_wr), .rew(a_rd), .q(a_fill_level), .zq(a_fifo_empty), .level1(a_fifo_full), .rst(rst), .clk(clk));

`BASE`MODULE
    # (.length(addr_width), .level1_value(fifo_full_level))
    b_fill_level_cnt( .cke(b_rd ^ b_wr), .rew(b_rd), .q(b_fill_level), .zq(b_fifo_empty), .level1(b_fifo_full), .rst(rst), .clk(clk));
`undef MODULE

endmodule
`endif

`ifdef FIFO_CMP_ASYNC
`define MODULE fifo_cmp_async
module `BASE`MODULE ( wptr, rptr, fifo_empty, fifo_full, wclk, rclk, rst );
`undef MODULE

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

`define MODULE dff_sr
`ifndef GENERATE_DIRECTION_AS_LATCH
    `BASE`MODULE dff_sr_dir( .aclr(direction_clr), .aset(direction_set), .clock(1'b1), .data(1'b1), .q(direction));
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

    `BASE`MODULE dff_sr_empty0( .aclr(rst), .aset(async_full), .clock(wclk), .data(async_full), .q(fifo_full2));
    `BASE`MODULE dff_sr_empty1( .aclr(rst), .aset(async_full), .clock(wclk), .data(fifo_full2), .q(fifo_full));
`undef MODULE

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
`define MODULE dff
    `BASE`MODULE # ( .reset_value(1'b1)) dff0 ( .d(async_empty), .q(fifo_empty2), .clk(rclk), .rst(async_empty));
    `BASE`MODULE # ( .reset_value(1'b1)) dff1 ( .d(fifo_empty2), .q(fifo_empty),  .clk(rclk), .rst(async_empty));
`undef MODULE
endmodule // async_compb
`endif

`ifdef FIFO_1R1W_ASYNC
`define MODULE fifo_1r1w_async
module `BASE`MODULE (
`undef MODULE
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

`define MODULE cnt_gray_ce_bin
`BASE`MODULE
    # ( .length(addr_width))
    fifo_wr_adr( .cke(wr), .q(wadr), .q_bin(wadr_bin), .rst(wr_rst), .clk(wr_clk));
    
`BASE`MODULE
    # (.length(addr_width))
    fifo_rd_adr( .cke(rd), .q(radr), .q_bin(radr_bin), .rst(rd_rst), .clk(rd_clk));
`undef MODULE

`define MODULE dpram_1r1w
`BASE`MODULE
    # (.data_width(data_width), .addr_width(addr_width))
    dpram ( .d_a(d), .adr_a(wadr_bin), .we_a(wr), .clk_a(wr_clk), .q_b(q), .adr_b(radr_bin), .clk_b(rd_clk));
`undef MODULE

`define MODULE fifo_cmp_async
`BASE`MODULE
    # (.addr_width(addr_width))
    cmp ( .wptr(wadr), .rptr(radr), .fifo_empty(fifo_empty), .fifo_full(fifo_full), .wclk(wr_clk), .rclk(rd_clk), .rst(wr_rst) );
`undef MODULE

endmodule
`endif

`ifdef FIFO_2R2W_ASYNC
`define MODULE fifo_2r2w_async
module `BASE`MODULE (
`undef MODULE
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

`define MODULE fifo_1r1w_async
`BASE`MODULE # (.data_width(data_width), .addr_width(addr_width))
vl_fifo_1r1w_async_a (
    .d(a_d), .wr(a_wr), .fifo_full(a_fifo_full), .wr_clk(a_clk), .wr_rst(a_rst),
    .q(b_q), .rd(b_rd), .fifo_empty(b_fifo_empty), .rd_clk(b_clk), .rd_rst(b_rst)
    );

`BASE`MODULE # (.data_width(data_width), .addr_width(addr_width))
vl_fifo_1r1w_async_b (
    .d(b_d), .wr(b_wr), .fifo_full(b_fifo_full), .wr_clk(b_clk), .wr_rst(b_rst),
    .q(a_q), .rd(a_rd), .fifo_empty(a_fifo_empty), .rd_clk(a_clk), .rd_rst(a_rst)
    );
`undef MODULE

endmodule
`endif

`ifdef FIFO_2R2W_ASYNC_SIMPLEX
`define MODULE fifo_2r2w_async_simplex
module `BASE`MODULE (
`undef MODULE
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

`define MODULE cnt_gray_ce_bin
`BASE`MODULE
    # ( .length(addr_width))
    fifo_a_wr_adr( .cke(a_wr), .q(a_wadr), .q_bin(a_wadr_bin), .rst(a_rst), .clk(a_clk));
    
`BASE`MODULE
    # (.length(addr_width))
    fifo_a_rd_adr( .cke(a_rd), .q(a_radr), .q_bin(a_radr_bin), .rst(a_rst), .clk(a_clk));

`BASE`MODULE
    # ( .length(addr_width))
    fifo_b_wr_adr( .cke(b_wr), .q(b_wadr), .q_bin(b_wadr_bin), .rst(b_rst), .clk(b_clk));
    
`BASE`MODULE
    # (.length(addr_width))
    fifo_b_rd_adr( .cke(b_rd), .q(b_radr), .q_bin(b_radr_bin), .rst(b_rst), .clk(b_clk));
`undef MODULE

// mux read or write adr to DPRAM
assign a_dpram_adr = (a_wr) ? {1'b0,a_wadr_bin} : {1'b1,a_radr_bin};
assign b_dpram_adr = (b_wr) ? {1'b1,b_wadr_bin} : {1'b0,b_radr_bin};

`define MODULE dpram_2r2w
`BASE`MODULE
    # (.data_width(data_width), .addr_width(addr_width+1))
    dpram ( .d_a(a_d), .q_a(a_q), .adr_a(a_dpram_adr), .we_a(a_wr), .clk_a(a_clk), 
            .d_b(b_d), .q_b(b_q), .adr_b(b_dpram_adr), .we_b(b_wr), .clk_b(b_clk));
`undef MODULE

`define MODULE fifo_cmp_async
`BASE`MODULE
    # (.addr_width(addr_width))
    cmp1 ( .wptr(a_wadr), .rptr(b_radr), .fifo_empty(b_fifo_empty), .fifo_full(a_fifo_full), .wclk(a_clk), .rclk(b_clk), .rst(a_rst) );

`BASE`MODULE
    # (.addr_width(addr_width))
    cmp2 ( .wptr(b_wadr), .rptr(a_radr), .fifo_empty(a_fifo_empty), .fifo_full(b_fifo_full), .wclk(b_clk), .rclk(a_clk), .rst(b_rst) );
`undef MODULE

endmodule
`endif

`ifdef REG_FILE
`define MODULE reg_file
module `BASE`MODULE (
`undef MODULE
    a1, a2, a3, wd3, we3, rd1, rd2, clk
);
parameter data_width = 32;
parameter addr_width = 5;
input [addr_width-1:0] a1, a2, a3;
input [data_width-1:0] wd3;
input we3;
output [data_width-1:0] rd1, rd2;
input clk;

`ifdef ACTEL
reg [data_width-1:0] wd3_reg;
reg [addr_width-1:0] a1_reg, a2_reg, a3_reg;
reg we3_reg;
reg [data_width-1:0] ram1 [(1<<addr_width)-1:0] `SYN;
reg [data_width-1:0] ram2 [(1<<addr_width)-1:0] `SYN;
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

`else

`define MODULE dpram_1r1w
`BASE`MODULE
    # ( .data_width(data_width), .addr_width(addr_width))
    ram1 (
        .d_a(wd3),
        .adr_a(a3),
        .we_a(we3),
        .clk_a(clk),
        .q_b(rd1),
        .adr_b(a1),
        .clk_b(clk) );
        
`BASE`MODULE
    # ( .data_width(data_width), .addr_width(addr_width))
    ram2 (
        .d_a(wd3),
        .adr_a(a3),
        .we_a(we3),
        .clk_a(clk),
        .q_b(rd2),
        .adr_b(a2),
        .clk_b(clk) );
`undef MODULE

`endif

endmodule
`endif
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
// async wb3 - wb3 bridge
`timescale 1ns/1ns
`define MODULE wb_adr_inc
module `BASE`MODULE ( 
`undef MODULE

    always @ (posedge clk or posedge rst)
	if (rst)
           col_reg <= {col_reg_width{1'b0}};
        else
            case (state)
	    `FSM_IDLE:
	       col_reg <= col[col_reg_width-1:0];
            `FSM_RW:
               if (~stall)
                  case (bte_i)
`ifdef SDR_BEAT4
                        beat4:  col_reg[2:0] <= col_reg[2:0] + 3'd1;
`endif
`ifdef SDR_BEAT8    
                        beat8:  col_reg[3:0] <= col_reg[3:0] + 4'd1;
`endif
`ifdef SDR_BEAT16   
                        beat16: col_reg[4:0] <= col_reg[4:0] + 5'd1;
`endif
                  endcase
            endcase
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

`define WE 5
`define BTE 4:3
`define CTI 2:0  

assign wbs_eoc_alert = (wbs_bte_reg==wrap4 & wbs_count[3]) | (wbs_bte_reg==wrap8 & wbs_count[7]) | (wbs_bte_reg==wrap16 & wbs_count[15]);
always @ (posedge wbs_clk or posedge wbs_rst)
if (wbs_rst)
	wbs_eoc <= 1'b0;
else
	if (wbs==wbs_adr & wbs_stb_i & !a_fifo_full)
		wbs_eoc <= (wbs_bte_i==linear) | (wbs_cti_==3'b111);
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

input [31:0] wbs_dat_i;
input [31:2] wbs_adr_i;
input [3:0]  wbs_sel_i;
input [1:0]  wbs_bte_i;
input [2:0]  wbs_cti_i;
input wbs_we_i, wbs_cyc_i, wbs_stb_i;
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

always @ (posedge clk or posedge rst)
if (rst)
    last_cyc <= 1'b0;
else
    last_cyc <= wbm_cyc_o;

assign beginbursttransfer = (!last_cyc & wbm_cyc_o) & wbm_cti_o==3'b010;
assign burstcount = (wbm_bte_o==2'b01) ? 4'd4 :
                    (wbm_bte_o==2'b10) ? 4'd8 :
                    4'd16;
assign write = wbm_cyc_o & wbm_stb_o &  wbm_we_o;
assign read  = wbm_cyc_o & wbm_stb_o & !wbm_we_o;
assign wbm_ack_i = (readdatavalid & !waitrequest) | (write & !waitrequest);

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
    .wbm_adr_o(adress),
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

`ifdef WB_B3_RAM_BE
// WB RAM with byte enable
`define MODULE wb_b3_ram_be
module `BASE`MODULE (
`undef MODULE
    wbs_dat_i, wbs_adr_i, wbs_cti_i, wbs_bte_i, wbs_sel_i, wbs_we_i, wbs_stb_i, wbs_cyc_i, 
    wbs_dat_o, wbs_ack_o, wb_clk, wb_rst);

parameter adr_size = 16;
parameter adr_lo   = 2;
parameter mem_size = 1<<16;
parameter dat_size = 32;
parameter memory_init = 1;
parameter memory_file = "vl_ram.vmem";

localparam aw = (adr_size - adr_lo);
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

wire [sw-1:0] cke;

reg wbs_ack_o;

`define MODULE ram_be
`BASE`MODULE # (
    .data_width(dat_size),
    .addr_width(adr_size-2),
    .mem_size(mem_size),
    .memory_init(memory_init),
    .memory_file(memory_file))
ram0(
`undef MODULE
    .d(wbs_dat_i),
    .adr(wbs_adr_i[adr_size-1:2]),
    .be(wbs_sel_i),
    .we(wbs_we_i),
    .q(wbs_dat_o),
    .clk(wb_clk)
);

always @ (posedge wb_clk or posedge wb_rst)
if (wb_rst)
    wbs_ack_o <= 1'b0;
else
    if (wbs_cti_i==3'b000 | wbs_cti_i==3'b111)
        wbs_ack_o <= wbs_stb_i & wbs_cyc_i & !wbs_ack_o;
    else
        wbs_ack_o <= wbs_stb_i & wbs_cyc_i;

endmodule
`endif

`ifdef WB_B4_RAM_BE
// WB RAM with byte enable
`define MODULE wb_b4_ram_be
module `BASE`MODULE (
`undef MODULE
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
`endif

`ifdef WB_DPRAM
`define MODULE wb_dpram
module `BASE`MODULE ( 
`undef MODULE
	// wishbone slave side a
	wbsa_dat_i, wbsa_adr_i, wbsa_we_i, wbsa_cyc_i, wbsa_stb_i, wbsa_dat_o, wbsa_ack_o,
        wbsa_clk, wbsa_rst,
	// wishbone slave side a
	wbsb_dat_i, wbsb_adr_i, wbsb_we_i, wbsb_cyc_i, wbsb_stb_i, wbsb_dat_o, wbsb_ack_o,
        wbsb_clk, wbsb_rst);

parameter data_width = 32;
parameter addr_width = 8;

parameter dat_o_mask_a = 1;
parameter dat_o_mask_b = 1;

input [31:0] wbsa_dat_i;
input [addr_width-1:2] wbsa_adr_i;
input wbsa_we_i, wbsa_cyc_i, wbsa_stb_i;
output [31:0] wbsa_dat_o;
output wbsa_ack_o;
input wbsa_clk, wbsa_rst;

input [31:0] wbsb_dat_i;
input [addr_width-1:2] wbsb_adr_i;
input wbsb_we_i, wbsb_cyc_i, wbsb_stb_i;
output [31:0] wbsb_dat_o;
output wbsb_ack_o;
input wbsb_clk, wbsb_rst;

wire wbsa_dat_tmp, wbsb_dat_tmp;

`define MODULE dpram_2r2w
`BASE`MODULE # (
`undef MODULE
    .data_width(data_width), .addr_width(addr_width) )
dpram0(
    .d_a(wbsa_dat_i),
    .q_a(wbsa_dat_tmp),
    .adr_a(wbsa_adr_i),
    .we_a(wbsa_we_i),
    .clk_a(wbsa_clk),
    .d_b(wbsb_dat_i),
    .q_b(wbsb_dat_tmp),
    .adr_b(wbsb_adr_i),
    .we_b(wbsb_we_i),
    .clk_b(wbsb_clk) );

generate if (dat_o_mask_a==1) 
    assign wbsa_dat_o = wbsa_dat_tmp & {data_width{wbsa_ack_o}};
endgenerate
generate if (dat_o_mask_a==0) 
    assign wbsa_dat_o = wbsa_dat_tmp;
endgenerate

generate if (dat_o_mask_b==1) 
    assign wbsb_dat_o = wbsb_dat_tmp & {data_width{wbsb_ack_o}};
endgenerate
generate if (dat_o_mask_b==0) 
    assign wbsb_dat_o = wbsb_dat_tmp;
endgenerate

`define MODULE spr
`BASE`MODULE ack_a( .sp(wbsa_cyc_i & wbsa_stb_i & !wbsa_ack_o), .r(1'b1), .q(wbsa_ack_o), .clk(wbsa_clk), .rst(wbsa_rst));
`BASE`MODULE ack_b( .sp(wbsb_cyc_i & wbsb_stb_i & !wbsb_ack_o), .r(1'b1), .q(wbsb_ack_o), .clk(wbsb_clk), .rst(wbsb_rst));
`undef MODULE

endmodule
`endif
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

`ifdef MULTS
// signed multiplication
`define MODULE mults
module `BASE`MODULE (a,b,p);
`undef MODULE
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
`endif
`ifdef MULTS18X18
`define MODULE mults18x18
module `BASE`MODULE (a,b,p);
`undef MODULE
input [17:0] a,b;
output [35:0] p;
vl_mult
    # (.operand_a_width(18), .operand_b_width(18))
    mult0 (.a(a), .b(b), .p(p));
endmodule
`endif

`ifdef MULT
`define MODULE mult
// unsigned multiplication
module `BASE`MODULE (a,b,p);
`undef MODULE
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
`endif

`ifdef SHIFT_UNIT_32
`define MODULE shift_unit_32
// shift unit
// supporting the following shift functions
//   SLL
//   SRL
//   SRA
`define SHIFT_UNIT_MULT # ( .operand_a_width(25), .operand_b_width(16), .result_hi(14), .result_lo(7))
module `BASE`MODULE( din, s, dout, opcode);
`undef MODULE
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
`define MODULE mults
`BASE`MODULE `SHIFT_UNIT_MULT mult_byte3 ( .a({sign[3], {8{sign[3]}},din[31:24], din[23:16]}), .b({1'b0,s1}), .p(tmp[3]));
`BASE`MODULE `SHIFT_UNIT_MULT mult_byte2 ( .a({sign[2], din[31:24]  ,din[23:16],  din[15:8]}), .b({1'b0,s1}), .p(tmp[2]));
`BASE`MODULE `SHIFT_UNIT_MULT mult_byte1 ( .a({sign[1], din[23:16]  ,din[15:8],   din[7:0]}), .b({1'b0,s1}), .p(tmp[1]));
`BASE`MODULE `SHIFT_UNIT_MULT mult_byte0 ( .a({sign[0], din[15:8]   ,din[7:0],    8'h00}),      .b({1'b0,s1}), .p(tmp[0]));
`undef MODULE
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
`endif

`ifdef LOGIC_UNIT
// logic unit
// supporting the following logic functions
//    a and b
//    a or  b
//    a xor b
//    not b
`define MODULE logic_unit
module `BASE`MODULE( a, b, result, opcode);
`undef MODULE
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
`endif

`ifdef ARITH_UNIT
`define MODULE arith_unit
module `BASE`MODULE ( a, b, c_in, add_sub, sign, result, c_out, z, ovfl);
`undef MODULE
parameter width = 32;
parameter opcode_add = 1'b0;
parameter opcode_sub = 1'b1;
input [width-1:0] a,b;
input c_in, add_sub, sign;
output [width-1:0] result;
output c_out, z, ovfl;

assign {c_out,result} = {(a[width-1] & sign),a} + ({a[width-1] & sign,b} ^ {(width+1){(add_sub==opcode_sub)}}) + {{(width-1){1'b0}},(c_in | (add_sub==opcode_sub))};
assign z = (result=={width{1'b0}});
assign ovfl = ( a[width-1] &  b[width-1] & ~result[width-1]) |
               (~a[width-1] & ~b[width-1] &  result[width-1]);
endmodule
`endif

`ifdef COUNT_UNIT
`define MODULE count_unit
module `BASE`MODULE (din, dout, opcode);
`undef MODULE
parameter width = 32;
input [width-1:0] din;
output [width-1:0] dout;
input opcode;

integer i;
wire [width/32+4:0] ff1, fl1;

/*
always @(din) begin
    ff1 = 0; i = 0;
    while (din[i] == 0 && i < width) begin // complex condition
        ff1 = ff1 + 1;
        i = i + 1;
    end
end

always @(din) begin
    fl1 = width; i = width-1;
    while (din[i] == 0 && i >= width) begin // complex condition
        fl1 = fl1 - 1;
        i = i - 1;
    end
end
*/

generate
if (width==32) begin

    assign ff1 = din[0] ? 6'd1 :
                 din[1] ? 6'd2 :
                 din[2] ? 6'd3 :
                 din[3] ? 6'd4 :
                 din[4] ? 6'd5 :
                 din[5] ? 6'd6 :
                 din[6] ? 6'd7 :
                 din[7] ? 6'd8 :
                 din[8] ? 6'd9 :
                 din[9] ? 6'd10 :
                 din[10] ? 6'd11 :
                 din[11] ? 6'd12 :
                 din[12] ? 6'd13 :
                 din[13] ? 6'd14 :
                 din[14] ? 6'd15 :
                 din[15] ? 6'd16 :
                 din[16] ? 6'd17 :
                 din[17] ? 6'd18 :
                 din[18] ? 6'd19 :
                 din[19] ? 6'd20 :
                 din[20] ? 6'd21 :
                 din[21] ? 6'd22 :
                 din[22] ? 6'd23 :
                 din[23] ? 6'd24 :
                 din[24] ? 6'd25 :
                 din[25] ? 6'd26 :
                 din[26] ? 6'd27 :
                 din[27] ? 6'd28 :
                 din[28] ? 6'd29 :
                 din[29] ? 6'd30 :
                 din[30] ? 6'd31 :
                 din[31] ? 6'd32 :
                 6'd0;

    assign fl1 = din[31] ? 6'd32 :
                 din[30] ? 6'd31 :
                 din[29] ? 6'd30 :
                 din[28] ? 6'd29 :
                 din[27] ? 6'd28 :
                 din[26] ? 6'd27 :
                 din[25] ? 6'd26 :
                 din[24] ? 6'd25 :
                 din[23] ? 6'd24 :
                 din[22] ? 6'd23 :
                 din[21] ? 6'd22 :
                 din[20] ? 6'd21 :
                 din[19] ? 6'd20 :
                 din[18] ? 6'd19 :
                 din[17] ? 6'd18 :
                 din[16] ? 6'd17 :
                 din[15] ? 6'd16 :
                 din[14] ? 6'd15 :
                 din[13] ? 6'd14 :
                 din[12] ? 6'd13 :
                 din[11] ? 6'd12 :
                 din[10] ? 6'd11 :
                 din[9] ? 6'd10 :
                 din[8] ? 6'd9 :
                 din[7] ? 6'd8 :
                 din[6] ? 6'd7 :
                 din[5] ? 6'd6 :
                 din[4] ? 6'd5 :
                 din[3] ? 6'd4 :
                 din[2] ? 6'd3 :
                 din[1] ? 6'd2 :
                 din[0] ? 6'd1 :
                 6'd0;
                 
    assign dout = (!opcode) ? {{26{1'b0}}, ff1} : {{26{1'b0}}, fl1};
end
endgenerate

generate
if (width==64) begin
    assign ff1 = 7'd0;
    assign fl1 = 7'd0;
    assign dout = (!opcode) ? {{57{1'b0}}, ff1} : {{57{1'b0}}, fl1};
end
endgenerate

endmodule
`endif

`ifdef EXT_UNIT
`define MODULE ext_unit
module `BASE`MODULE ( a, b, F, result, opcode);
`undef MODULE
parameter width = 32;
input [width-1:0] a, b;
input F;
output reg [width-1:0] result;
input [2:0] opcode;

generate
if (width==32) begin
always @ (a or b or F or opcode)
begin
    case (opcode)
    3'b000: result = {{24{1'b0}},a[7:0]};
    3'b001: result = {{24{a[7]}},a[7:0]};
    3'b010: result = {{16{1'b0}},a[7:0]};
    3'b011: result = {{16{a[15]}},a[15:0]};
    3'b110: result = (F) ? a : b;
    default: result = {b[15:0],16'h0000};
    endcase
end
end
endgenerate

generate
if (width==64) begin
always @ (a or b or F or opcode)
begin
    case (opcode)
    3'b000: result = {{56{1'b0}},a[7:0]};
    3'b001: result = {{56{a[7]}},a[7:0]};
    3'b010: result = {{48{1'b0}},a[7:0]};
    3'b011: result = {{48{a[15]}},a[15:0]};
    3'b110: result = (F) ? a : b;
    default: result = {32'h00000000,b[15:0],16'h0000};
    endcase
end
end
endgenerate
endmodule
`endif
