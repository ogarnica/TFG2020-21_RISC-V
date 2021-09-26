###############################################################################
# Read RTL FOR RISC-V
###############################################################################
# Steps:
#   1. Set search paths.
#   2. Read RTL
#   3. Apply design dont_touches
#------------------------------------------------------------------------------

set RV_ROOT $env(RV_ROOT)

#------------------------------------------------------------- Set search paths
# Definidos en el archivo .synopsys.setup
# set_target_library "/opt/EDA_install/cell_libs/tcbn65lp_200a/digital/Front_End/timing_power_noise/NLDM/tcbn65lp_200a/tcbn65lplt.db"
# set search_path "$search_path $RV_ROOT/design/lib"
# set search_path "$search_path $RV_ROOT/design/include"
# set search_path "$search_path $RV_ROOT/design/dmi"
# set search_path "$search_path $RV_ROOT/configs/snapshots/default"
#--------------------------------------------------------- End set search paths

#---------------------------------------------------- Librerias con modelos QTM
lappend link_library "./QTM/ram_2048x39.db"
lappend link_library "./QTM/ram_64x21.db"
lappend link_library "./QTM/ram_256x34.db"
#---------------------------------------------------- Librerias con modelos QTM

# Avoid Scan Cells: Scan flops will be inserted later on.
source dont_use_scan_flops.tcl

set src_files [list "$RV_ROOT/design/include/swerv_types.sv" \
                   "$RV_ROOT/design/swerv_wrapper.sv" \
                   "$RV_ROOT/design/mem.sv" \
                   "$RV_ROOT/design/pic_ctrl.sv" \
                   "$RV_ROOT/design/swerv.sv" \
                   "$RV_ROOT/design/dma_ctrl.sv" \
                   "$RV_ROOT/design/ifu/ifu_aln_ctl.sv" \
                   "$RV_ROOT/design/ifu/ifu_compress_ctl.sv" \
                   "$RV_ROOT/design/ifu/ifu_ifc_ctl.sv" \
                   "$RV_ROOT/design/ifu/ifu_bp_ctl.sv" \
                   "$RV_ROOT/design/ifu/ifu_mem_ctl.sv" \
                   "$RV_ROOT/design/ifu/ifu_iccm_mem.sv" \
                   "$RV_ROOT/design/ifu/ifu.sv" \
                   "$RV_ROOT/design/dec/dec_decode_ctl.sv" \
                   "$RV_ROOT/design/dec/dec_gpr_ctl.sv" \
                   "$RV_ROOT/design/dec/dec_ib_ctl.sv" \
                   "$RV_ROOT/design/dec/dec_tlu_ctl.sv" \
                   "$RV_ROOT/design/dec/dec_trigger.sv" \
                   "$RV_ROOT/design/dec/dec.sv" \
                   "$RV_ROOT/design/exu/exu_alu_ctl.sv" \
                   "$RV_ROOT/design/exu/exu_mul_ctl.sv" \
                   "$RV_ROOT/design/exu/exu_div_ctl.sv" \
                   "$RV_ROOT/design/exu/exu.sv" \
                   "$RV_ROOT/design/lsu/lsu.sv" \
                   "$RV_ROOT/design/lsu/lsu_clkdomain.sv" \
                   "$RV_ROOT/design/lsu/lsu_addrcheck.sv" \
                   "$RV_ROOT/design/lsu/lsu_lsc_ctl.sv" \
                   "$RV_ROOT/design/lsu/lsu_stbuf.sv" \
                   "$RV_ROOT/design/lsu/lsu_bus_buffer.sv" \
                   "$RV_ROOT/design/lsu/lsu_bus_intf.sv" \
                   "$RV_ROOT/design/lsu/lsu_ecc.sv" \
                   "$RV_ROOT/design/lsu/lsu_dccm_mem.sv" \
                   "$RV_ROOT/design/lsu/lsu_dccm_ctl.sv" \
                   "$RV_ROOT/design/lsu/lsu_trigger.sv" \
                   "$RV_ROOT/design/dbg/dbg.sv" \
                   "$RV_ROOT/design/dmi/dmi_wrapper.v" \
                   "$RV_ROOT/design/dmi/dmi_jtag_to_core_sync.v" \
                   "$RV_ROOT/design/dmi/rvjtag_tap.sv" \
                   "$RV_ROOT/design/lib/svci_to_axi4.sv" \
                   "$RV_ROOT/design/lib/ahb_to_axi4.sv" \
                   "$RV_ROOT/design/lib/axi4_to_ahb.sv"]

read_file -rtl -format sverilog  $src_files

# If the file contains several modules then it must be analyzed.
analyze -format sverilog -lib WORK $RV_ROOT/design/lib/beh_lib.sv
analyze -format sverilog -lib WORK $RV_ROOT/design/ifu/ifu_ic_mem.sv

current_design swerv_wrapper
# Operating conditions. Reported using report_operating_conditions -library tcbn65lplt
set_operating_conditions LTCOM

# We should select the wire_load_model in a per block basis. Anyway, I select the most conservative model
set_wire_load_model -name TSMC8K_Lowk_Conservative

# There are three options: top, enclosed, and segmented. I choose the most conservative
set_wire_load_mode top

link
uniquify

# Check design problems

# Set clock and input/output delay constraints
source contraints.tcl

# Remove logic0 and logic1 nets
source process_mmcells.tcl

# No DW cells

compile_ultra
