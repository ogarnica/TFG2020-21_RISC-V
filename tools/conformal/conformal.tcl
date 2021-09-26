// LIBRARY SEARCH PATHS

// -- Libreria memorias
add search path /home/cadence/TFG2020-21_RISC-V/mem/C28SOI_SPHD_HIPERF_Tl_210506/4.6.a-00.00/libs -library -Both

// -- Librerias celdas estandar
add search path /usr/local/cmos28fdsoi_12/C28SOI_SC_12_CORE_LR/5.1-05.81/libs /usr/local/cmos28fdsoi_12/C28SOI_SC_12_CLK_LR/5.1-06.81/libs  /usr/local/cmos28fdsoi_12/C28SOI_SC_12_PR_LR/5.3.a-00.80/libs /usr/local/cmos28fdsoi_12/C28SOI_IO_EXT_CSF_BASIC_EG_6U1X2T8XLB/7.0-03.82/libs -library -Revised


// DESIGN SEARCH PATHS

add search path ~/TFG2020-21_RISC-V/src/eh1/design ~/TFG2020-21_RISC-V/src/eh1/design/include /home/cadence/TFG2020-21_RISC-V/src/eh1/configs/snapshots/default_pd /home/cadence/TFG2020-21_RISC-V/src/eh1/design/include -design -Golden

// LIBRARIES
read library -Golden -sensitive -Statetable -Liberty SPHD_HIPERF_Tl_210506_tt28_0.90V_0.90V_25C_nominal.lib -nooptimize   

read library -Revised -Replace -sensitive -Statetable -Liberty \
C28SOI_SC_12_CORE_LR_tt28_0.90V_25C.lib.gz \
C28SOI_SC_12_CLK_LR_tt28_0.90V_25C.lib.gz \
C28SOI_IO_EXT_CSF_BASIC_EG_tt28_0.90V_1.80V_25C.lib.gz \
C28SOI_SC_12_PR_LR_tt28_0.90V_25C.lib.gz \
SPHD_HIPERF_Tl_210506_tt28_0.90V_0.90V_25C_nominal.lib -nooptimize


// GOLDEN DESIGN READ

read design \
pd_defines.vh \
swerv_types_oscar_conformal.sv  \
swerv_types_oscar_conformal1.sv  \
swerv_wrapper.sv \
swerv.sv \
mem.sv \
lib/mem_lib.sv \
pic_ctrl.sv \
dma_ctrl.sv \
ifu/ifu_aln_ctl.sv \
ifu/ifu_compress_ctl.sv \
ifu/ifu_ifc_ctl.sv \
ifu/ifu_bp_ctl.sv \
ifu/ifu_mem_ctl.sv \
ifu/ifu_iccm_mem.sv \
ifu/ifu.sv \
dec/dec_decode_ctl_oscar.sv \
dec/dec_gpr_ctl.sv \
dec/dec_ib_ctl.sv \
dec/dec_tlu_ctl_oscar.sv \
dec/dec_trigger.sv \
dec/dec.sv \
exu/exu_alu_ctl.sv \
exu/exu_mul_ctl.sv \
exu/exu_div_ctl.sv \
exu/exu.sv \
lsu/lsu.sv \
lsu/lsu_clkdomain.sv \
lsu/lsu_addrcheck.sv \
lsu/lsu_lsc_ctl.sv \
lsu/lsu_stbuf.sv \
lsu/lsu_bus_buffer.sv \
lsu/lsu_bus_intf.sv \
lsu/lsu_ecc.sv \
lsu/lsu_dccm_mem.sv \
lsu/lsu_dccm_ctl.sv \
lsu/lsu_trigger.sv \
dbg/dbg.sv \
dmi/dmi_wrapper.v \
dmi/dmi_jtag_to_core_sync.v \
dmi/rvjtag_tap.sv \
lib/svci_to_axi4.sv \
lib/ahb_to_axi4.sv \
lib/axi4_to_ahb.sv \
lib/beh_lib.sv \
ifu/ifu_ic_mem.sv \
-SystemVerilog -sv09 -sensitive -continuousassignment Bidirectional -nokeep_unreach -nosupply -root swerv_wrapper

//Revised Design
read design \
"/home/cadence/TFG2020-21_RISC-V/syn/segunda sintesis 10-8 y 16-8/netlist/myNetlistOpt_postTIE.v" \
-Revised -SystemVerilog -sv09 -sensitive -continuousassignment Bidirectional -nokeep_unreach -nosupply -root swerv_wrapper

add renaming rule PI (%u) pad_@1 -Type PI -Golden
add renaming rule PO (%u) pad_@1 -Type PO -Golden

add renaming rule PI pad_(%u) @1 -Type PI -Revised
add renaming rule PO pad_(%u) @1 -Type PO -Revised

//  Reportar datos del design
report design data
// Command: report design data
// ============================================
Summary           Golden         Revised
============================================
Design-modules      4128             166
Library-cells       5972           68228
============================================
Primitives      Golden              Revised
============================================
INPUT              535                  535
OUTPUT             882                  882
--------------------------------------------
AND        *     60625               101556
BUF        *      3896                14429
DFF        *     14482                14053
DLAT       *       431                  475
INV        *      7704               198024
MUX        *     20073                    0
NAND       *        32                    0
NOR        *      1490                    0
OR         *     32020                43221
TIE0       *         0                 1037
TIE1       *         0                   86
WIRE       *      8410                  105
XNOR       *       885                    0
XOR        *      7054                    0
------ word-level --------------------------
ADD        *       140                    0
EQ         *       608                    0
GE         *         5                    0
GT         *         6                    0
LT         *        15                    0
MULT       *         1                    0
NE         *        14                    0
SLL        *        35                    0
SRA        *         4                    0
SRL        *        15                    0
SUBTRACT   *         9                    0
WAND       *      1781                    0
WINV       *        61                    0
WMUX       *      1681                    0
WOR        *      1250                    0
WSEL       *       306                    0
WXOR       *        27                    0
BBOX       *        28                 1444
------ don't care --------------------------
X-assignments        4                    0
--------------------------------------------
Total           157134               374430


