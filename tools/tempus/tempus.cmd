#######################################################
#                                                     
#  Tempus Timing Signoff Solution Command Logging File                     
#  Created on Thu Sep  9 19:48:21 2021                
#                                                     
#######################################################

#@(#)CDS: Tempus Timing Signoff Solution v20.11-s131_1 (64bit) 08/11/2020 14:23 (Linux 2.6.32-431.11.2.el6.x86_64)
#@(#)CDS: NanoRoute 20.11-s131_1 NR200802-2257/20_11-UB (database version 18.20.512) {superthreading v2.9}
#@(#)CDS: AAE 20.11-s009 (64bit) 08/11/2020 (Linux 2.6.32-431.11.2.el6.x86_64)
#@(#)CDS: CTE 20.11-s059_1 () Aug  2 2020 05:46:30 ( )
#@(#)CDS: SYNTECH 20.11-s028_1 () Aug  1 2020 06:14:27 ( )
#@(#)CDS: CPE v20.11-s014

read_design ./innovusFiles/APC_final_con_bumps.dat swerv_wrapper
read_sdc ../innovus/swerv_wrapper.sdc
read_spef ../innovus/swerv_wrapper.spef
report_clocks
check_clock_design
all_setup_analysis_views
all_hold_analysis_views
all_setup_analysis_views
all_hold_analysis_views
update_timing -full
report_timing
report_timing -check_clocks
report_timing -
report_timing -clock_from clk -clock_to clk -check_type setup
report_timing -clock_from clk -clock_to _jtag_clk -check_type setup
report_clocks
report_timing -clock_from clk -clock_to _jtag_clk -check_type setup
report_timing -clock_from clk -clock_to _jtag_tck -check_type setup
report_timing -clock_from clk -clock_to jtag_tck -check_type setup
report_timing -clock_from jtag_tck -clock_to jtag_tck -check_type setup
report_timing -clock_from clk -clock_to clk -check_type setup -max_paths 30000 > oscar_setupviolations.txt
ctd_win -id ctdMain
selectObject IO_Pin clk
zoomSelected
deselectObject IO_Pin clk
selectObject IO_Pin clk
zoomSelected
deselectObject IO_Pin clk
zoomSelected
deselectObject IO_Pin clk
selectObject IO_Pin clk
deselectObject IO_Pin clk
selectObject IO_Pin clk
selectObject IO_Pin clk
selectObject IO_Pin clk
deselectObject IO_Pin clk
selectInst i_WIRECELL_EXT_CSF_FC_LIN_clk
deselectInst i_WIRECELL_EXT_CSF_FC_LIN_clk
selectObject Pin i_WIRECELL_EXT_CSF_FC_LIN_clk/ANAZI
selectInst i_WIRECELL_EXT_CSF_FC_LIN_clk
deselectInst i_WIRECELL_EXT_CSF_FC_LIN_clk
selectObject Pin swerv/FE_OFC352_pad_clk/Z
selectObject Pin swerv/FE_OFC352_pad_clk/Z
deselectObject Pin swerv/FE_OFC352_pad_clk/Z
selectInst FE_OFC353_pad_clk
deselectInst FE_OFC353_pad_clk
selectObject Pin FE_OFC353_pad_clk/Z
selectObject Pin FE_OFC353_pad_clk/Z
deselectObject Pin FE_OFC353_pad_clk/Z
selectObject Pin FE_OFC357_pad_clk/Z
selectObject Pin FE_OFC357_pad_clk/Z
deselectObject Pin FE_OFC357_pad_clk/Z
selectObject Pin FE_OFC408_FE_OFN370_pad_clk/Z
selectObject Pin FE_OFC408_FE_OFN370_pad_clk/Z
deselectObject Pin FE_OFC408_FE_OFN370_pad_clk/Z
selectObject Pin FE_OFC361_pad_clk/Z
selectObject Pin FE_OFC361_pad_clk/Z
deselectObject Pin FE_OFC361_pad_clk/Z
selectObject Pin swerv/FE_OFC6200_FE_OFN365_pad_clk/Z
selectObject Pin swerv/FE_OFC6200_FE_OFN365_pad_clk/Z
deselectObject Pin swerv/FE_OFC6200_FE_OFN365_pad_clk/Z
selectInst swerv/FE_OFC356_pad_clk
deselectInst swerv/FE_OFC356_pad_clk
selectInst swerv/FE_OFC356_pad_clk
deselectInst swerv/FE_OFC356_pad_clk
selectInst swerv/FE_OFC6201_FE_OFN365_pad_clk
deselectInst swerv/FE_OFC6201_FE_OFN365_pad_clk
selectObject Pin swerv/FE_OFC6201_FE_OFN365_pad_clk/Z
selectObject Pin swerv/FE_OFC6201_FE_OFN365_pad_clk/Z
deselectObject Pin swerv/FE_OFC6201_FE_OFN365_pad_clk/Z
selectObject Pin {swerv/dec_tlu_mpvhalt_ff_dout_reg[6]/Q}
selectObject Pin {swerv/dec_tlu_mpvhalt_ff_dout_reg[6]/Q}
deselectObject Pin {swerv/dec_tlu_mpvhalt_ff_dout_reg[6]/Q}
selectInst {swerv/dec_tlu_mpvhalt_ff_dout_reg[6]}
deselectInst {swerv/dec_tlu_mpvhalt_ff_dout_reg[6]}
selectInst {swerv/dec_tlu_mpvhalt_ff_dout_reg[6]}
deselectInst {swerv/dec_tlu_mpvhalt_ff_dout_reg[6]}
selectInst {swerv/dec_tlu_mpvhalt_ff_dout_reg[6]}
deselectInst {swerv/dec_tlu_mpvhalt_ff_dout_reg[6]}
selectInst {swerv/dec_tlu_mpvhalt_ff_dout_reg[6]}
report_timing -from swerv/dec_tlu_mpvhalt_ff_dout_reg[6]
report_timing -from swerv/dec_tlu_mpvhalt_ff_dout_reg[6]/CP
deselectInst {swerv/dec_tlu_mpvhalt_ff_dout_reg[6]}
selectInst {swerv/dec_tlu_mpvhalt_ff_dout_reg[6]}
deselectInst {swerv/dec_tlu_mpvhalt_ff_dout_reg[6]}
selectInst i_WIRECELL_EXT_CSF_FC_LIN_debug_brkpt_status
deselectInst i_WIRECELL_EXT_CSF_FC_LIN_debug_brkpt_status
selectObject Pin swerv/FE_MDBC72_dec_tlu_g110407/Z
selectObject Pin swerv/FE_MDBC72_dec_tlu_g110407/Z
deselectObject Pin swerv/FE_MDBC72_dec_tlu_g110407/Z
selectObject Pin swerv/FE_OFC5901_FE_MDBN72/Z
selectObject Pin swerv/FE_OFC5901_FE_MDBN72/Z
selectInst swerv/FE_OFC5902_FE_MDBN72
report_timing -from swerv/dec_tlu_mpvhalt_ff_dout_reg[6]/CP -to swerv/FE_OFC5902_FE_MDBN72
deselectInst swerv/FE_OFC5902_FE_MDBN72
selectObject Pin swerv/dec_tlu_g110407/D
selectObject Pin swerv/dec_tlu_g110407/D
deselectObject Pin swerv/FE_OFC6087_FE_OFN4635_dec_tlu_internal_dbg_halt_mode/A
selectObject Pin swerv/FE_OFC6087_FE_OFN4635_dec_tlu_internal_dbg_halt_mode/A
selectObject Pin swerv/FE_OFC6087_FE_OFN4635_dec_tlu_internal_dbg_halt_mode/A
selectObject Net swerv/dec_tlu_internal_dbg_halt_mode
deselectObject Net swerv/dec_tlu_internal_dbg_halt_mode
selectObject Pin swerv/dec_tlu_g110407/C
selectObject Pin swerv/dec_tlu_g110407/C
deselectObject Net swerv/FE_OFN3683_dec_tlu_n_1993
selectObject Pin swerv/dec_tlu_g110407/B
selectObject Pin swerv/dec_tlu_g110407/B
get_clock_network_objects -clocks clk
get_clock_network_objects
report_clock_propagation
report_clock_propagation -clock clk
report_clock_propagation -clock clk -to swerv/dec_tlu_mpvhalt_ff_dout_reg[6]/CP
report_clock_propagation -clock clk -to swerv/dec_tlu_mpvhalt_ff_dout_reg[6]/CP -verbose
report_clock_propagation -clock pad_clk -to swerv/dec_tlu_mpvhalt_ff_dout_reg[6]/CP -verbose
deselectObject Pin swerv/dec_tlu_g110407/B
report_cell_instance_timing i_WIRECELL_EXT_CSF_FC_LIN_clk
selectObject Pin i_WIRECELL_EXT_CSF_FC_LIN_clk/ANAIOPAD
deselectObject Pin i_WIRECELL_EXT_CSF_FC_LIN_clk/ANAIOPAD
selectObject Pin i_WIRECELL_EXT_CSF_FC_LIN_clk/ANAIO
set_propagated_clock
set_propagated_clock clk
set_propagated_clock 
set_propagated_clock                                                                                                                                                 nominal_analysis_view
set_propagated_clock [all_clocks]
ctd_win -id ctdMain
create_clock [get_ports {clk}]  -name clk -period 1.000000 -waveform {0.000000 0.500000}
create_clock [get_ports {clk}]  -name pad_clk -period 1.000000 -waveform {0.000000 0.500000}
create_clock [get_nets {pad_clk}]  -name pad_clk -period 1.000000 -waveform {0.000000 0.500000}
all_constraint_modes
get_constraint_mode $modeName -sdc_files
set_interactive_constraint_modes
set_interactive_constraint_modes nominal_constraints
set_propagated_clock [all_clocks]
report_cell_instance_timing i_WIRECELL_EXT_CSF_FC_LIN_clk
report_clock_propagation -clock pad_clk -to swerv/dec_tlu_mpvhalt_ff_dout_reg[6]/CP -verbose
report_clock_propagation -clock clk -to swerv/dec_tlu_mpvhalt_ff_dout_reg[6]/CP -verbose
check_timing
create_clock [get_nets {pad_clk}]  -name pad_clk -period 1.000000 -waveform {0.000000 0.500000}
create_clock [get_pins {i_WIRECELL_EXT_CSF_FC_LIN_clk/ANAIO}]  -name pad_clk -period 1.000000 -waveform {0.000000 0.500000}
check_timing
report_clock_propagation -clock pad_clk -to swerv/dec_tlu_mpvhalt_ff_dout_reg[6]/CP -verbose
set_propagated_clock [all_clocks]                        
check_timing
report_timing
set_propagated_clock [get_port pad_clk]                        
report_clocks
create_clock [get_pins {i_WIRECELL_EXT_CSF_FC_LIN_clk/ANAIO}]  -name "pad_clk" -period 1.000000 -waveform {0.000000 0.500000}
report_clocks
set_propagated_clock [get_port pad_clk]                        
set_propagated_clock [get_clock pad_clk]                        
update_timing -full
check_timing
report_clock_propagation -clock pad_clk -to swerv/dec_tlu_mpvhalt_ff_dout_reg[6]/CP -verbose
report_clock_propagation -clock pad_clk -to swerv/FE_OFC352_pad_clk/A -verbose
report_timing -from i_WIRECELL_EXT_CSF_FC_LIN_clk/ANAIO -to swerv/FE_OFC352_pad_clk/A -path_type full_clock -debug
report_timing -from i_WIRECELL_EXT_CSF_FC_LIN_clk/ANAIO -to swerv/FE_OFC352_pad_clk/A -path_type full_clock -debug unconstrained
report_timing -from i_WIRECELL_EXT_CSF_FC_LIN_clk/ANAIO -to swerv/FE_OFC352_pad_clk/A -path_type full_clock -debug unconstrained -unconstrained
report_clock_propagation -clock pad_clk -to swerv/FE_OFC352_pad_clk/A -verbose
deselectObject Pin i_WIRECELL_EXT_CSF_FC_LIN_clk/ANAIO
set_disable_timing swerv/clk
exit
