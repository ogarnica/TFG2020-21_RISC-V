read_design ../tempus/innovusFiles/APC_final_con_bumps.dat swerv_wrapper
# read_sdc ../innovus/swerv_wrapper.sdc
read_sdc ./swerv_oscar.sdc
read_spef ../innovus/swerv_wrapper.spef

# No vamos a hacer SI. Este comando lo comentaria
# set_delay_cal_mode -siAware true

set_si_mode -enable_glitch_report true
set_si_mode -enable_glitch_propagation true

set_propagated_clock [all_clocks]
update_timing -full

update_glitch

report_noise -txtfile ./reports/glitch.txt


check_design -type all -out_file design.rpt
report_annotated_parasitics
report_analysis_coverage

report_clocks
report_case_analysis
report_inactive_arcs

# report_constraint -all
report_constraint -all_violators > constraintallviolators.rpt
report_analysis_summary

report_timing -path_type summary_slack_only -late -max_paths 300
report_timing -late -max_path 1 -nworst 1
report_timing -early -max_path 1 -nworst 1
report_timing -retime path_slew_propagation -max_path 1 -nworst 1


# Comandos usados durante la depuracion del script
#
# report_cell_instance_timing i_WIRECELL_EXT_CSF_FC_LIN_clk
# create_clock [get_pins {i_WIRECELL_EXT_CSF_FC_LIN_clk/ANAIO}]  -name pad_clk -period 1.0 -waveform {0.0 0.5}
# set_propagated_clock [all_clocks]                        
# report_clock_propagation -clock pad_clk -to swerv/dec_tlu_mpvhalt_ff_dout_reg[6]/CP -verbose
#
# get_nets {pad_clk}
# report_cell_instance_timing i_WIRECELL_EXT_CSF_FC_LIN_clk
# report_delay_calculation -from i_WIRECELL_EXT_CSF_FC_LIN_clk/ANAIO -to swerv/FE_OFC352_pad_clk/A         
#
# update_timing -full
# report_timing -from i_WIRECELL_EXT_CSF_FC_LIN_clk/ANAIO -to swerv/FE_OFC352_pad_clk/A -path_type full_clock -debug
# report_timing -from swerv/dec_tlu_mpvhalt_ff_dout_reg[6]/CP -to swerv/FE_OFC5902_FE_MDBN72
#
#
# 	The unloadTimingCon command is not supported in the MMMC environment.
#           To modify the active set of constraints you can use one of the following means:
#           - Use the set_analysis_view command to change the set of active views.
#           - Use the update_analysis_view command to change the constraint mode associated with an active view.
#           - Use the update_constraint_mode command to change the set of SDC files pointed to be active modes.
#
# Comandos para determinar el constraints mode
# all_constraints_mode -active
# set_interactive_constraint_modes nominal_constraints     