report black box -detail

// Options
set flatten model -gated_clock
set analyze option -auto

write hier_compare dofile hier_compare.do

set system mode lec

// Warning: Golden and Revised have different numbers of key points:
// Golden  key points = 16358
// Revised key points = 17389
// Mapping key points ...
// Warning: Golden has 159 unmapped key points
// Warning: Revised has 1374 unmapped key points
================================================================================
Mapped points: SYSTEM class
--------------------------------------------------------------------------------
Mapped points     PI     PO     DFF    DLAT   BBOX      Total   
--------------------------------------------------------------------------------
Golden            535    882    14053  28     28        15526   
--------------------------------------------------------------------------------
Revised           535    882    14053  28     28        15526   
================================================================================
Unmapped points:
================================================================================
Golden:
--------------------------------------------------------------------------------
Unmapped points   DFF    DLAT      Total   
--------------------------------------------------------------------------------
Unreachable       270    403       673     
Not-mapped        157    2         159     
================================================================================
Revised:
--------------------------------------------------------------------------------
Unmapped points   DLAT   BBOX      Total   
--------------------------------------------------------------------------------
Unreachable       447    42        489     
Not-mapped        0      1374      1374    
================================================================================
// Warning: Key point mapping is incomplete
CPU time     : 283.34  seconds
Elapse time  : 347558  seconds
Memory usage : 17184.38 M bytes
// Running automatic setup...
// Merged 95 DFF/DLAT(s) in (G)
// Merged 1 DFF/DLAT(s) in (R)
// Remodeled 28 DLAT(s) as the generic latch.
// Remodeled 80 DLAT/DFF for inserting sequential redundancy.
// Remodeled 40 DLAT/DFF (G) and 40 DLAT/DFF (R) for removing sequential redundancy.
// Modeling sequential merge in (G).
// Modeling sequential merge in (R).
// Merged 19 DFF/DLAT(s) in Golden.
// Merged 1 DFF/DLAT(s) in Revised.
// Automatic setup finished.



report floating signals -Undriven -Both -Net -All

Undriven nets in Golden:
  In module exu: exu_mp_pkt[valid]  exu_mp_pkt[br_error]  
    exu_mp_pkt[br_start_error]  exu_mp_pkt[prett][31]  exu_mp_pkt[prett][30]  
    exu_mp_pkt[prett][29]  exu_mp_pkt[prett][28]  exu_mp_pkt[prett][27]  
    exu_mp_pkt[prett][26]  exu_mp_pkt[prett][25]  exu_mp_pkt[prett][24]  
    exu_mp_pkt[prett][23]  exu_mp_pkt[prett][22]  exu_mp_pkt[prett][21]  
    exu_mp_pkt[prett][20]  exu_mp_pkt[prett][19]  exu_mp_pkt[prett][18]  
    exu_mp_pkt[prett][17]  exu_mp_pkt[prett][16]  exu_mp_pkt[prett][15]  
    exu_mp_pkt[prett][14]  exu_mp_pkt[prett][13]  exu_mp_pkt[prett][12]  
    exu_mp_pkt[prett][11]  exu_mp_pkt[prett][10]  exu_mp_pkt[prett][9]  
    exu_mp_pkt[prett][8]  exu_mp_pkt[prett][7]  exu_mp_pkt[prett][6]  
    exu_mp_pkt[prett][5]  exu_mp_pkt[prett][4]  exu_mp_pkt[prett][3]  
    exu_mp_pkt[prett][2]  exu_mp_pkt[prett][1]
