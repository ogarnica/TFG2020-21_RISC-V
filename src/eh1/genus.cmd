# Cadence Genus(TM) Synthesis Solution, Version 19.11-s087_1, built Aug 13 2019 11:48:07

# Date: Sun May 23 12:50:54 2021
# Host: portatil (x86_64 w/Linux 3.10.0-1127.13.1.el7.x86_64) (1core*2cpus*3physical cpus*Intel(R) Core(TM) i7-7700 CPU @ 3.60GHz 8192KB)
# OS:   CentOS Linux release 7.8.2003 (Core)

pwd
cd ..
cd ..
pwd
clear
set html_log_enable true
set rptDir "./syn/reportNoLimpio"
set netDir "./syn/netNoLimpio"
set logDir "./syn/logNoLimpio"
source syn/scriptNoLimpio/proc.tcl
set RV_ROOT $env(RV_ROOT)
set_db init_hdl_search_path {/home/cadence/TFG2020-21_RISC-V/src/eh1/configs/snapshots/default_pd \
                             /home/cadence/TFG2020-21_RISC-V/src/eh1/design/lib \
                             /home/cadence/TFG2020-21_RISC-V/src/eh1/design/include \
     /home/cadence/TFG2020-21_RISC-V/src/eh1/design/dmi}
set_db init_lib_search_path {/usr/local/cmos28fdsoi_12/C28SOI_SC_12_CORE_LR/5.1-05.81/libs \
     /usr/local/cmos28fdsoi_12/C28SOI_SC_12_CLK_LR/5.1-06.81/libs  \
     /usr/local/cmos28fdsoi_12/C28SOI_SC_12_PR_LR/5.3.a-00.80/libs \
     /usr/local/cmos28fdsoi_12/C28SOI_IO_EXT_CSF_BASIC_EG_6U1X2T8XLB/7.0-03.82/libs }
clear
clear