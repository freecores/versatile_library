VERILOG_FILES = clk_and_reset.v
VERILOG_FILES += registers.v
VERILOG_FILES += logic.v

VERILOG_FILES_CNT = vl_cnt_bin.v
VERILOG_FILES_CNT += vl_cnt_bin_clear.v
VERILOG_FILES_CNT += vl_cnt_bin_ce.v
VERILOG_FILES_CNT += vl_cnt_bin_ce_clear.v
VERILOG_FILES_CNT += vl_cnt_bin_ce_clear_l1_l2.v
VERILOG_FILES_CNT += vl_cnt_bin_ce_clear_set_rew.v
VERILOG_FILES_CNT += vl_cnt_bin_ce_rew_l1.v
VERILOG_FILES_CNT += vl_cnt_bin_ce_rew_zq_l1.v
VERILOG_FILES_CNT += vl_cnt_bin_ce_rew_q_zq_l1.v
VERILOG_FILES_CNT += vl_cnt_lfsr_zq.v
VERILOG_FILES_CNT += vl_cnt_lfsr_ce_zq.v
VERILOG_FILES_CNT += vl_cnt_lfsr_ce_q.v
VERILOG_FILES_CNT += vl_cnt_lfsr_ce_clear_q.v
VERILOG_FILES_CNT += vl_cnt_lfsr_ce_q_zq.v
VERILOG_FILES_CNT += vl_cnt_lfsr_ce_rew_l1.v
VERILOG_FILES_CNT += vl_cnt_gray.v
VERILOG_FILES_CNT += vl_cnt_gray_ce.v
VERILOG_FILES_CNT += vl_cnt_gray_ce_bin.v

VERILOG_FILES += $(VERILOG_FILES_CNT)
VERILOG_FILES += counters.v
VERILOG_FILES += memories.v
VERILOG_FILES += wb.v
VERILOG_FILES += arith.v

VERSATILE_LIBRARIES = versatile_library.v
VERSATILE_LIBRARIES += versatile_library_actel.v
VERSATILE_LIBRARIES += versatile_library_altera.v

svn_export:
	svn export http://opencores.org/ocsvn/versatile_counter/versatile_counter/trunk/rtl/verilog/versatile_counter_generator.php
	svn export http://opencores.org/ocsvn/versatile_counter/versatile_counter/trunk/rtl/verilog/CSV.class.php

#.PHONY: $(VERILOG_FILES_CNT)
$(VERILOG_FILES_CNT):
	./versatile_counter_generator.php cnt_bin.csv > vl_cnt_bin.v
	./versatile_counter_generator.php cnt_bin_clear.csv > vl_cnt_bin_clear.v
	./versatile_counter_generator.php cnt_bin_ce.csv > vl_cnt_bin_ce.v
	./versatile_counter_generator.php cnt_bin_ce_clear.csv > vl_cnt_bin_ce_clear.v
	./versatile_counter_generator.php cnt_bin_ce_clear_l1_l2.csv > vl_cnt_bin_ce_clear_l1_l2.v
	./versatile_counter_generator.php cnt_bin_ce_clear_set_rew.csv > vl_cnt_bin_ce_clear_set_rew.v
	./versatile_counter_generator.php cnt_bin_ce_rew_l1.csv > vl_cnt_bin_ce_rew_l1.v
	./versatile_counter_generator.php cnt_bin_ce_rew_zq_l1.csv > vl_cnt_bin_ce_rew_zq_l1.v
	./versatile_counter_generator.php cnt_bin_ce_rew_q_zq_l1.csv > vl_cnt_bin_ce_rew_q_zq_l1.v
	./versatile_counter_generator.php cnt_lfsr_zq.csv > vl_cnt_lfsr_zq.v
	./versatile_counter_generator.php cnt_lfsr_ce_zq.csv > vl_cnt_lfsr_ce_zq.v
	./versatile_counter_generator.php cnt_lfsr_ce_q.csv > vl_cnt_lfsr_ce_q.v
	./versatile_counter_generator.php cnt_lfsr_ce_clear_q.csv > vl_cnt_lfsr_ce_clear_q.v
	./versatile_counter_generator.php cnt_lfsr_ce_q_zq.csv > vl_cnt_lfsr_ce_q_zq.v
	./versatile_counter_generator.php cnt_lfsr_ce_rew_l1.csv > vl_cnt_lfsr_ce_rew_l1.v
	./versatile_counter_generator.php cnt_gray.csv > vl_cnt_gray.v
	./versatile_counter_generator.php cnt_gray_ce.csv > vl_cnt_gray_ce.v
	./versatile_counter_generator.php cnt_gray_ce_bin.csv > vl_cnt_gray_ce_bin.v

versatile_library.v: $(VERILOG_FILES)
	cat $(VERILOG_FILES)  | sed -r -e 's/\/\/E2_([a-z]+)/`\1/' > versatile_library.v
	
versatile_library_actel.v: $(VERILOG_FILES)
	vppreproc  --noline --noblank +define+ACTEL $(VERILOG_FILES) | sed -r -e 's/\/\/E2_([a-z]+)/`\1/' > versatile_library_actel.v
	
versatile_library_altera.v: $(VERILOG_FILES)
	vppreproc  --noline --noblank +define+ALTERA $(VERILOG_FILES) | sed -r -e 's/\/\/E2_([a-z]+)/`\1/' > versatile_library_altera.v	

all: $(VERSATILE_LIBRARIES)

clean:
	rm $(VERSATILE_LIBRARIES)
	rm  $(VERILOG_FILES_CNT)
