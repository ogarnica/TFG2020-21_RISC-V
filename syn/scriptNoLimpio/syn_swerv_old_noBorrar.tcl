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

cd ..
# Enable html log file
set html_log_enable true
set rptDir "./rpt"
set netDir "./net"
set logDir "./log"

source syn/cadence/proc.tcl

#----------------------------------------------------- 1. Environment variables
set RV_ROOT $env(RV_ROOT)

#----------------------------------------------------- 2. Set search paths
source syn/cadence/library_configuration.tcl 

set_db lp_insert_clock_gating true

#celda escogida para clock gating en pd_defines.vh
set_dont_use C12T28SOI_LRPHP_CNHLSX29_P0 false 

#change_link -design [all_instances C12T28SOI_LRPHP_CNHLSX29_OSCAR] -base_cell C12T28SOI_LRPHP_CNHLSX29_P0

#Warning : Unusable clock gating integrated cell found at the time of loading libraries. This warning happens because a particular library cell is defined as 'clock_gating_integrated_cell', but 'dont_use' attribute is defined as true in the liberty library. To make Genus use this cell for clock gating insertion, 'dont_use' attribute should be set to false. [LBR-101]
#        : Clock gating integrated cell name: 'C12T28SOI_LRPHP_CNHLSX29_P0'
 #       : To make the cell usable, change the value of 'dont_use' attribute to false.

#----------------------------------------------------- 3. Read RTL
set stage "read_rtl"
set logFile ${logDir}/read_rtl

redirect    ${logFile}.log {source syn/cadence/read_rtl_swerv.tcl -verbose} -tee -msg -stderr

#current_design "swerv_wrapper"
#no necesario el current_design aqui, ya esta en read_rtl_swerv
#----------------------------------------------------- 4. Substitute constant values
#source ./scr/clock_gating_mapping.tcl

syn_gen
write_hdl > minetlistGen.v
syn_map
write_hdl > minetlistMap.v

#----------------------------------------------------- 5. Operating conditions
#en doc stmicroelectronics buscar: operating conditions, wire load model, wire load mode. Siguen la terminologia synopsys, buscar equivalente cadence
#Esta misma informacion se puede encontrar en la BD de Genus. Ir a libraries y alli mirar todas las condidiones de operacion.

set stage "operating_cond"
set rptFile ${rptDir}/[report_name  $stage]

# Operating conditions. Reported using the following command:
#   :\> report_operating_conditions -library tcbn65lplt



# Los operating conditions se obtienen con el comando
#get_db opcond *

# Los wireloads se obtienen con el comando
#get_db wireloads *

#El wireload mode --> el que se define por defecto es enclosed. Las otras dos opciones es top y segmented
#get_db wireload_mode

#set_operating_conditions -library LTCOM

# We should select the wire_load_model in a per block basis. Anyway, I select the most conservative model
#set_wire_load_model -name TSMC8K_Lowk_Conservative

# There are three options: top, enclosed, and segmented. I choose the most conservative
set_wire_load_mode top #SI FUNCIONA

# Set clock and input/output delay constraints
current_design "swerv_wrapper"
uniquify "swerv_wrapper"

source ./scr/contraints.tcl

#Este comando no funciona en Cadence: either specify -check_type or -drv_violation_type option.
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
redirect    ${logFile}_syn_gen.log {syn_gen -verbose} -tee -msg -stderr

# Reporta el timing en Genus
report_timing -unconstrained


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
