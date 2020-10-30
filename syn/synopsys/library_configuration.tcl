#-------------------------------------- Definidos en el archivo .synopsys.setup
#
# set_target_library "/opt/EDA_install/cell_libs/tcbn65lp_200a/digital/Front_End/timing_power_noise/NLDM/tcbn65lp_200a/tcbn65lplt.db"
# set search_path "$search_path $RV_ROOT/design/lib"
# set search_path "$search_path $RV_ROOT/design/include"
# set search_path "$search_path $RV_ROOT/design/dmi"
# set search_path "$search_path $RV_ROOT/configs/snapshots/default"

#---------------------------------------------------- Librerias con modelos QTM
# Estas librerias han sido creadas para paliar la ausencia de modelos de memoria

lappend link_library "./QTM/ram_2048x39.db"
lappend link_library "./QTM/ram_64x21.db"
lappend link_library "./QTM/ram_256x34.db"
