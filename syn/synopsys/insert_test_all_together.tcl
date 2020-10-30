#------------------------------------------------------------------------------
# TEST INSERTION
#------------------------------------------------------------------------------

set stage "pre_scanChain"
set logFile ${logDir}/[report_name  $stage]
set rptFile ${rptDir}/[report_name  $stage]

# Default DFT timing variables
set_app_var test_default_delay 0
set_app_var test_default_bidir_delay 0
set_app_var test_default_strobe 40
set_app_var test_default_period 100

# DFT insertion naming rule variables
set insert_test_design_naming_style %s%d
set test_scan_enable_port_naming_style scan_en%s
set test_scan_enable_inverted_port_naming_style scan_enq%s
set test_scan_in_port_naming_style scan_in%s
set test_scan_out_port_naming_style scan_out%s
# end DFT insertion naming rule variables

# Test insertion at swerv_wrapper level
current_design [get_design "swerv_wrapper"]
link

## Necesario crear los puertos de scan
current_design [get_designs "swerv_wrapper"]
create_port {    scan_in[0] \
                 scan_in[1] \
                 scan_in[2] \
                 scan_in[3] \
                 scan_in[4] \
                 scan_in[5] \
                 scan_in[6] \
                 scan_in[7] \
                 scan_in[8] \
                 scan_in[9] \
                 scan_en} -direction in

create_port {scan_out[0] \
                 scan_out[1] \
                 scan_out[2] \
                 scan_out[3] \
                 scan_out[4] \
                 scan_out[5] \
                 scan_out[6] \
                 scan_out[7] \
                 scan_out[8] \
                 scan_out[9]} -direction out

# Set ideal net on scan enable to avoid buffering
set_ideal_network scan_en

# Scan configuration
set test_use_test_models true
set_scan_configuration -style multiplexed_flip_flop
set_scan_configuration -add_lockup false
set_scan_configuration -insert_terminal_lockup false
set_scan_configuration -clock_mixing mix_clocks
set_scan_configuration -replace false
set_scan_configuration -chain_count 10
set_scan_configuration -internal_clocks none
set test_default_scan_style multiplexed_flip_flop
set test_dont_fix_constraint_violations true

# Pin constraints for scan test mode
set_dft_signal -view existing_dft -type Reset -active_state 0 -port rst_l
set_dft_signal -view existing_dft -type Reset -active_state 0 -port dbg_rst_l
set_dft_signal -view existing_dft -type Reset -active_state 0 -port jtag_trst_n
set_dft_signal -view existing_dft -type Reset -active_state 0 -port rst_vec[*]
set_dft_signal -view existing_dft -type Constant -active_state 0 -port jtag_tck

# Define scan signals
set_dft_signal -view spec -type  ScanDataIn   -port scan_in[*]
set_dft_signal -view spec -type  ScanDataOut  -port scan_out[*]
set_dft_signal -view spec -type  ScanEnable   -active_state 1 -port scan_en
set_dft_signal -view existing_dft -type ScanClock  -timing [list 45 55] -port clk
set_dft_signal -view existing_dft -type TestMode -active 1 -port scan_mode

# Define scan chains
set_scan_path scan_chain0 -scan_data_in scan_in[0] -scan_data_out scan_out[0] -scan_enable scan_en
set_scan_path scan_chain1 -scan_data_in scan_in[1] -scan_data_out scan_out[1] -scan_enable scan_en
set_scan_path scan_chain2 -scan_data_in scan_in[2] -scan_data_out scan_out[2] -scan_enable scan_en
set_scan_path scan_chain3 -scan_data_in scan_in[3] -scan_data_out scan_out[3] -scan_enable scan_en
set_scan_path scan_chain4 -scan_data_in scan_in[4] -scan_data_out scan_out[4] -scan_enable scan_en
set_scan_path scan_chain5 -scan_data_in scan_in[5] -scan_data_out scan_out[5] -scan_enable scan_en
set_scan_path scan_chain6 -scan_data_in scan_in[6] -scan_data_out scan_out[6] -scan_enable scan_en
set_scan_path scan_chain7 -scan_data_in scan_in[7] -scan_data_out scan_out[7] -scan_enable scan_en
set_scan_path scan_chain8 -scan_data_in scan_in[8] -scan_data_out scan_out[8] -scan_enable scan_en
set_scan_path scan_chain9 -scan_data_in scan_in[9] -scan_data_out scan_out[9] -scan_enable scan_en

set_clock_gating_style -control_point before -control_signal test_mode -sequential_cell latch 
# Create test protocol
create_test_protocol -infer_clock -infer_asynch

dft_drc -pre_dft -verbose > ${rptFile}_dft_drc.rpt

# Variable to generate reports
set stage "post_scanChain"
set logFile ${logDir}/[report_name  $stage]
set rptFile ${rptDir}/[report_name  $stage]

insert_dft                > ${logFile}_insert_dft.log
preview_dft               > ${rptFile}_preview_dft.rpt
reports $stage
# Writing total netlist
#set filePref [report_name  $stage]
#write_file -format ddc -hierarchy -output ../database/${filePref}.ddc
#write_file -format verilog -hierarchy -output ../netlists/${filePref}.v

#check_design > ${filePref}_check_design.rpt
#check_timing > ${filePref}_timing.rpt

report_constraint -all_violators > ${filePref}_violations.rpt
report_cell > ${filePref}_cell.rpt
report_area -nosplit -hierarchy > ${filePref}_area.rpt
