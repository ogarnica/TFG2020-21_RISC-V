###############################################################################
# Script synthesis for SweRV RISC-V Core
#
# Tool: Cadence Genus 19.1
###############################################################################
# Steps:
#   1. Load environment variables
#   2. Set search paths.
#   2. Read RTL
#   3. Apply design dont_touches
#------------------------------------------------------------------------------

# Enable html log file
set html_log_enable true
set rptDir "./syn/reportNoLimpio"
set netDir "./syn/netNoLimpio"
set logDir "./syn/logNoLimpio"

source syn/scriptNoLimpio/proc.tcl

#----------------------------------------------------- 1. Environment variables
set RV_ROOT $env(RV_ROOT)

#----------------------------------------------------- 2. Set search paths
source syn/scriptNoLimpio/library_configuration.tcl 

set_db lp_insert_clock_gating true
set_dont_use C12T28SOI_LRPHP_CNHLSX29_P0 false

# Este atributo controla como se insertan las tiecells durante map y opt
set_db use_tiehilo_for_const duplicate

#----------------------------------------------------- 3. Read RTL
set stage "read_rtl"
set logFile ${logDir}/read_rtl

redirect    ${logFile}.log {source syn/scriptNoLimpio/read_rtl_swerv.tcl -verbose} -tee -msg -stderr


source syn/scriptNoLimpio/padding.tcl
#----------------------------------------------------- 4. Substitute constant values
#source ./scr/clock_gating_mapping.tcl No necesario

#----------------------------------------------------- 5. Operating conditions
set stage "operating_cond"
set rptFile ${rptDir}/[report_name  $stage]

set_wire_load_mode top 

# Set clock and input/output delay constraints
current_design "swerv_wrapper"
uniquify "swerv_wrapper"

source syn/scriptNoLimpio/constraints.tcl

#Also supported pulse-width.
report_constraint -check_type clock_period > ${rptFile}_constraints.rpt 

source syn/scriptNoLimpio/dont_use_scan_flops.tcl

#------------------------------ Primera sintesis
syn_gen
write_hdl > ./syn/netNoLimpio/myNetlistGen.v
syn_map
write_hdl > ./syn/netNoLimpio/myNetlistMap.v
syn_opt
write_hdl > ./syn/netNoLimpio/myNetlistOpt.v

# Tras la optimizacion todavia quedan 3 señales con valores 1'b0:
# * Dos salidas del modulo dmi_wrapper
#   - dmi_hard_reset= 1'b0
#   - tdoEnable = 1'b0
#  * La entrada dmi_hard_reset del modulo swerv.
# Pare eliminar estos valores se ejecutan los sigueitnes comandos. Los ejecuto en ese orden para ir bottom-up
add_tieoffs -high C12T28SOI_LR_TOHX8 -low C12T28SOI_LR_TOLX8 -all -verbose -max_fanout 1 dmi_wrapper
add_tieoffs -high C12T28SOI_LR_TOHX8 -low C12T28SOI_LR_TOLX8 -all -verbose -max_fanout 1 swerv_wrapper
write_hdl > ./syn/netNoLimpio/myNetlistOpt_postTIE.v

write_sdc > ./syn/netNoLimpio/constraints.sdc

#----------------------------- Pad

#check_dft_pad_configuration #para comprobar

#primero añadir librerias (en library_conf)
#set_db init_lib_search_path {/usr/local/cmos28fdsoi_12/C28SOI_IO_EXT_CSF_BASIC_EG_6U1X2T8XLB/7.0-03.82/libs}
#set_db library {C28SOI_IO_EXT_CSF_BASIC_EG_tt28_1.00V_1.80V_25C.lib.gz}

