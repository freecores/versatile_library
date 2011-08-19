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
