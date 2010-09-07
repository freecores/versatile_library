VERILOG_FILES = clk_and_reset.v
VERILOG_FILES += registers.v

VERILOG_FILES_CNT = cnt_lfsr.v
VERILOG_FILES_CNT += cnt_lfsr_ce.v
VERILOG_FILES_CNT += cnt_gray.v
VERILOG_FILES_CNT += cnt_gray_ce.v
VERILOG_FILES_CNT += cnt_gray_bin_ce.v

VERILOG_FILES += $(VERILOG_FILES_CNT)
VERILOG_FILES += counters.v

VERSATILE_LIBRARIES = versatile_library.v
VERSATILE_LIBRARIES += versatile_library_actel.v
VERSATILE_LIBRARIES += versatile_library_altera.v

svn_export:
	svn export http://opencores.org/ocsvn/versatile_counter/versatile_counter/trunk/rtl/verilog/versatile_counter_generator.php
	svn export http://opencores.org/ocsvn/versatile_counter/versatile_counter/trunk/rtl/verilog/CSV.class.php

#.PHONY: $(VERILOG_FILES_CNT)
$(VERILOG_FILES_CNT):
	./versatile_counter_generator.php cnt_lfsr.csv > cnt_lfsr.v
	./versatile_counter_generator.php cnt_lfsr_ce.csv > cnt_lfsr_ce.v
	./versatile_counter_generator.php cnt_gray.csv > cnt_gray.v
	./versatile_counter_generator.php cnt_gray_ce.csv > cnt_gray_ce.v
	./versatile_counter_generator.php cnt_gray_bin_ce.csv > cnt_gray_bin_ce.v

versatile_library.v: $(VERILOG_FILES)
	cat $(VERILOG_FILES)  | sed -r -e 's/\/\/E2_([a-z]+)/`\1/' > versatile_library.v
	
versatile_library_actel.v: $(VERILOG_FILES)
	vppreproc  --noline --noblank +define+ACTEL $(VERILOG_FILES) | sed -r -e 's/\/\/E2_([a-z]+)/`\1/' > versatile_library_actel.v
	
versatile_library_altera.v: $(VERILOG_FILES)
	vppreproc  --noline --noblank +define+ALTERA $(VERILOG_FILES) > versatile_library_altera.v	

all: $(VERSATILE_LIBRARIES)

clean:
	rm $(VERSATILE_LIBRARIES)
	rm  $(VERILOG_FILES_CNT)
