#######################################################
#                                                     
#  Tempus Timing Signoff Solution Command Logging File                     
#  Created on Tue Aug 31 23:56:17 2021                
#                                                     
#######################################################

#@(#)CDS: Tempus Timing Signoff Solution v20.11-s131_1 (64bit) 08/11/2020 14:23 (Linux 2.6.32-431.11.2.el6.x86_64)
#@(#)CDS: NanoRoute 20.11-s131_1 NR200802-2257/20_11-UB (database version 18.20.512) {superthreading v2.9}
#@(#)CDS: AAE 20.11-s009 (64bit) 08/11/2020 (Linux 2.6.32-431.11.2.el6.x86_64)
#@(#)CDS: CTE 20.11-s059_1 () Aug  2 2020 05:46:30 ( )
#@(#)CDS: SYNTECH 20.11-s028_1 () Aug  1 2020 06:14:27 ( )
#@(#)CDS: CPE v20.11-s014

read_design ../tempus/innovusFiles/APC_final_con_bumps.dat swerv_wrapper
read_sdc ../innovus/swerv_wrapper.sdc
read_spef ../innovus/swerv_wrapper.spef
set_si_mode -enable_glitch_report true
set_si_mode -enable_glitch_propagation true
update_glitch
report_noise -txtfile ./reports/glitch.txt
check_design -type all -out_file design.rpt
report_annotated_parasitics
report_analysis_coverage
report_clocks
report_case_analysis
report_inactive_arcs
report_constraint -all_violators
report_analysis_summary
report_timing -path_type summary_slack_only -late -max_paths 300
report_timing -late -max_path 1 -nworst 1
report_timing -early -max_path 1 -nworst 1
report_timing -retime path_slew_propagation -max_path 1 -nworst 1
exit
