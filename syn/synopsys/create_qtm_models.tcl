# Read environment variable
set RV_ROOT $env(RV_ROOT)

# Open Milkiway library
open_mw_lib bb

#-------------  QTM Models creation

# 1. RAM_2048x39
create_qtm_model ram_2048x39
set_qtm_technology -library /opt/EDA_install/cell_libs/tcbn65lp_200a/digital/Front_End/timing_power_noise/NLDM/tcbn65lp_200a/tcbn65lplt.db

create_qtm_port -type clock CLK
create_qtm_port {D[38:0] WE ADR[10:0]} -type input
create_qtm_port -type output Q[38:0]

set_qtm_global_parameter -param setup -value 0.343
set_qtm_global_parameter -param hold -value 0.100
set_qtm_global_parameter -param clk_to_output -value 0.654

create_qtm_delay_arc -name CLK_TO_Q -from CLK -from_edge rise -to Q -value 0.777 -to_edge rise

save_qtm_model -format db -output QTM/ram_2048x39

# 2. RAM_64x21
current_design ram_64x21
create_qtm_model ram_64x21
set_qtm_technology -library /opt/EDA_install/cell_libs/tcbn65lp_200a/digital/Front_End/timing_power_noise/NLDM/tcbn65lp_200a/tcbn65lplt.db


create_qtm_port -type clock CLK
create_qtm_port -type input ADR[5:0]
create_qtm_port -type input D[20:0] 
create_qtm_port -type input WE
create_qtm_port -type output Q[20:0]

set_qtm_global_parameter -param setup -value 0.343
set_qtm_global_parameter -param hold -value 0.100
set_qtm_global_parameter -param clk_to_output -value 0.654

create_qtm_delay_arc -name CLK_TO_Q -from CLK -from_edge rise -to Q -value 0.777 -to_edge rise

save_qtm_model -format db -output QTM/ram_64x21

# 3. RAM_256x34
current_design ram_256x34
create_qtm_model ram_256x34
set_qtm_technology -library /opt/EDA_install/cell_libs/tcbn65lp_200a/digital/Front_End/timing_power_noise/NLDM/tcbn65lp_200a/tcbn65lplt.db

create_qtm_port -type clock CLK
create_qtm_port -type input ADR[7:0]
create_qtm_port -type input D[33:0] 
create_qtm_port -type input WE
create_qtm_port -type output Q[33:0]

set_qtm_global_parameter -param setup -value 0.343
set_qtm_global_parameter -param hold -value 0.100
set_qtm_global_parameter -param clk_to_output -value 0.654

create_qtm_delay_arc -name CLK_TO_Q -from CLK -from_edge rise -to Q -value 0.777 -to_edge rise

save_qtm_model -format db -output QTM/ram_256x34
