create_clock -name clk [get_ports clk] -period 1 -waveform {0 0.5}
set_propagated_clock [get_clocks {clk}]

set_clock_uncertainty -setup  0.35 [get_clocks {clk}]
set_clock_uncertainty -hold  0.15 [get_clocks {clk}]
set_clock_transition -rise  0.2 [get_clocks {clk}]
set_clock_transition -fall  0.2 [get_clocks {clk}]


create_clock -name jtag_tck [get_ports jtag_tck] -period 100 -waveform {0 50}
set_clock_uncertainty -setup  0.35 [get_clocks {jtag_tck}]
set_clock_uncertainty -hold  0.15 [get_clocks {jtag_tck}]
set_clock_transition -rise  0.2 [get_clocks {jtag_tck}]
set_clock_transition -fall  0.2 [get_clocks {jtag_tck}]


set_false_path -from jtag_tck -to {clk}
set_false_path -from clk -to {jtag_tck}


# set_input_delay    5.5 -clock [get_clocks {clk}] -max [get_pins {io_cells/_txd0/PAD}]
# set_input_delay    0   -clock [get_clocks {clk}] -min [get_pins {io_cells/_txd0/PAD}]

set_input_delay    5.5 -clock [get_clocks {clk}] -max [get_pins {*}]
set_input_delay    0   -clock [get_clocks {clk}] -min [get_pins {*}]


#set_output_delay   2.5 -clock [get_clocks {clk}] -max [get_pins {io_cells/_rxd0/PAD}]
#set_output_delay  -0.5 -clock [get_clocks {CLK_PLL}] -min [get_pins {io_cells/_rxd0/PAD}]
set_output_delay   2.5 -clock [get_clocks {clk}] -max [get_pins {*}]
set_output_delay  -0.5 -clock [get_clocks {clk}] -min [get_pins {*}]

set_max_area 0

propagate_constraints

# En modo topographical no se definen
#set_wire_load_mode
#set_wire_load_model