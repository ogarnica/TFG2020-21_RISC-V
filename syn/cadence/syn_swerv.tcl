###############################################################################
# Script synthesis for SweRV RISC-V Core
#
# Tool: Synopsys Design Compiler 2018-SP04
###############################################################################
# Steps:
#   1. Load environment variables
#   2. Set search paths.
#   2. Read RTL
#   3. Apply design dont_touches
#------------------------------------------------------------------------------

# Enable html log file
set html_log_enable true
set rptDir "./rpt"
set netDir "./net"
set logDir "./log"

source ../../syn/cadence/proc.tcl

#----------------------------------------------------- 1. Environment variables
set RV_ROOT $env(RV_ROOT)

#----------------------------------------------------- 2. Set search paths
source ../../syn/cadence/library_configuration.tcl 

#----------------------------------------------------- 3. Read RTL
set stage "read_rtl"
set logFile ${logDir}/read_rtl

#source 
redirect    ${logFile}.log {source read_rtl_swerv.tcl -echo -verbose} -tee -msg
#o poner -stderr

#no le gusta la sintaxis de después de > AQUI como hacer que lo tire al .log

#current_design "swerv_wrapper"
#no necesario el current_design aqui, ya esta en read_rtl_swerv
#----------------------------------------------------- 4. Substitute constant values
source ./scr/clock_gating_mapping.tcl

#----------------------------------------------------- 5. Operating conditions
set stage "operating_cond"
set rptFile ${rptDir}/[report_name  $stage]

# Operating conditions. Reported using the following command:
#   :\> report_operating_conditions -library tcbn65lplt
set_operating_conditions LTCOM

# We should select the wire_load_model in a per block basis. Anyway, I select the most conservative model
set_wire_load_model -name TSMC8K_Lowk_Conservative

# There are three options: top, enclosed, and segmented. I choose the most conservative
set_wire_load_mode top

# Set clock and input/output delay constraints
current_design "swerv_wrapper"
uniquify

source ./scr/contraints.tcl
report_constraint > ${rptFile}_constraints.rpt

source ./scr/dont_use_scan_flops.tcl

#----------------------------------------------------- 6. Synthesis
# Disable contant propagation accross boundaries and register merge
set compile_enable_register_merging false
set compile_enable_constant_propagation_with_no_boundary_opt false

# Report design problems
set stage "pre_syn"
set rptFile ${rptDir}/[report_name  $stage]

check_design > ${rptFile}_check_design.rpt

# First synthesis
set stage "post_syn"
set logFile ${logDir}/[report_name  $stage]

compile_ultra -no_boundary_optimization > ${logFile}_compile_ultra.log

# comprobar si funciona correctamente la opcion de que DC infiera clock-gating logic (modulo rvoclk)
# compile_ultra -no_boundary_optimization -gate_clock > ${logFile}_compile_ultra.log
# La sintesis con la opcion gate_clock no sustituye el modulo rvclkhdr por la puerta que realiza el gating
# en la libreria de TSMC. 

#----------------------------------------------------- 4. Substitute constant values
set stage "mmcells"
set logFile ${logDir}/[report_name  $stage]

source ./scr/process_mmcells.tcl > ${logFile}.log


reports $stage

# Scan optimization
set stage "post_scan"
set logFile ${logDir}/[report_name  $stage]

source ./scr/use_scan_flops.tcl
compile_ultra -no_boundary_optimization -incremental -scan > ${logFile}_compile_ultra.log
reports $stage

mv command.log ./log
#----------------------------------------------------- 7. Scan
#source insert_test.tcl
