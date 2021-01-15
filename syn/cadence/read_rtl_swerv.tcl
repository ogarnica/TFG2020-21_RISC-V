#----------------------------------------------------- Design files
set src_files [list "pd_defines.vh" \
                   "$RV_ROOT/design/include/swerv_types.sv" \
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
                   "$RV_ROOT/design/lib/axi4_to_ahb.sv" \
		  "$RV_ROOT/design/lib/beh_lib.sv" \
		  "$RV_ROOT/design/ifu/ifu_ic_mem.sv"]

read_hdl -language sv $src_files

read_libs {C28SOI_SC_12_CORE_LR_tt28_1.00V_25C.lib.gz} 


elaborate swerv_wrapper
