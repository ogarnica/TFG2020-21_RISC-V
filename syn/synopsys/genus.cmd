# Cadence Genus(TM) Synthesis Solution, Version 19.11-s087_1, built Aug 13 2019 11:48:07

# Date: Fri Jan 08 17:45:40 2021
# Host: portatil (x86_64 w/Linux 3.10.0-1127.13.1.el7.x86_64) (1core*2cpus*3physical cpus*Intel(R) Core(TM) i7-7700 CPU @ 3.60GHz 8192KB)
# OS:   CentOS Linux release 7.8.2003 (Core)

set html_log_enable true
set rptDir "./rpt"
set netDir "./net"
set logDir "./log"
source ../../syn/cadence/proc.tcl
set RV_ROOT $env(RV_ROOT)
source ../../syn/cadence/library_configuration.tcl
set stage "read_rtl"
set logFile ${logDir}/read_rtl
source ../../syn/cadence/read_rtl_swerv.tcl > ${logFile}.log
source ../../syn/cadence/read_rtl_swerv.tcl <${logFile}.log>
source ../../syn/cadence/read_rtl_swerv.tcl ${logFile}.log
source help
help source
source ../../syn/cadence/read_rtl_swerv.tcl
current_design "swerv_wrapper"
current_design [swerv_wrapper]
help current_design
current_design
read_hdl -language sv $src_files
