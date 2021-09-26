###### DIGITAL CORE TEST CONFIGURATION SCRIPT
###### Scan configuration
set test_use_test_models true
set_scan_configuration -style multiplexed_flip_flop
set_scan_configuration -add_lockup false
set_scan_configuration -insert_terminal_lockup false
set_scan_configuration -clock_mixing mix_clocks
set_scan_configuration -replace false
#### 5 scan chains, targeted to use RGMII interface pins
set_scan_configuration -chain_count 10
#set insert_test_map_effort_enabled false
set test_default_scan_style multiplexed_flip_flop
#set_dft_optimization_configuration -preserve_design_name true -none
#set_dft_optimization_configuration -preserve_design_name true # No lo coge
set test_dont_fix_constraint_violations true
###### end scan configuration

current_design [get_designs "swerv_wrapper"]
link

###### pin constraints for scan test mode
set_dft_signal -view existing_dft -type Reset -active_state 0 -port rst_l
set_dft_signal -view existing_dft -type Reset -active_state 0 -port dbg_rst_l
set_dft_signal -view existing_dft -type Reset -active_state 0 -port jtag_trst_n
set_dft_signal -view existing_dft -type Reset -active_state 0 -port rst_vec[*]
set_dft_signal -view existing_dft -type Constant -active_state 0 -port jtag_tck
#When DPGs will be inserted these constraints will be needed
#set_test_hold 0 memory_test

###### end pin constraints for scan test mode

###### define scan signals
set_dft_signal -view spec -type  ScanDataIn   -port scan_in[*] 
set_dft_signal -view spec -type  ScanDataOut  -port scan_out[*] 
set_dft_signal -view spec -type  ScanEnable   -active_state 1 -port scan_mode
set_dft_signal -view existing_dft -type  ScanClock  -timing [list 45 55] -port clk 

set_scan_path scan_chain0 -scan_data_in scan_in[0] -scan_data_out scan_out[0] -scan_enable scan_mode
set_scan_path scan_chain1 -scan_data_in scan_in[1] -scan_data_out scan_out[1] -scan_enable scan_mode
set_scan_path scan_chain2 -scan_data_in scan_in[2] -scan_data_out scan_out[2] -scan_enable scan_mode
set_scan_path scan_chain3 -scan_data_in scan_in[3] -scan_data_out scan_out[3] -scan_enable scan_mode
set_scan_path scan_chain4 -scan_data_in scan_in[4] -scan_data_out scan_out[4] -scan_enable scan_mode
set_scan_path scan_chain5 -scan_data_in scan_in[5] -scan_data_out scan_out[5] -scan_enable scan_mode
set_scan_path scan_chain6 -scan_data_in scan_in[6] -scan_data_out scan_out[6] -scan_enable scan_mode
set_scan_path scan_chain7 -scan_data_in scan_in[7] -scan_data_out scan_out[7] -scan_enable scan_mode
set_scan_path scan_chain8 -scan_data_in scan_in[8] -scan_data_out scan_out[8] -scan_enable scan_mode
set_scan_path scan_chain9 -scan_data_in scan_in[9] -scan_data_out scan_out[9] -scan_enable scan_mode

###### end define scan signals

###### Create test clock
#create_test_clock clk_scan -w {45.0 55.0} -p 100.0
###### end create test clock

###### END DIGITAL CORE TEST CONFIGURATION SCRIPT

create_test_protocol -infer_clock -infer_asynch

dft_drc -pre_dft -verbose > report_dft_drc_pre_dft.log

insert_dft  > insert_dft.log

preview_dft  > report_preview_dft.log
