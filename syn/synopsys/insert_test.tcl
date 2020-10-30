#######################################################
#######################################################
################ TEST INSERTION #######################
#######################################################
#######################################################

# Default timing variables
set_app_var test_default_delay 0
set_app_var test_default_bidir_delay 0
set_app_var test_default_strobe 40
set_app_var test_default_period 100

###### DFT insertion naming rule variables
set insert_test_design_naming_style %s%d
set test_scan_enable_port_naming_style scan_en%s
set test_scan_enable_inverted_port_naming_style scan_enq%s
set test_scan_in_port_naming_style scan_in%s
set test_scan_out_port_naming_style scan_out%s
###### end DFT insertion naming rule variables


#################################################
## TEST INSERTION IS DONE AT GIGABIT_TOP LEVEL
#################################################
current_design [get_design "swerv_wrapper"]
link

###### Use scan flops
source -echo ./use_scan_flops.tcl
###### end use scan flops

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
                 scan_in[9]} -direction in

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

###### Set ideal net on scan enable to avoid buffering
current_design [get_designs "swerv_wrapper"]
link
set_ideal_network scan_mode
###### end set ideal net on scan enable

###### Configure test mode at digital_core level
source -echo ./test_configuration_digital_core.tcl
###### end configure test mode at digital_core level

###### Insert scan
current_design [get_designs "swerv_wrapper"]
link
check_test
##### sleep out at the end of a scan chain
#                               Canceller_4d sleep_out chain             ffe_4d sleep_out
#set_scan_path sleep_chain { "pma/base1000_pma/pma_receive/canceller_4d/4" \
#                            "pma/base100_1000_pma/ffe_4d/ffe_4d_emi_reg/sleep_del_reg[3]" \
#                            "pma/base100_1000_pma/ffe_4d/ffe_4d_emi_reg/sleep_del_reg[2]" \
#                            "pma/base100_1000_pma/ffe_4d/ffe_4d_emi_reg/sleep_del_reg[1]" \
#                            "pma/base100_1000_pma/ffe_4d/ffe_4d_emi_reg/sleep_del_reg[0]" }
check_test
###### end sleep_out at the end of a scan_chain

# SCAN TEST CHAINS STITCHING
insert_scan -ignore_compile_design_rules
###### end insert scan

###### Report scan insertion
report_test -scan > ./report_test_scan.digital_core.log
check_test -verbose > ./check_test.digital_core.log
###### end report scan insertion

source -echo ./dont_use_scan_flops.tcl


###### End Remove test model

current_design [get_designs "swerv_wrapper"]
link
write_file -format db -hierarchy -output ../database/[get_object_name [current_design]]_post_scan_HVT.db
###### end write database

###### writing total netlist
current_design [get_designs "swerv_wrapper"]
link
write_file -format verilog -hierarchy -output ../netlists/[get_object_name [current_design]]_post_scan_HVT.v
###### end writing total netlist


check_design > quad_check_design_scan.log
check_timing > quad_check_timing_scan.log
report_constraint -all_violators > quad_viol_scan.log
report_cell > quad_report_cell_scan.log

################################################################################
# REPORT AREA FOR NON-HARDMACRO DESIGNS ########################################
################################################################################
source -echo ./gen_area_report_after_scan.tcl

################################################################################
# END REPORT AREA FOR NON-HARDMACRO DESIGNS ####################################
################################################################################