Undriven nets in Revised:
  In module dec_decode_ctl: i1_predict_p_d[index][5]  i1_predict_p_d[index][4]  
    i0_predict_p_d[index][5]  i0_predict_p_d[index][4]  
    i1_predict_p_d[btag][8]  i1_predict_p_d[btag][7]  i1_predict_p_d[btag][6]  
    i1_predict_p_d[btag][5]  i1_predict_p_d[btag][4]  i1_predict_p_d[btag][3]  
    i1_predict_p_d[btag][2]  i1_predict_p_d[btag][1]  i1_predict_p_d[btag][0]  
    i0_predict_p_d[btag][8]  i0_predict_p_d[btag][7]  i0_predict_p_d[btag][6]  
    i0_predict_p_d[btag][5]  i0_predict_p_d[btag][4]  i0_predict_p_d[btag][3]  
    i0_predict_p_d[btag][2]  i0_predict_p_d[btag][1]  i0_predict_p_d[btag][0]  
    i1_predict_p_d[toffset][11]  i1_predict_p_d[toffset][9]  
    i1_predict_p_d[toffset][8]  i1_predict_p_d[toffset][7]  
    i1_predict_p_d[toffset][6]  i1_predict_p_d[toffset][5]  
    i1_predict_p_d[toffset][4]  i0_predict_p_d[toffset][11]  
    i0_predict_p_d[toffset][9]  i0_predict_p_d[toffset][8]  
    i0_predict_p_d[toffset][7]  i0_predict_p_d[toffset][6]  
    i0_predict_p_d[toffset][5]  i0_predict_p_d[toffset][4]  
    dec_csr_rdaddr_d[11]  dec_csr_rdaddr_d[10]  dec_csr_rdaddr_d[9]  
    dec_csr_rdaddr_d[8]  dec_csr_rdaddr_d[7]  dec_csr_rdaddr_d[6]  
    dec_csr_rdaddr_d[5]  dec_csr_rdaddr_d[4]  dec_csr_rdaddr_d[3]  
    dec_csr_rdaddr_d[2]  dec_csr_rdaddr_d[1]  dec_csr_rdaddr_d[0]  
    dec_pmu_instr_decoded[1]  dec_pmu_instr_decoded[0]  
    i1_predict_p_d[hist][1]  i1_predict_p_d[hist][0]  i1_predict_p_d[bank][1]  
    i1_predict_p_d[bank][0]  i0_predict_p_d[hist][1]  i0_predict_p_d[hist][0]  
    i0_predict_p_d[bank][1]  i0_predict_p_d[bank][0]  i1_predict_p_d[fghr][4]  
    i1_predict_p_d[fghr][3]  i1_predict_p_d[fghr][2]  i1_predict_p_d[fghr][1]  
    i1_predict_p_d[fghr][0]  i0_predict_p_d[fghr][4]  i0_predict_p_d[fghr][3]  
    i0_predict_p_d[fghr][2]  i0_predict_p_d[fghr][1]  i0_predict_p_d[fghr][0]  
    dec_i1_rs2_d[4]  dec_i1_rs2_d[3]  dec_i1_rs2_d[2]  dec_i1_rs2_d[1]  
    dec_i1_rs2_d[0]  dec_i1_rs1_d[4]  dec_i1_rs1_d[3]  dec_i1_rs1_d[2]  
    dec_i1_rs1_d[1]  dec_i1_rs1_d[0]  dec_i0_rs2_d[4]  dec_i0_rs2_d[3]  
    dec_i0_rs2_d[2]  dec_i0_rs2_d[1]  dec_i0_rs2_d[0]  dec_i0_rs1_d[4]  
    dec_i0_rs1_d[3]  dec_i0_rs1_d[2]  dec_i0_rs1_d[1]  dec_i0_rs1_d[0]  
    i1_predict_p_d[prett][31]  i1_predict_p_d[prett][30]  
    i1_predict_p_d[prett][29]  i1_predict_p_d[prett][28]  
    i1_predict_p_d[prett][27]  i1_predict_p_d[prett][26]  
    i1_predict_p_d[prett][25]  i1_predict_p_d[prett][24]  
    i1_predict_p_d[prett][23]  i1_predict_p_d[prett][22]  
    i1_predict_p_d[prett][21]  i1_predict_p_d[prett][20]  
    i1_predict_p_d[prett][19]  i1_predict_p_d[prett][18]  
    i1_predict_p_d[prett][17]  i1_predict_p_d[prett][16]  
    i1_predict_p_d[prett][15]  i1_predict_p_d[prett][14]  
    i1_predict_p_d[prett][13]  i1_predict_p_d[prett][12]  
    i1_predict_p_d[prett][11]  i1_predict_p_d[prett][10]  
    i1_predict_p_d[prett][9]  i1_predict_p_d[prett][8]  
    i1_predict_p_d[prett][7]  i1_predict_p_d[prett][6]  
    i1_predict_p_d[prett][5]  i1_predict_p_d[prett][4]  
    i1_predict_p_d[prett][3]  i1_predict_p_d[prett][2]  
    i1_predict_p_d[prett][1]  i0_predict_p_d[prett][31]  
    i0_predict_p_d[prett][30]  i0_predict_p_d[prett][29]  
    i0_predict_p_d[prett][28]  i0_predict_p_d[prett][27]  
    i0_predict_p_d[prett][26]  i0_predict_p_d[prett][25]  
    i0_predict_p_d[prett][24]  i0_predict_p_d[prett][23]  
    i0_predict_p_d[prett][22]  i0_predict_p_d[prett][21]  
    i0_predict_p_d[prett][20]  i0_predict_p_d[prett][19]  
    i0_predict_p_d[prett][18]  i0_predict_p_d[prett][17]  
    i0_predict_p_d[prett][16]  i0_predict_p_d[prett][15]  
    i0_predict_p_d[prett][14]  i0_predict_p_d[prett][13]  
    i0_predict_p_d[prett][12]  i0_predict_p_d[prett][11]  
    i0_predict_p_d[prett][10]  i0_predict_p_d[prett][9]  
    i0_predict_p_d[prett][8]  i0_predict_p_d[prett][7]  
    i0_predict_p_d[prett][6]  i0_predict_p_d[prett][5]  
    i0_predict_p_d[prett][4]  i0_predict_p_d[prett][3]  
    i0_predict_p_d[prett][2]  i0_predict_p_d[prett][1]  i1_predict_p_d[misp]  
    i1_predict_p_d[ataken]  i1_predict_p_d[boffset]  i1_predict_p_d[pc4]  
    i1_predict_p_d[br_error]  i1_predict_p_d[br_start_error]  
    i1_predict_p_d[way]  i0_predict_p_d[misp]  i0_predict_p_d[ataken]  
    i0_predict_p_d[boffset]  i0_predict_p_d[pc4]  i0_predict_p_d[way]  
    dec_div_decode_e4  dec_tlu_packet_e4[sbecc]  dec_tlu_packet_e4[pmu_divide]  
    lsu_p[dword]  lsu_p[dma]  dec_ib1_valid_eff_d  dec_ib0_valid_eff_d  
    i1_ap[valid]  i1_ap[csr_write]  i1_ap[csr_imm]  i0_ap[valid]
  In module dma_ctrl: dma_axi_rid[0]  dma_axi_rresp[1]  dma_axi_rresp[0]  
    dma_iccm_stall_any  dma_iccm_req  dma_slv_algn_err  dma_axi_rlast
  In module exu: exu_mp_pkt[prett][31]  exu_mp_pkt[prett][30]  
    exu_mp_pkt[prett][29]  exu_mp_pkt[prett][28]  exu_mp_pkt[prett][27]  
    exu_mp_pkt[prett][26]  exu_mp_pkt[prett][25]  exu_mp_pkt[prett][24]  
    exu_mp_pkt[prett][23]  exu_mp_pkt[prett][22]  exu_mp_pkt[prett][21]  
    exu_mp_pkt[prett][20]  exu_mp_pkt[prett][19]  exu_mp_pkt[prett][18]  
    exu_mp_pkt[prett][17]  exu_mp_pkt[prett][16]  exu_mp_pkt[prett][15]  
    exu_mp_pkt[prett][14]  exu_mp_pkt[prett][13]  exu_mp_pkt[prett][12]  
    exu_mp_pkt[prett][11]  exu_mp_pkt[prett][10]  exu_mp_pkt[prett][9]  
    exu_mp_pkt[prett][8]  exu_mp_pkt[prett][7]  exu_mp_pkt[prett][6]  
    exu_mp_pkt[prett][5]  exu_mp_pkt[prett][4]  exu_mp_pkt[prett][3]  
    exu_mp_pkt[prett][2]  exu_mp_pkt[prett][1]  exu_pmu_i1_br_misp  
    exu_rets_e4_pkt[pc0_call]  exu_rets_e4_pkt[pc0_ret]  
    exu_rets_e4_pkt[pc0_pc4]  exu_rets_e4_pkt[pc1_call]  
    exu_rets_e4_pkt[pc1_ret]  exu_rets_e4_pkt[pc1_pc4]  
    exu_rets_e1_pkt[pc0_call]  exu_rets_e1_pkt[pc0_ret]  
    exu_rets_e1_pkt[pc0_pc4]  exu_rets_e1_pkt[pc1_call]  
    exu_rets_e1_pkt[pc1_ret]  exu_rets_e1_pkt[pc1_pc4]  exu_flush_upper_e2  
    exu_i1_br_call_e4  exu_i1_br_ret_e4  exu_i1_br_start_error_e4  
    exu_i1_br_error_e4  exu_i0_br_call_e4  exu_i0_br_ret_e4  exu_mp_pkt[valid]  
    exu_mp_pkt[br_error]  exu_mp_pkt[br_start_error]
  In module ifu_aln_ctl: ifu_icache_error_index[16]  ifu_icache_error_index[15]  
    ifu_icache_error_index[14]  ifu_icache_error_index[13]  
    ifu_icache_error_index[12]  ifu_icache_error_index[5]  
    ifu_icache_error_index[4]  ifu_icache_error_index[3]  
    ifu_icache_error_index[2]  ifu_i1_instr[0]  ifu_i0_instr[0]  
    ifu_icache_sb_error_val  ifu_i1_dbecc  ifu_i0_dbecc  ifu_i1_sbecc  
    ifu_i0_sbecc
  In module ifu_mem_ctl: ic_data_f2[127]  ic_data_f2[126]  ic_data_f2[125]  
    ic_data_f2[124]  ic_data_f2[123]  ic_data_f2[122]  ic_data_f2[121]  
    ic_data_f2[120]  ic_data_f2[119]  ic_data_f2[118]  ic_data_f2[117]  
    ic_data_f2[116]  ic_data_f2[115]  ic_data_f2[114]  ic_data_f2[113]  
    ic_data_f2[112]  ic_data_f2[111]  ic_data_f2[110]  ic_data_f2[109]  
    ic_data_f2[108]  ic_data_f2[107]  ic_data_f2[106]  ic_data_f2[105]  
    ic_data_f2[104]  ic_data_f2[103]  ic_data_f2[102]  ic_data_f2[101]  
    ic_data_f2[100]  ic_data_f2[99]  ic_data_f2[98]  ic_data_f2[97]  
    ic_data_f2[96]  ic_data_f2[95]  ic_data_f2[94]  ic_data_f2[93]  
    ic_data_f2[92]  ic_data_f2[91]  ic_data_f2[90]  ic_data_f2[89]  
    ic_data_f2[88]  ic_data_f2[87]  ic_data_f2[86]  ic_data_f2[85]  
    ic_data_f2[84]  ic_data_f2[83]  ic_data_f2[82]  ic_data_f2[81]  
    ic_data_f2[80]  ic_data_f2[79]  ic_data_f2[78]  ic_data_f2[77]  
    ic_data_f2[76]  ic_data_f2[75]  ic_data_f2[74]  ic_data_f2[73]  
    ic_data_f2[72]  ic_data_f2[71]  ic_data_f2[70]  ic_data_f2[69]  
    ic_data_f2[68]  ic_data_f2[67]  ic_data_f2[66]  ic_data_f2[65]  
    ic_data_f2[64]  ic_data_f2[63]  ic_data_f2[62]  ic_data_f2[61]  
    ic_data_f2[60]  ic_data_f2[59]  ic_data_f2[58]  ic_data_f2[57]  
    ic_data_f2[56]  ic_data_f2[55]  ic_data_f2[54]  ic_data_f2[53]  
    ic_data_f2[52]  ic_data_f2[51]  ic_data_f2[50]  ic_data_f2[49]  
    ic_data_f2[48]  ic_data_f2[47]  ic_data_f2[46]  ic_data_f2[45]  
    ic_data_f2[44]  ic_data_f2[43]  ic_data_f2[42]  ic_data_f2[41]  
    ic_data_f2[40]  ic_data_f2[39]  ic_data_f2[38]  ic_data_f2[37]  
    ic_data_f2[36]  ic_data_f2[35]  ic_data_f2[34]  ic_data_f2[33]  
    ic_data_f2[32]  ic_data_f2[31]  ic_data_f2[30]  ic_data_f2[29]  
    ic_data_f2[28]  ic_data_f2[27]  ic_data_f2[26]  ic_data_f2[25]  
    ic_data_f2[24]  ic_data_f2[23]  ic_data_f2[22]  ic_data_f2[21]  
    ic_data_f2[20]  ic_data_f2[19]  ic_data_f2[18]  ic_data_f2[17]  
    ic_data_f2[16]  ic_data_f2[15]  ic_data_f2[14]  ic_data_f2[13]  
    ic_data_f2[12]  ic_data_f2[11]  ic_data_f2[10]  ic_data_f2[9]  
    ic_data_f2[8]  ic_data_f2[7]  ic_data_f2[6]  ic_data_f2[5]  ic_data_f2[4]  
    ic_data_f2[3]  ic_data_f2[2]  ic_data_f2[1]  ic_data_f2[0]  
    ic_debug_addr[15]  ic_debug_addr[14]  ic_debug_addr[13]  ic_debug_addr[12]  
    ic_debug_addr[11]  ic_debug_addr[10]  ic_debug_addr[9]  ic_debug_addr[8]  
    ic_debug_addr[7]  ic_debug_addr[6]  ic_debug_addr[5]  ic_debug_addr[4]  
    ic_debug_addr[3]  ic_debug_addr[2]  ic_debug_wr_data[33]  
    ic_debug_wr_data[32]  ic_debug_wr_data[31]  ic_debug_wr_data[30]  
    ic_debug_wr_data[29]  ic_debug_wr_data[28]  ic_debug_wr_data[27]  
    ic_debug_wr_data[26]  ic_debug_wr_data[25]  ic_debug_wr_data[24]  
    ic_debug_wr_data[23]  ic_debug_wr_data[22]  ic_debug_wr_data[21]  
    ic_debug_wr_data[20]  ic_debug_wr_data[19]  ic_debug_wr_data[18]  
    ic_debug_wr_data[17]  ic_debug_wr_data[16]  ic_debug_wr_data[15]  
    ic_debug_wr_data[14]  ic_debug_wr_data[13]  ic_debug_wr_data[12]  
    ic_debug_wr_data[11]  ic_debug_wr_data[10]  ic_debug_wr_data[9]  
    ic_debug_wr_data[8]  ic_debug_wr_data[7]  ic_debug_wr_data[6]  
    ic_debug_wr_data[5]  ic_debug_wr_data[4]  ic_debug_wr_data[3]  
    ic_debug_wr_data[2]  ic_debug_wr_data[1]  ic_debug_wr_data[0]  
    iccm_dma_rdata[63]  iccm_dma_rdata[62]  iccm_dma_rdata[61]  
    iccm_dma_rdata[60]  iccm_dma_rdata[59]  iccm_dma_rdata[58]  
    iccm_dma_rdata[57]  iccm_dma_rdata[56]  iccm_dma_rdata[55]  
    iccm_dma_rdata[54]  iccm_dma_rdata[53]  iccm_dma_rdata[52]  
    iccm_dma_rdata[51]  iccm_dma_rdata[50]  iccm_dma_rdata[49]  
    iccm_dma_rdata[48]  iccm_dma_rdata[47]  iccm_dma_rdata[46]  
    iccm_dma_rdata[45]  iccm_dma_rdata[44]  iccm_dma_rdata[43]  
    iccm_dma_rdata[42]  iccm_dma_rdata[41]  iccm_dma_rdata[40]  
    iccm_dma_rdata[39]  iccm_dma_rdata[38]  iccm_dma_rdata[37]  
    iccm_dma_rdata[36]  iccm_dma_rdata[35]  iccm_dma_rdata[34]  
    iccm_dma_rdata[33]  iccm_dma_rdata[32]  iccm_dma_rdata[31]  
    iccm_dma_rdata[30]  iccm_dma_rdata[29]  iccm_dma_rdata[28]  
    iccm_dma_rdata[27]  iccm_dma_rdata[26]  iccm_dma_rdata[25]  
    iccm_dma_rdata[24]  iccm_dma_rdata[23]  iccm_dma_rdata[22]  
    iccm_dma_rdata[21]  iccm_dma_rdata[20]  iccm_dma_rdata[19]  
    iccm_dma_rdata[18]  iccm_dma_rdata[17]  iccm_dma_rdata[16]  
    iccm_dma_rdata[15]  iccm_dma_rdata[14]  iccm_dma_rdata[13]  
    iccm_dma_rdata[12]  iccm_dma_rdata[11]  iccm_dma_rdata[10]  
    iccm_dma_rdata[9]  iccm_dma_rdata[8]  iccm_dma_rdata[7]  iccm_dma_rdata[6]  
    iccm_dma_rdata[5]  iccm_dma_rdata[4]  iccm_dma_rdata[3]  iccm_dma_rdata[2]  
    iccm_dma_rdata[1]  iccm_dma_rdata[0]  ifu_axi_wdata[63]  ifu_axi_wdata[62]  
    ifu_axi_wdata[61]  ifu_axi_wdata[60]  ifu_axi_wdata[59]  ifu_axi_wdata[58]  
    ifu_axi_wdata[57]  ifu_axi_wdata[56]  ifu_axi_wdata[55]  ifu_axi_wdata[54]  
    ifu_axi_wdata[53]  ifu_axi_wdata[52]  ifu_axi_wdata[51]  ifu_axi_wdata[50]  
    ifu_axi_wdata[49]  ifu_axi_wdata[48]  ifu_axi_wdata[47]  ifu_axi_wdata[46]  
    ifu_axi_wdata[45]  ifu_axi_wdata[44]  ifu_axi_wdata[43]  ifu_axi_wdata[42]  
    ifu_axi_wdata[41]  ifu_axi_wdata[40]  ifu_axi_wdata[39]  ifu_axi_wdata[38]  
    ifu_axi_wdata[37]  ifu_axi_wdata[36]  ifu_axi_wdata[35]  ifu_axi_wdata[34]  
    ifu_axi_wdata[33]  ifu_axi_wdata[32]  ifu_axi_wdata[31]  ifu_axi_wdata[30]  
    ifu_axi_wdata[29]  ifu_axi_wdata[28]  ifu_axi_wdata[27]  ifu_axi_wdata[26]  
    ifu_axi_wdata[25]  ifu_axi_wdata[24]  ifu_axi_wdata[23]  ifu_axi_wdata[22]  
    ifu_axi_wdata[21]  ifu_axi_wdata[20]  ifu_axi_wdata[19]  ifu_axi_wdata[18]  
    ifu_axi_wdata[17]  ifu_axi_wdata[16]  ifu_axi_wdata[15]  ifu_axi_wdata[14]  
    ifu_axi_wdata[13]  ifu_axi_wdata[12]  ifu_axi_wdata[11]  ifu_axi_wdata[10]  
    ifu_axi_wdata[9]  ifu_axi_wdata[8]  ifu_axi_wdata[7]  ifu_axi_wdata[6]  
    ifu_axi_wdata[5]  ifu_axi_wdata[4]  ifu_axi_wdata[3]  ifu_axi_wdata[2]  
    ifu_axi_wdata[1]  ifu_axi_wdata[0]  ifu_axi_arburst[1]  ifu_axi_arburst[0]  
    ifu_axi_awburst[1]  ifu_axi_awburst[0]  ic_error_f2[parity][7]  
    ic_error_f2[parity][6]  ic_error_f2[parity][5]  ic_error_f2[parity][4]  
    ic_error_f2[parity][3]  ic_error_f2[parity][2]  ic_error_f2[parity][1]  
    ic_error_f2[parity][0]  ic_fetch_val_f2[0]  iccm_rd_ecc_double_err[7]  
    iccm_rd_ecc_double_err[6]  iccm_rd_ecc_double_err[5]  
    iccm_rd_ecc_double_err[4]  iccm_rd_ecc_double_err[3]  
    iccm_rd_ecc_double_err[2]  iccm_rd_ecc_double_err[1]  
    iccm_rd_ecc_double_err[0]  ic_access_fault_f2[6]  ic_access_fault_f2[5]  
    ic_access_fault_f2[4]  ic_access_fault_f2[2]  ic_access_fault_f2[1]  
    ic_access_fault_f2[0]  ifu_axi_arlen[7]  ifu_axi_arlen[6]  
    ifu_axi_arlen[5]  ifu_axi_arlen[4]  ifu_axi_arlen[3]  ifu_axi_arlen[2]  
    ifu_axi_arlen[1]  ifu_axi_arlen[0]  ifu_axi_wstrb[7]  ifu_axi_wstrb[6]  
    ifu_axi_wstrb[5]  ifu_axi_wstrb[4]  ifu_axi_wstrb[3]  ifu_axi_wstrb[2]  
    ifu_axi_wstrb[1]  ifu_axi_wstrb[0]  ifu_axi_awlen[7]  ifu_axi_awlen[6]  
    ifu_axi_awlen[5]  ifu_axi_awlen[4]  ifu_axi_awlen[3]  ifu_axi_awlen[2]  
    ifu_axi_awlen[1]  ifu_axi_awlen[0]  ifu_axi_arqos[3]  ifu_axi_arqos[2]  
    ifu_axi_arqos[1]  ifu_axi_arqos[0]  ifu_axi_arcache[3]  ifu_axi_arcache[2]  
    ifu_axi_arcache[1]  ifu_axi_arcache[0]  ifu_axi_arregion[3]  
    ifu_axi_arregion[2]  ifu_axi_arregion[1]  ifu_axi_arregion[0]  
    ifu_axi_awqos[3]  ifu_axi_awqos[2]  ifu_axi_awqos[1]  ifu_axi_awqos[0]  
    ifu_axi_awcache[3]  ifu_axi_awcache[2]  ifu_axi_awcache[1]  
    ifu_axi_awcache[0]  ifu_axi_awregion[3]  ifu_axi_awregion[2]  
    ifu_axi_awregion[1]  ifu_axi_awregion[0]  ifu_axi_araddr[5]  
    ifu_axi_araddr[4]  ifu_axi_araddr[3]  ifu_axi_araddr[2]  ifu_axi_araddr[1]  
    ifu_axi_araddr[0]  ifu_axi_awaddr[31]  ifu_axi_awaddr[30]  
    ifu_axi_awaddr[29]  ifu_axi_awaddr[28]  ifu_axi_awaddr[27]  
    ifu_axi_awaddr[26]  ifu_axi_awaddr[25]  ifu_axi_awaddr[24]  
    ifu_axi_awaddr[23]  ifu_axi_awaddr[22]  ifu_axi_awaddr[21]  
    ifu_axi_awaddr[20]  ifu_axi_awaddr[19]  ifu_axi_awaddr[18]  
    ifu_axi_awaddr[17]  ifu_axi_awaddr[16]  ifu_axi_awaddr[15]  
    ifu_axi_awaddr[14]  ifu_axi_awaddr[13]  ifu_axi_awaddr[12]  
    ifu_axi_awaddr[11]  ifu_axi_awaddr[10]  ifu_axi_awaddr[9]  
    ifu_axi_awaddr[8]  ifu_axi_awaddr[7]  ifu_axi_awaddr[6]  ifu_axi_awaddr[5]  
    ifu_axi_awaddr[4]  ifu_axi_awaddr[3]  ifu_axi_awaddr[2]  ifu_axi_awaddr[1]  
    ifu_axi_awaddr[0]  ifu_axi_arprot[2]  ifu_axi_arprot[1]  ifu_axi_arprot[0]  
    ifu_axi_arsize[2]  ifu_axi_arsize[1]  ifu_axi_arsize[0]  ifu_axi_awprot[2]  
    ifu_axi_awprot[1]  ifu_axi_awprot[0]  ifu_axi_awsize[2]  ifu_axi_awsize[1]  
    ifu_axi_awsize[0]  ifu_axi_awid[2]  ifu_axi_awid[1]  ifu_axi_awid[0]  
    ic_sel_premux_data  ifu_icache_fetch_f2  iccm_dma_sb_error  
    iccm_rd_ecc_single_err  ic_debug_tag_array  ic_debug_wr_en  ic_debug_rd_en  
    iccm_ready  iccm_dma_rvalid  iccm_dma_ecc_error  ifu_axi_rready  
    ifu_axi_arlock  ifu_axi_bready  ifu_axi_wlast  ifu_axi_wvalid  
    ifu_axi_awlock  ifu_axi_awvalid  ic_dma_active
  In module lsu: lsu_axi_arburst[1]  lsu_axi_arburst[0]  lsu_axi_awburst[1]  
    lsu_axi_awburst[0]  lsu_axi_arlen[7]  lsu_axi_arlen[6]  lsu_axi_arlen[5]  
    lsu_axi_arlen[4]  lsu_axi_arlen[3]  lsu_axi_arlen[2]  lsu_axi_arlen[1]  
    lsu_axi_arlen[0]  lsu_axi_awlen[7]  lsu_axi_awlen[6]  lsu_axi_awlen[5]  
    lsu_axi_awlen[4]  lsu_axi_awlen[3]  lsu_axi_awlen[2]  lsu_axi_awlen[1]  
    lsu_axi_awlen[0]  lsu_axi_arqos[3]  lsu_axi_arqos[2]  lsu_axi_arqos[1]  
    lsu_axi_arqos[0]  lsu_axi_arcache[3]  lsu_axi_arcache[2]  
    lsu_axi_arcache[1]  lsu_axi_arcache[0]  lsu_axi_arregion[3]  
    lsu_axi_arregion[2]  lsu_axi_arregion[1]  lsu_axi_arregion[0]  
    lsu_axi_arid[3]  lsu_axi_arid[2]  lsu_axi_arid[1]  lsu_axi_arid[0]  
    lsu_axi_awqos[3]  lsu_axi_awqos[2]  lsu_axi_awqos[1]  lsu_axi_awqos[0]  
    lsu_axi_awregion[3]  lsu_axi_awregion[2]  lsu_axi_awregion[1]  
    lsu_axi_awregion[0]  lsu_axi_arprot[2]  lsu_axi_arprot[1]  
    lsu_axi_arprot[0]  lsu_axi_arsize[2]  lsu_axi_arsize[1]  lsu_axi_arsize[0]  
    lsu_axi_awprot[2]  lsu_axi_awprot[1]  lsu_axi_awprot[0]  lsu_axi_awsize[2]  
    lsu_axi_araddr[31]  lsu_axi_araddr[30]  lsu_axi_araddr[29]  
    lsu_axi_araddr[28]  lsu_axi_araddr[27]  lsu_axi_araddr[26]  
    lsu_axi_araddr[25]  lsu_axi_araddr[24]  lsu_axi_araddr[23]  
    lsu_axi_araddr[22]  lsu_axi_araddr[21]  lsu_axi_araddr[20]  
    lsu_axi_araddr[19]  lsu_axi_araddr[18]  lsu_axi_araddr[17]  
    lsu_axi_araddr[16]  lsu_axi_araddr[15]  lsu_axi_araddr[14]  
    lsu_axi_araddr[13]  lsu_axi_araddr[12]  lsu_axi_araddr[11]  
    lsu_axi_araddr[10]  lsu_axi_araddr[9]  lsu_axi_araddr[8]  
    lsu_axi_araddr[7]  lsu_axi_araddr[6]  lsu_axi_araddr[5]  lsu_axi_araddr[4]  
    lsu_axi_araddr[3]  lsu_axi_araddr[2]  lsu_axi_araddr[1]  lsu_axi_araddr[0]  
    picm_wr_data[31]  picm_wr_data[30]  picm_wr_data[29]  picm_wr_data[28]  
    picm_wr_data[27]  picm_wr_data[26]  picm_wr_data[25]  picm_wr_data[24]  
    picm_wr_data[23]  picm_wr_data[22]  picm_wr_data[21]  picm_wr_data[20]  
    picm_wr_data[19]  picm_wr_data[18]  picm_wr_data[17]  picm_wr_data[16]  
    picm_wr_data[15]  picm_wr_data[14]  picm_wr_data[13]  picm_wr_data[12]  
    picm_wr_data[11]  picm_wr_data[10]  picm_wr_data[9]  picm_wr_data[8]  
    picm_wr_data[7]  picm_wr_data[6]  picm_wr_data[5]  picm_wr_data[4]  
    picm_wr_data[3]  picm_wr_data[2]  picm_wr_data[1]  picm_wr_data[0]  
    picm_addr[31]  picm_addr[30]  picm_addr[29]  picm_addr[28]  picm_addr[27]  
    picm_addr[26]  picm_addr[25]  picm_addr[24]  picm_addr[23]  picm_addr[22]  
    picm_addr[21]  picm_addr[20]  picm_addr[19]  picm_addr[18]  picm_addr[17]  
    picm_addr[16]  picm_addr[15]  lsu_axi_rready  lsu_axi_arlock  
    lsu_axi_bready  lsu_axi_wlast  lsu_axi_awlock  
    lsu_nonblock_load_data_error  lsu_idle_any
  In module lsu_bus_intf: lsu_axi_arburst[1]  lsu_axi_arburst[0]  
    lsu_axi_awburst[1]  lsu_axi_awburst[0]  lsu_axi_arlen[7]  lsu_axi_arlen[6]  
    lsu_axi_arlen[5]  lsu_axi_arlen[4]  lsu_axi_arlen[3]  lsu_axi_arlen[2]  
    lsu_axi_arlen[1]  lsu_axi_arlen[0]  lsu_axi_awlen[7]  lsu_axi_awlen[6]  
    lsu_axi_awlen[5]  lsu_axi_awlen[4]  lsu_axi_awlen[3]  lsu_axi_awlen[2]  
    lsu_axi_awlen[1]  lsu_axi_awlen[0]  lsu_axi_arqos[3]  lsu_axi_arqos[2]  
    lsu_axi_arqos[1]  lsu_axi_arqos[0]  lsu_axi_arcache[3]  lsu_axi_arcache[2]  
    lsu_axi_arcache[1]  lsu_axi_arcache[0]  lsu_axi_arregion[3]  
    lsu_axi_arregion[2]  lsu_axi_arregion[1]  lsu_axi_arregion[0]  
    lsu_axi_arid[3]  lsu_axi_arid[2]  lsu_axi_arid[1]  lsu_axi_arid[0]  
    lsu_axi_awqos[3]  lsu_axi_awqos[2]  lsu_axi_awqos[1]  lsu_axi_awqos[0]  
    lsu_axi_awregion[3]  lsu_axi_awregion[2]  lsu_axi_awregion[1]  
    lsu_axi_awregion[0]  lsu_axi_arprot[2]  lsu_axi_arprot[1]  
    lsu_axi_arprot[0]  lsu_axi_arsize[2]  lsu_axi_arsize[1]  lsu_axi_arsize[0]  
    lsu_axi_awprot[2]  lsu_axi_awprot[1]  lsu_axi_awprot[0]  lsu_axi_awsize[2]  
    lsu_axi_araddr[31]  lsu_axi_araddr[30]  lsu_axi_araddr[29]  
    lsu_axi_araddr[28]  lsu_axi_araddr[27]  lsu_axi_araddr[26]  
    lsu_axi_araddr[25]  lsu_axi_araddr[24]  lsu_axi_araddr[23]  
    lsu_axi_araddr[22]  lsu_axi_araddr[21]  lsu_axi_araddr[20]  
    lsu_axi_araddr[19]  lsu_axi_araddr[18]  lsu_axi_araddr[17]  
    lsu_axi_araddr[16]  lsu_axi_araddr[15]  lsu_axi_araddr[14]  
    lsu_axi_araddr[13]  lsu_axi_araddr[12]  lsu_axi_araddr[11]  
    lsu_axi_araddr[10]  lsu_axi_araddr[9]  lsu_axi_araddr[8]  
    lsu_axi_araddr[7]  lsu_axi_araddr[6]  lsu_axi_araddr[5]  lsu_axi_araddr[4]  
    lsu_axi_araddr[3]  lsu_axi_araddr[2]  lsu_axi_araddr[1]  lsu_axi_araddr[0]  
    ld_bus_error_addr_dc3[31]  ld_bus_error_addr_dc3[30]  
    ld_bus_error_addr_dc3[29]  ld_bus_error_addr_dc3[28]  
    ld_bus_error_addr_dc3[27]  ld_bus_error_addr_dc3[26]  
    ld_bus_error_addr_dc3[25]  ld_bus_error_addr_dc3[24]  
    ld_bus_error_addr_dc3[23]  ld_bus_error_addr_dc3[22]  
    ld_bus_error_addr_dc3[21]  ld_bus_error_addr_dc3[20]  
    ld_bus_error_addr_dc3[19]  ld_bus_error_addr_dc3[18]  
    ld_bus_error_addr_dc3[17]  ld_bus_error_addr_dc3[16]  
    ld_bus_error_addr_dc3[15]  ld_bus_error_addr_dc3[14]  
    ld_bus_error_addr_dc3[13]  ld_bus_error_addr_dc3[12]  
    ld_bus_error_addr_dc3[11]  ld_bus_error_addr_dc3[10]  
    ld_bus_error_addr_dc3[9]  ld_bus_error_addr_dc3[8]  
    ld_bus_error_addr_dc3[7]  ld_bus_error_addr_dc3[6]  
    ld_bus_error_addr_dc3[5]  ld_bus_error_addr_dc3[4]  
    ld_bus_error_addr_dc3[3]  ld_bus_error_addr_dc3[2]  
    ld_bus_error_addr_dc3[1]  ld_bus_error_addr_dc3[0]  lsu_axi_rready  
    lsu_axi_arlock  lsu_axi_bready  lsu_axi_wlast  lsu_axi_awlock  
    lsu_nonblock_load_data_error


add compared points -all

compare -NONEQ_Print -THREADS 10,12


write hier_compare dofile hier_compare.do
dofile hier_compare.do
