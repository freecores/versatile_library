module vl_wb_b3_ram_be_tb ();

   wire [31:0] wbm_a_dat_o;
   wire [3:0]  wbm_a_sel_o;
   wire [31:0] wbm_a_adr_o;
   wire [2:0]  wbm_a_cti_o;
   wire [1:0]  wbm_a_bte_o;
   wire        wbm_a_we_o ;
   wire        wbm_a_cyc_o;
   wire        wbm_a_stb_o;
   wire [31:0] wbm_a_dat_i;
   wire        wbm_a_ack_i;
   reg         wbm_a_clk  ;
   reg         wbm_a_rst  ;


vl_wb_b3_ram_be dut (
    .wbs_dat_i(),
    .wbs_adr_i(),
    .wbs_cti_i(),
    .wbs_bte_i(),
    .wbs_sel_i(),
    .wbs_we_i(),
    .wbs_stb_i(),
    .wbs_cyc_i(), 
    .wbs_dat_o(),
    .wbs_ack_o(),
    .wb_clk(),
    .wb_rst());


        wbm wbmi(
            .adr_o(wbm_a_adr_o),
            .bte_o(wbm_a_bte_o),
            .cti_o(wbm_a_cti_o),
            .dat_o(wbm_a_dat_o),
	    .sel_o(wbm_a_sel_o),
            .we_o (wbm_a_we_o),
            .cyc_o(wbm_a_cyc_o),
            .stb_o(wbm_a_stb_o),
            .dat_i(wbm_a_dat_i),
            .ack_i(wbm_a_ack_i),
            .clk(wbm_a_clk),
            .reset(wbm_a_rst),
            .OK(wbm_OK)
);

initial
    begin
        #0      wbm_a_rst = 1'b1;
	#200    wbm_a_rst = 1'b0;	
    end

// Wishbone clock
initial
    begin
	#0 wbm_a_clk = 1'b0;
	forever
            #(wb_clk_period/2) wbm_a_clk = !wbm_a_clk;
    end

endmodule
