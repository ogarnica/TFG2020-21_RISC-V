# Paths busqueda archivos HDL
set_db init_hdl_search_path {/home/cadence/TFG2020-21_RISC-V/src/eh1/configs/snapshots/default_pd \
                             /home/cadence/TFG2020-21_RISC-V/src/eh1/design/lib \
                             /home/cadence/TFG2020-21_RISC-V/src/eh1/design/include \
			     /home/cadence/TFG2020-21_RISC-V/src/eh1/design/dmi}

# Paths busqueda de librerias
set_db init_lib_search_path {/usr/local/cmos28fdsoi_12/C28SOI_SC_12_CORE_LR/5.1-05.81/libs \
			     /usr/local/cmos28fdsoi_12/C28SOI_SC_12_CLK_LR/5.1-06.81/libs  \
			     /usr/local/cmos28fdsoi_12/C28SOI_SC_12_PR_LR/5.3.a-00.80/libs \
			     /usr/local/cmos28fdsoi_12/C28SOI_IO_EXT_CSF_BASIC_EG_6U1X2T8XLB/7.0-03.82/libs \
home/cadence/TFG2020-21_RISC-V/mem/C28SOI_SPHD_HIPERF_Tl_210506/4.6.a-00.00/libs
			     }
			     #/home/cadence/TFG2020-21_RISC-V/syn/synopsys/QTM}

# Usamos libreria tipica. Process: Typical ( NMOS: Typical PMOS: Typical), Volt: 1.0V (Nominal), Temp: 25C
#set_db library {C28SOI_SC_12_CORE_LR_tt28_1.00V_25C.lib.gz C28SOI_SC_12_CLK_LR_tt28_1.00V_25C.lib.gz C28SOI_IO_EXT_CSF_BASIC_EG_tt28_1.00V_1.80V_25C.lib.gz C28SOI_SC_12_PR_LR_tt28_1.00V_25C.lib.gz /home/cadence/TFG2020-21_RISC-V/mem/C28SOI_SPHD_HIPERF_Tl_210506/4.6.a-00.00/libs/SPHD_HIPERF_Tl_210506_tt28_0.90V_0.90V_25C_nominal.lib }
#Si no se pone la ruta entera, no es capaz de encontrarlo

# Las memorias estan caracterizadas a 0.90V. Usamos librerias caracterizadas a esa tension
set_db library {C28SOI_SC_12_CORE_LR_tt28_0.90V_25C.lib.gz C28SOI_SC_12_CLK_LR_tt28_0.90V_25C.lib.gz C28SOI_IO_EXT_CSF_BASIC_EG_tt28_0.90V_1.80V_25C.lib.gz C28SOI_SC_12_PR_LR_tt28_0.90V_25C.lib.gz /home/cadence/TFG2020-21_RISC-V/mem/C28SOI_SPHD_HIPERF_Tl_210506/4.6.a-00.00/libs/SPHD_HIPERF_Tl_210506_tt28_0.90V_0.90V_25C_nominal.lib}

# Paths busqueda de scripts
set_db script_search_path {/home/cadence/TFG2020-21_RISC-V/syn/scriptNoLimpio}

