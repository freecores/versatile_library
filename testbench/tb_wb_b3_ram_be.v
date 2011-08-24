module vl_wb_b3_ram_be_tb ();



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
    
endmodule
