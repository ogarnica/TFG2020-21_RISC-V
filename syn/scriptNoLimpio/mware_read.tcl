set RTL_PATH $env(ET1080C_DB)/RTL
read_file -format verilog $RTL_PATH/sim_lib/MWare/MW_and.v
read_file -format verilog $RTL_PATH/sim_lib/MWare/MW_buf.v
analyze   -format verilog $RTL_PATH/sim_lib/MWare/MW_csa.v
read_file -format verilog $RTL_PATH/sim_lib/MWare/MW_ff.v
read_file -format verilog $RTL_PATH/sim_lib/MWare/MW_ff_scan.v
read_file -format verilog $RTL_PATH/sim_lib/MWare/MW_full_add.v
read_file -format verilog $RTL_PATH/sim_lib/MWare/MW_half_add.v
read_file -format verilog $RTL_PATH/sim_lib/MWare/MW_inv.v
read_file -format verilog $RTL_PATH/sim_lib/MWare/MW_mux.v
read_file -format verilog $RTL_PATH/sim_lib/MWare/MW_nand.v
read_file -format verilog $RTL_PATH/sim_lib/MWare/MW_nor.v
read_file -format verilog $RTL_PATH/sim_lib/MWare/MW_or.v
read_file -format verilog $RTL_PATH/sim_lib/MWare/MW_xnor.v
read_file -format verilog $RTL_PATH/sim_lib/MWare/MW_xor.v

