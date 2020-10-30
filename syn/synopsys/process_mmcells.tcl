#################################################################################################
# Function definition to clean up the remaining TIEHI/LO cells
#################################################################################################

proc subs_logic_constants {} {
  upvar 1 TIEHI_MM_LIB TIEHI_MM_LIB
  upvar 1 TIELO_MM_LIB TIELO_MM_LIB
  echo $TIELO_MM_LIB

  set TIECELLS [get_cell * -filter "ref_name==TIEH || ref_name==TIEL || name==Logic0 || name==Logic1"]
  set TIECELLS [add_to_collection -unique $TIECELLS [get_cell -of [get_pins -filter "pin_name==**logic_0**"]]]
  set TIECELLS [add_to_collection -unique $TIECELLS [get_cell -of [get_pins -filter "pin_name==**logic_1**"]]]

  if {[sizeof_collection $TIECELLS]!=0} {
    echo "Hola"
    foreach_in_collection TIECELL $TIECELLS {
      set TIECELL_NET [get_net -of [get_pins -of $TIECELL]]
      set TIECELL_PINS [get_pins -of $TIECELL_NET -filter "pin_direction==in"]
      set TIECELL_PORTS [get_port -of $TIECELL_NET]

      # Replace connections to pins
      if {[sizeof_collection $TIECELL_PINS]!=0} {
        foreach_in_collection TIECELL_PIN $TIECELL_PINS {
          set TIECELL_CELL_NAME [get_attribute [get_cell -of $TIECELL_PIN] "name"]
          set TIECELL_PIN_NAME [get_attribute [get_pin $TIECELL_PIN] "pin_name"]
          disconnect_net $TIECELL_NET $TIECELL_PIN
          if {[get_attribute $TIECELL ref_name]=="TIEL" || [get_attribute $TIECELL name]=="Logic0" || [get_attribute [get_pins -of $TIECELL] pin_name]=="**logic_0**"} {
            create_cell mm_$TIECELL_CELL_NAME\_$TIECELL_PIN_NAME\_Kcell0 $TIELO_MM_LIB/TIEL
            set MM_PIN [get_pins mm_$TIECELL_CELL_NAME\_$TIECELL_PIN_NAME\_Kcell0/ZN]
            create_net mm_$TIECELL_CELL_NAME\_$TIECELL_PIN_NAME\_Knet0
            set MM_NET [get_net mm_$TIECELL_CELL_NAME\_$TIECELL_PIN_NAME\_Knet0]
            connect_net $MM_NET $MM_PIN
            connect_net $MM_NET $TIECELL_PIN
          } elseif {[get_attribute $TIECELL ref_name]=="TIEH" || [get_attribute $TIECELL name]=="Logic1" || [get_attribute [get_pins -of $TIECELL] pin_name]=="**logic_1**"} {
            create_cell mm_$TIECELL_CELL_NAME\_$TIECELL_PIN_NAME\_Kcell1 $TIEHI_MM_LIB/TIEH
            set MM_PIN [get_pins mm_$TIECELL_CELL_NAME\_$TIECELL_PIN_NAME\_Kcell1/Z]
            create_net mm_$TIECELL_CELL_NAME\_$TIECELL_PIN_NAME\_Knet1
            set MM_NET [get_net mm_$TIECELL_CELL_NAME\_$TIECELL_PIN_NAME\_Knet1]
            connect_net $MM_NET $MM_PIN
            connect_net $MM_NET $TIECELL_PIN
          } else {
            echo "ERROR: Tie net not connected to any tie cell"
          }
        }
      }

      # Replace connections to ports
      if {[sizeof_collection $TIECELL_PORTS]!=0} {
        foreach_in_collection TIECELL_PORT $TIECELL_PORTS {
          set TIECELL_PORT_NAME [get_attribute [get_port $TIECELL_PORT] "name"]
          disconnect_net $TIECELL_NET $TIECELL_PORT
          if {[get_attribute $TIECELL ref_name]=="TIEL" || [get_attribute $TIECELL name]=="Logic0" || [get_attribute [get_pins -of $TIECELL] pin_name]=="**logic_0**"} {
            create_cell mm_$TIECELL_PORT_NAME\_Kcell0 $TIELO_MM_LIB/TIEL
            set MM_PIN [get_pins mm_$TIECELL_PORT_NAME\_Kcell0/ZN]
            create_net mm_$TIECELL_PORT_NAME\_Knet0
            set MM_NET [get_net mm_$TIECELL_PORT_NAME\_Knet0]
            connect_net $MM_NET $MM_PIN
            connect_net $MM_NET $TIECELL_PORT
          } elseif {[get_attribute $TIECELL ref_name]=="TIEH" || [get_attribute $TIECELL name]=="Logic1" || [get_attribute [get_pins -of $TIECELL] pin_name]=="**logic_1**"} {
            create_cell mm_$TIECELL_PORT_NAME\_Kcell1 $TIEHI_MM_LIB/TIEH
            set MM_PIN [get_pins mm_$TIECELL_PORT_NAME\_Kcell1/Z]
            create_net mm_$TIECELL_PORT_NAME\_Knet1
            set MM_NET [get_net mm_$TIECELL_PORT_NAME\_Knet1]
            connect_net $MM_NET $MM_PIN
            connect_net $MM_NET $TIECELL_PORT
          } else {
            echo "ERROR: Tie net not connected to any tie cell"
          }
        }
      }
      if {[sizeof_collection $TIECELL_NET]!=0} {
        disconnect_net $TIECELL_NET [get_pins -of $TIECELL]
        remove_net $TIECELL_NET
      }
    }
    remove_cell $TIECELLS
    set_dont_touch [get_cell "*" -filter "ref_name==TIEL||ref_name==TIEH"]
  }
}
#################################################################################################

current_design [get_designs "swerv_wrapper"]
link

#################################################################################################
# Defining the Metalmaskable TIE cell library
#################################################################################################
set TIEHI_MM_LIB "tcbn65lplt"
set TIELO_MM_LIB "tcbn65lplt"

#################################################################################################
# Iterize over the designs to find constan logic values (either 0 or 1) and substite them by MM cells
#################################################################################################
set designs [get_designs *]
foreach_in_collection design $designs {
  current_design $design >> ${logFile}.log
  subs_logic_constants   >> ${logFile}.log
}

current_design  [get_designs "swerv_wrapper"]