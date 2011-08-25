VERILOG_FILES = ./../../../rtl/verilog/versatile_library.v

tb_wb_b3_ram_be:
	vppreproc --noline --noblank +define+SYSTEMVERILOG +define+WB_B3_RAM_BE $(VERILOG_FILES) > wb_b3_ram_be.v
	vlog -reportprogress 300 -work work /home/michael/work/ocsvn/versatile_library/trunk/sim/rtl_sim/run/wb_b3_ram_be.v
	vlog -reportprogress 300 -work work /home/michael/work/ocsvn/versatile_library/trunk/bench/wbm.v
	vlog -reportprogress 300 -work work /home/michael/work/ocsvn/versatile_library/trunk/bench/tb_wb_b3_ram_be.v
	vsim -do "run 10 us" -l log.txt -c work.vl_wb_b3_ram_be_tb
