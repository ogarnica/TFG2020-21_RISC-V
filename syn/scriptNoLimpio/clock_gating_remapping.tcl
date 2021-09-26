#current_design  "rvoclkhdr"
#check the name of the design you want to elaborate
#A design must first be read in with 'read_hdl' command

#Aquí se deben poner el diseño de rvoclkhdr

#set src_files [list "$RV_ROOT/..."]
#read_hdl -language sv $src_files
#read_libs{...}
#elaborate rvoclkhdr

set clock_gating_lib "tcbn65lplt"
set clock_gating_cell "CKLNQD8"

set clock_gating_cell_name [get_attribute [get_cell rvclkhdr] "name"]
remove_cell rvclkhdr
remove_design rvclkhdr

create_cell $clock_gating_cell_name  ${clock_gating_lib}/${clock_gating_cell}
set te_pin [get_pins $clock_gating_cell_name/TE]
connect_net scan_mode $te_pin

set e_pin [get_pins $clock_gating_cell_name/E]
connect_net en $e_pin

set cp_pin [get_pins $clock_gating_cell_name/CP]
connect_net clk $cp_pin

set q_pin [get_pins $clock_gating_cell_name/Q]
connect_net l1clk $q_pin

set_dont_touch [get_cell rvclkhdr]
set_dont_touch [current_design]
