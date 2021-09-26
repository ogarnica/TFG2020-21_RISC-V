set PADCELL WIRECELL_EXT_CSF_FC_LIN
set warningMessage "Warning: Port w/o nets ===>"

set ports [get_ports]
# En el caso de buscar solo inputs or outputs
#set ports [all_inputs]
if {[sizeof_collection $ports]!=0} {
    foreach_in_collection port $ports {
	# El siguiente codigo es para depuracion
	#set idx [expr {$idx+1}]
	#puts $idx
	set net [get_net -of_objects $port]
	# Solo si hay nets conectadas al puerto
	if {[sizeof_collection $net] ==0} {
	    puts "$warningMessage [get_object_name $port]"
	} else {
	    set netPins [get_pins -of_objects $net]
	    set netName [get_logical_name $net]
	    set padName i\_$PADCELL\_$netName
	    set padNetName pad\_$netName
	    disconnect $netPins
	    disconnect $port 
	    create_inst -name $padName $PADCELL "swerv_wrapper"
	    connect $port $padName/ANAIOPAD -remove_multi_driver
	    connect -net_name $padNetName $padName/ANAIO $netPins -remove_multi_driver
	}
    }
}

# En el caso de buscar solo outputs
# set ports [all_outputs]
# if {[sizeof_collection $ports]!=0} {
#    foreach_in_collection port $ports {
# 	set net [get_net -of_objects [get_ports $port]]
# 	# Solo si hay nets conectadas al puerto
# 	if {[sizeof_collection $net] !=0} {
# 	    set netPins [get_pins -of_objects $net]
# 	    set netName [get_logical_name $net]
# 	    set padName i\_$PADCELL\_$netName
# 	    set padNetName pad\_$netName
# 	    disconnect $netPins
# 	    disconnect $port 
# 	    create_inst -name $padName $PADCELL "swerv_wrapper"
# 	    connect $port $padName/ANAIOPAD -remove_multi_driver
# 	    connect -net_name $padNetName $padName/ANAIO $netPins -remove_multi_driver
# 	}
#     }
# }

