# WARNING: Genus uses picoseconds and femtofarads as units but the commands should be in nanoseconds
create_clock [get_ports -nocase clk] -name clk -domain clk_domain -period 1 -waveform {0 0.5}

#No necesario propagar reloj en genus

set_clock_uncertainty -setup 0.35 [get_clocks {clk}]
set_clock_uncertainty -hold  0.15 [get_clocks {clk}]
set_clock_transition  -rise   0.2 [get_clocks {clk}]
set_clock_transition  -fall   0.2 [get_clocks {clk}]


create_clock [get_ports jtag_tck] -name jtag_tck -domain jtag_domain -period 100 -waveform {0 50}
set_clock_uncertainty -setup 0.35 [get_clocks {jtag_tck}]
set_clock_uncertainty -hold  0.15 [get_clocks {jtag_tck}]
set_clock_transition -rise    0.2 [get_clocks {jtag_tck}]
set_clock_transition -fall    0.2 [get_clocks {jtag_tck}]

set_false_path -from jtag_tck -to clk
set_false_path -from clk -to jtag_tck

set_input_delay    5.5 -clock [get_clocks {clk}] -max [get_pins {*}]
set_input_delay    0   -clock [get_clocks {clk}] -min [get_pins {*}]

set_output_delay   2.5 -clock [get_clocks {clk}] -max [get_pins {*}]
set_output_delay  -0.5 -clock [get_clocks {clk}] -min [get_pins {*}]

#set_max_area 0

check_constraints

