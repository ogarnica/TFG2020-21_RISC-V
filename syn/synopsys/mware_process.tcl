
current_design MW_full_add_cell
set_map_only cell
set_max_area 0
compile
#* set_map_only cell false */

current_design MW_mux_cell
set_map_only cell
set_max_area 0
compile
#* set_map_only cell false */

current_design full_adder_cell
set_map_only u1
set_max_area 0
compile
#* set_map_only u1 false */

foreach mw_cell {MW_and MW_buf MW_ff MW_ff_scan MW_full_add MW_half_add MW_inv MW_mux MW_nand MW_nor MW_or MW_xnor MW_xor} {
  current_design $mw_cell
  compile
  ungroup -flatten -all
}

foreach_in_collection block [get_designs "MW_csa*"] {
  current_design $block
  uniquify
  set_dont_touch [get_cell "*"]
  compile
  set_dont_touch [get_cell "*"] false
  ungroup -flatten -all
}

foreach_in_collection block [get_designs "MW_*_so*"] {
  current_design $block
  ungroup -flatten -all
#*  set_size_only find(cell,"*") */
}

foreach_in_collection block [get_designs "MW_*_mult*"] {
  current_design $block
  ungroup -flatten -all
#*  set_size_only find(cell,"*") */
}

foreach_in_collection block [get_designs "MW_*_mac*"] {
  current_design $block
  ungroup -flatten -all
#*  set_size_only find(cell,"*") */
}
